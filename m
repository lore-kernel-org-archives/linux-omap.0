From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/7] omap: Beagle: revision detection
Date: Fri, 24 Sep 2010 17:27:08 -0700
Message-ID: <20100925002708.24551.96708.stgit@baageli.muru.com>
References: <20100925002608.24551.67183.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61377 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab0IYA1F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 20:27:05 -0400
In-Reply-To: <20100925002608.24551.67183.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>

From: Robert Nelson <robertcnelson@gmail.com>

Due to the omap3530 ES3.0 Silicon being used on both the
B5/B6 and C1/2/3 Beagle we can't use the cpu_is_omap34xx()
routines to differentiate the Beagle Boards.

However gpio pins 171,172,173 where setup for this prupose, so
lets use them.

Changes:
for older U-Boot's, use omap_mux_init_gpio()
keep Beagle Rev in board-omap3beagle.c
gpio_free on gpio request failure

Tested on Beagle Revisions: B5, C2, C4, and xMA

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   88 +++++++++++++++++++++++++++++++
 1 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 87969c7..1aebb3f 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -50,6 +50,93 @@
 
 #define NAND_BLOCK_SIZE		SZ_128K
 
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
+	OMAP3BEAGLE_BOARD_UNKN = 0,
+	OMAP3BEAGLE_BOARD_AXBX,
+	OMAP3BEAGLE_BOARD_C1_3,
+	OMAP3BEAGLE_BOARD_C4,
+	OMAP3BEAGLE_BOARD_XM,
+};
+
+static u8 omap3_beagle_version;
+
+static u8 omap3_beagle_get_rev(void)
+{
+	return omap3_beagle_version;
+}
+
+static void __init omap3_beagle_init_rev(void)
+{
+	int ret;
+	u16 beagle_rev = 0;
+
+	omap_mux_init_gpio(171, OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_gpio(172, OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_gpio(173, OMAP_PIN_INPUT_PULLUP);
+
+	ret = gpio_request(171, "rev_id_0");
+	if (ret < 0)
+		goto fail0;
+
+	ret = gpio_request(172, "rev_id_1");
+	if (ret < 0)
+		goto fail1;
+
+	ret = gpio_request(173, "rev_id_2");
+	if (ret < 0)
+		goto fail2;
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
+		omap3_beagle_version = OMAP3BEAGLE_BOARD_UNKN;
+	}
+
+	return;
+
+fail2:
+	gpio_free(172);
+fail1:
+	gpio_free(171);
+fail0:
+	printk(KERN_ERR "Unable to get revision detection GPIO pins\n");
+	omap3_beagle_version = OMAP3BEAGLE_BOARD_UNKN;
+
+	return;
+}
+
 static struct mtd_partition omap3beagle_nand_partitions[] = {
 	/* All the partition sizes are listed in terms of NAND block size */
 	{
@@ -464,6 +551,7 @@ static struct omap_musb_board_data musb_board_data = {
 static void __init omap3_beagle_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+	omap3_beagle_init_rev();
 	omap3_beagle_i2c_init();
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));

