import { prisma } from '@/lib/prisma';

export default async function handle(req, res) {
  const { id } = req.query;

  try {
    switch (req.method) {
      case 'GET':
        const contract = await prisma.contract.findUnique({
          where: { id },
          include: {
            specifications: {
              select: {
                id: true,
                name: true,
                code: true,
                unit: true,
                quantity: true,
                price: true,
                amount: true,
                section: true,
                serviceCount: true,
                actItems: {
                  select: {
                    quantity: true,
                    serviceCount: true,
                  }
                }
              }
            },
            acts: {
              select: {
                id: true,
                number: true,
                date: true,
                status: true,
                totalAmount: true,
                actItems: {
                  include: {
                    specification: true,
                  }
                }
              },
              orderBy: {
                createdAt: 'desc'
              }
            },
            vehicle: {
              select: {
                number: true,
                brand: true,
                model: true,
              }
            },
            kekv: true,
            budget: true,
          }
        });

        if (!contract) {
          return res.status(404).json({ error: 'Contract not found' });
        }

        // Подсчитываем остатки по спецификациям
        const specificationsWithRemains = contract.specifications.map(spec => {
          const usedQuantity = spec.actItems.reduce((sum, item) => sum + item.quantity, 0);
          const usedServiceCount = spec.actItems.reduce((sum, item) => sum + (item.serviceCount || 0), 0);
          
          return {
            ...spec,
            remainingQuantity: spec.quantity - usedQuantity,
            remainingServiceCount: spec.serviceCount - usedServiceCount,
            usedQuantity,
            usedServiceCount
          };
        });

        res.json({
          ...contract,
          specifications: specificationsWithRemains,
        });
        break;

      default:
        res.setHeader('Allow', ['GET']);
        res.status(405).end(`Method ${req.method} Not Allowed`);
    }
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: error.message });
  }
}
