From: Steve Sakoman <sakoman@gmail.com>
Subject: [PATCH/RFC] ARM: OMAP: Initialize MADC clock divider and clock
Date: Sat, 30 May 2009 06:40:35 -0700
Message-ID: <5e088bd90905300640sc9837b4x6055c5c262c18a8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:48254 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbZE3Nqh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 May 2009 09:46:37 -0400
Received: by qw-out-2122.google.com with SMTP id 5so4387342qwd.37
        for <linux-omap@vger.kernel.org>; Sat, 30 May 2009 06:46:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Though the comment in clocks_init claims to initialize the MADC
clocks, it wasn't actually being done.  This patch implements minimal
MADC clock initialization.

Compile/run tested on Overo (prior to patch MADC access would always timeout)

diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
index 769b34b..c5ca36d 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -159,6 +159,7 @@

 /* Few power values */
 #define R_CFG_BOOT			0x05
+#define R_GPBR1				0x0C
 #define R_PROTECT_KEY			0x0E

 /* access control values for R_PROTECT_KEY */
@@ -166,6 +167,10 @@
 #define KEY_UNLOCK2			0xec
 #define KEY_LOCK			0x00

+/* MADC clock values for R_GPBR1 */
+#define MADC_HFCLK_EN			0x80
+#define DEFAULT_MADC_CLK_EN		0x10
+
 /* some fields in R_CFG_BOOT */
 #define HFCLK_FREQ_19p2_MHZ		(1 << 0)
 #define HFCLK_FREQ_26_MHZ		(2 << 0)
@@ -717,6 +722,11 @@ static void __init clocks_init(struct device *dev)
 	ctrl |= HIGH_PERF_SQ;
 	e |= unprotect_pm_master();
 	/* effect->MADC+USB ck en */
+
+	if (twl_has_madc())
+		e |= twl4030_i2c_write_u8(TWL4030_MODULE_INTBR,
+				MADC_HFCLK_EN | DEFAULT_MADC_CLK_EN, R_GPBR1);
+
 	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
 	e |= protect_pm_master();
