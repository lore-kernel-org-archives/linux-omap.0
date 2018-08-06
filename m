From: Ralf Goebel <ralf.goebel-XQ0Z+IutXF4FoECaAgFIynS5uNuOjpZe@public.gmane.org>
Subject: [PATCH] iommu/omap: Fix cache flushes on L2 table entries
Date: Mon,  6 Aug 2018 17:00:36 +0200
Message-ID: <20180806150036.14644-1-ralf.goebel@imago-technologies.com>
References: <7c58d42f-cb11-129a-6e04-45319443f1bb@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <7c58d42f-cb11-129a-6e04-45319443f1bb-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Suman Anna' <s-anna-l0cyMroinI0@public.gmane.org>, 'Joerg Roedel' <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Ralf Goebel <ralf.goebel-XQ0Z+IutXF4FoECaAgFIynS5uNuOjpZe@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'KISHON VIJAY ABRAHAM' <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The base address used for DMA operations on the second-level table
did incorrectly include the offset for the table entry. The offset
was then added again which lead to incorrect behavior.

Operations on the L1 table are not affected.

The calculation of the base address is changed to point to the
beginning of the L2 table.

Fixes: bfee0cf0ee1d ("iommu/omap: Use DMA-API for performing cache flushes")
Acked-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Signed-off-by: Ralf Goebel <ralf.goebel-XQ0Z+IutXF4FoECaAgFIynS5uNuOjpZe@public.gmane.org>
---

Changes in v2: Rephrase patch summary and description

 drivers/iommu/omap-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index af4a8e7fcd27..3b05117118c3 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -550,7 +550,7 @@ static u32 *iopte_alloc(struct omap_iommu *obj, u32 *iopgd,
 
 pte_ready:
 	iopte = iopte_offset(iopgd, da);
-	*pt_dma = virt_to_phys(iopte);
+	*pt_dma = iopgd_page_paddr(iopgd);
 	dev_vdbg(obj->dev,
 		 "%s: da:%08x pgd:%p *pgd:%08x pte:%p *pte:%08x\n",
 		 __func__, da, iopgd, *iopgd, iopte, *iopte);
@@ -738,7 +738,7 @@ static size_t iopgtable_clear_entry_core(struct omap_iommu *obj, u32 da)
 		}
 		bytes *= nent;
 		memset(iopte, 0, nent * sizeof(*iopte));
-		pt_dma = virt_to_phys(iopte);
+		pt_dma = iopgd_page_paddr(iopgd);
 		flush_iopte_range(obj->dev, pt_dma, pt_offset, nent);
 
 		/*
-- 
2.11.0
