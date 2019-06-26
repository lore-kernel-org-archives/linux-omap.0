From: Roger Quadros via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: SATA broken with LPAE
Date: Wed, 26 Jun 2019 11:43:59 +0300
Message-ID: <16f065ef-f4ac-46b4-de2a-6b5420ae873a@ti.com>
Reply-To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: hch-jcswGhMUV9g@public.gmane.org, "hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>, martin.petersen-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Christoph / Hans,

SATA has been broken on TI platforms with LPAE, on systems with RAM addresses > 32-bits,
(e.g. DRA7 rev.H+) since v4.18.

The commit at which it breaks is
21e07dba9fb1179148089d611fc9e6e70d1887c3 ("scsi: reduce use of block bounce buffers").

The effect is that the SATA controller starts to see DMA addresses
above 32-bit which it does not support.

Could you please shed some light on how it is supposed to work if
we don't call blk_queue_bounce_limit() for devices that can do only 32-bit DMA
on a system that has addressable RAM above 32-bit Physical?

The below patch fixes it. Is this the right thing to do?

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 3aab2e3d57f3..b925dc54cfa5 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -62,6 +62,9 @@ static int ahci_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
 		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
 
+	if (of_device_is_compatible(dev->of_node, "snps,dwc-ahci"))
+		hpriv->flags |= AHCI_HFLAG_32BIT_ONLY;
+
 	port = acpi_device_get_match_data(dev);
 	if (!port)
 		port = &ahci_port_info;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 65d0a10c76ad..9083c7b89dfc 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1750,6 +1750,21 @@ static int scsi_map_queues(struct blk_mq_tag_set *set)
 	return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
 }
 
+static u64 scsi_calculate_bounce_limit(struct Scsi_Host *shost)
+{
+	struct device *dma_dev = shost->dma_dev;
+	u64 bounce_limit = 0xffffffff;
+
+	if (shost->unchecked_isa_dma)
+		return BLK_BOUNCE_ISA;
+
+	if (dma_dev && dma_dev->dma_mask)
+		bounce_limit = (u64)dma_max_pfn(dma_dev) << PAGE_SHIFT;
+
+	return bounce_limit;
+}
+
 void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 {
 	struct device *dev = shost->dma_dev;
@@ -1769,8 +1784,7 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 	}
 
 	blk_queue_max_hw_sectors(q, shost->max_sectors);
-	if (shost->unchecked_isa_dma)
-		blk_queue_bounce_limit(q, BLK_BOUNCE_ISA);
+	blk_queue_bounce_limit(q, scsi_calculate_bounce_limit(shost));
 	blk_queue_segment_boundary(q, shost->dma_boundary);
 	dma_set_seg_boundary(dev, shost->dma_boundary);

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
