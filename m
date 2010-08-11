From: Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH v2 1/3] ARM: OMAP: Beagle: revision detection
Date: Wed, 11 Aug 2010 18:37:40 -0500
Message-ID: <1281569862-19894-1-git-send-email-robertcnelson@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62193 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757391Ab0HKXhx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 19:37:53 -0400
Received: by gyg10 with SMTP id 10so193617gyg.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 16:37:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>

Due to the omap3530 ES3.0 Silicon being used on both the
B5/B6 and C1/2/3 Beagle we can't use the cpu_is_omap34xx() 
routines to differentiate the Beagle Boards.

However gpio pins 171,172,173 where setup for this prupose, so 
lets use them.

Tested on Beagle Revisions: B5, C2, C4, and xMA

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   60 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/board.h |   23 ++++++++++++
 2 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 87969c7..e470336 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -50,6 +50,65 @@
 
 #define NAND_BLOCK_SIZE		SZ_128K
 
+static u8 omap3_beagle_version;
+
+u8 get_omap3_beagle_rev(void)
+{
+	return omap3_beagle_version;
+}
+EXPORT_SYMBOL(get_omap3_beagle_rev);
+
+static void __init omap3_beagle_get_revision(void)
+{
+	int ret;
+	u16 beagle_rev = 0;
+
+	ret = gpio_request(171, "rev_id_0");
+	if (ret < 0)
+		goto fail;
+
+	ret = gpio_request(172, "rev_id_1");
+	if (ret < 0)
+		goto fail;
+
+	ret = gpio_request(173, "rev_id_2");
+	if (ret < 0)
+		goto fail;
+
+	gpio_direction_input(171);
+	gpio_direction_input(172);
+	gpio_direction_input(173);
+
+	beagle_rev = gpio_get_value(171) | (gpio_get_value(172) << 1)
+			| (gpio_get_value(173) << 2);
+
+	switch (beagle_rev) {
+	case 7:
+		printk(KERN_INFO "OMAP3 Beagle Rev: Ax/Bx\n");
+		omap3_beagle_version = OMAP3BEAGLE_BOARD_AXBX;
+		break;
+	case 6:
+		printk(KERN_INFO "OMAP3 Beagle Rev: C1/C2/C3\n");
+		omap3_beagle_version = OMAP3BEAGLE_BOARD_C1_3;
+		break;
+	case 5:
+		printk(KERN_INFO "OMAP3 Beagle Rev: C4\n");
+		omap3_beagle_version = OMAP3BEAGLE_BOARD_C4;
+		break;
+	case 0:
+		printk(KERN_INFO "OMAP3 Beagle Rev: xM\n");
+		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
+		break;
+	default:
+		printk(KERN_INFO "OMAP3 Beagle Rev: unknown %hd\n", beagle_rev);
+		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
+	}
+
+	return;
+fail:
+	printk(KERN_ERR "Unable to get revision detection GPIO pins\n");
+}
+
 static struct mtd_partition omap3beagle_nand_partitions[] = {
 	/* All the partition sizes are listed in terms of NAND block size */
 	{
@@ -464,6 +523,7 @@ static struct omap_musb_board_data musb_board_data = {
 static void __init omap3_beagle_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+	omap3_beagle_get_revision();
 	omap3_beagle_i2c_init();
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index 3cf4fa2..e55a920 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -26,6 +26,22 @@ enum {
 	OMAP3EVM_BOARD_GEN_2,		/* EVM Rev >= Rev E */
 };
 
+/*
+ * OMAP3 Beagle revision
+ * Run time detection of Beagle revision is done by reading GPIO.
+ * GPIO ID -
+ *	AXBX	= GPIO173, GPIO172, GPIO171: 1 1 1
+ *	C1_3	= GPIO173, GPIO172, GPIO171: 1 1 0
+ *	C4	= GPIO173, GPIO172, GPIO171: 1 0 1
+ *	XM	= GPIO173, GPIO172, GPIO171: 0 0 0
+ */
+enum {
+	OMAP3BEAGLE_BOARD_AXBX = 0,
+	OMAP3BEAGLE_BOARD_C1_3,
+	OMAP3BEAGLE_BOARD_C4,
+	OMAP3BEAGLE_BOARD_XM,
+};
+
 /* Different peripheral ids */
 #define OMAP_TAG_CLOCK		0x4f01
 #define OMAP_TAG_LCD		0x4f05
@@ -173,4 +189,11 @@ u8 get_omap3_evm_rev(void);
 #else
 #define get_omap3_evm_rev() (-EINVAL)
 #endif
+
+/* Beagle revision */
+#if defined(CONFIG_MACH_OMAP3_BEAGLE)
+u8 get_omap3_beagle_rev(void);
+#else
+#define get_omap3_beagle_rev() (-EINVAL)
+#endif
 #endif
-- 
1.7.0.4

