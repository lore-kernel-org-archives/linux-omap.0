From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/4] onenand init: Debug patch to print out the onenand
	partitions from bootloader
Date: Wed, 29 Apr 2009 14:54:48 -0700
Message-ID: <20090429215447.GA12986@atomide.com>
References: <20090429214900.13138.54584.stgit@localhost> <20090429215037.13138.62993.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52283 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbZD2Vyw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 17:54:52 -0400
Content-Disposition: inline
In-Reply-To: <20090429215037.13138.62993.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind@infradead.org, linux-omap@vger.kernel.org, adrian.hunter@nokia.com


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

FYI, here's the debug patch I used to dump the ATAG partitions.

Tony

--fdj2RfSjLxBAspz7
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="dump-atag-partitions.patch"

>From b65441b89ae7003adb983ac2f225f0bc1ddfba76 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 29 Apr 2009 14:52:20 -0700
Subject: [PATCH] onenand init: Debug patch to print out the onenand partitions from bootloader

Not for merging

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index e882e4b..e69b3b2 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -726,6 +726,7 @@ static struct omap_onenand_platform_data board_onenand_data = {
 
 static void __init board_onenand_init(void)
 {
+	gpmc_set_atag_partitions(onenand_partitions, ONENAND_MAX_PARTITIONS);
 	gpmc_onenand_init(&board_onenand_data);
 }
 
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 2d53315..664b732 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -519,6 +519,7 @@ static struct omap_onenand_platform_data board_onenand_data = {
 
 static void __init board_onenand_init(void)
 {
+	gpmc_set_atag_partitions(onenand_partitions, ONENAND_MAX_PARTITIONS);
 	gpmc_onenand_init(&board_onenand_data);
 }
 
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 9f5c191..dbf2096 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -327,3 +327,30 @@ void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 		return;
 	}
 }
+
+void __init gpmc_set_atag_partitions(struct mtd_partition *parts, int nr_parts)
+{
+	const struct omap_partition_config *part;
+	int i = 0;
+
+	while ((part = omap_get_nr_config(OMAP_TAG_PARTITION,
+				struct omap_partition_config, i)) != NULL) {
+		struct mtd_partition *mpart;
+
+		mpart = parts;
+		mpart->name = (char *)part->name;
+		mpart->size = part->size;
+		mpart->offset = part->offset;
+		mpart->mask_flags = part->mask_flags;
+		printk(KERN_INFO "Partition%i\n", i);
+		printk(KERN_INFO "\t{\n");
+		printk(KERN_INFO "\t\t.name\t\t= \"%s\",\n", mpart->name);
+		printk(KERN_INFO "\t\t.offset\t\t= 0x%llx,\n", mpart->offset);
+		printk(KERN_INFO "\t\t.size\t\t= 0x%llx,\n", mpart->size);
+		printk(KERN_INFO "\t\t.mask_flags\t= 0x%x,\n",
+							mpart->mask_flags);
+		printk(KERN_INFO "\t},\n");
+		i++;
+		parts++;
+	}
+}
diff --git a/arch/arm/plat-omap/include/mach/board.h b/arch/arm/plat-omap/include/mach/board.h
index 4d8d10a..ae8c2db 100644
--- a/arch/arm/plat-omap/include/mach/board.h
+++ b/arch/arm/plat-omap/include/mach/board.h
@@ -125,6 +125,14 @@ struct omap_tmp105_config {
 	int (* set_power)(int enable);
 };
 
+struct omap_partition_config {
+	char name[16];
+	unsigned int size;
+	unsigned int offset;
+	/* same as in include/linux/mtd/partitions.h */
+	unsigned int mask_flags;
+};
+
 struct omap_flash_part_str_config {
 	char part_table[0];
 };
diff --git a/arch/arm/plat-omap/include/mach/onenand.h b/arch/arm/plat-omap/include/mach/onenand.h
index 2a391fa..f6a5320 100644
--- a/arch/arm/plat-omap/include/mach/onenand.h
+++ b/arch/arm/plat-omap/include/mach/onenand.h
@@ -30,6 +30,8 @@ int omap2_onenand_rephase(void);
 #if defined(CONFIG_MTD_ONENAND_OMAP2) || defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
 
 extern void gpmc_onenand_init(struct omap_onenand_platform_data *d);
+extern void gpmc_set_atag_partitions(struct mtd_partition *parts,
+								int nr_parts);
 
 #else
 
@@ -43,5 +45,10 @@ static inline void gpmc_onenand_init(struct omap_onenand_platform_data *d)
 {
 }
 
+static inline void gpmc_set_atag_partitions(struct mtd_partition *parts,
+								int nr_parts)
+{
+}
+
 #endif
 #endif

--fdj2RfSjLxBAspz7--
