From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH/RFC] ARM: OMAP: unlock flash device during boot
Date: Wed, 17 Oct 2007 15:25:26 -0700
Message-ID: <20071017222526.493688502@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

The bootloader may lock the flash device upon booting.  This requires
the use of 'flash_unlock' on each partition before using them.

However, when booting from flash the MTD driver is unable to "mark
space as dirty" since the device is locked.  This results lots of boot
warnings from the MTD layer.

The MTD driver for OMAP needs to unlock the device during init so
booting from flash can work without errors.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 drivers/mtd/maps/omap_nor.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6.21/drivers/mtd/maps/omap_nor.c
===================================================================
--- linux-2.6.21.orig/drivers/mtd/maps/omap_nor.c
+++ linux-2.6.21/drivers/mtd/maps/omap_nor.c
@@ -108,6 +108,10 @@ static int __devinit omapflash_probe(str
 	}
 	info->mtd->owner = THIS_MODULE;
 
+	/* Unlock the flash device. */
+	if (info->mtd->unlock)
+		info->mtd->unlock(info->mtd, 0, info->mtd->size);
+
 #ifdef CONFIG_MTD_PARTITIONS
 	err = parse_mtd_partitions(info->mtd, part_probes, &info->parts, 0);
 	if (err > 0)
--
