From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] omap: Separate out omap2 FS USB platform init functions
Date: Tue, 29 Jun 2010 14:54:11 +0300
Message-ID: <20100629115411.17702.19570.stgit@baageli.muru.com>
References: <20100629115056.17702.56622.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57350 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab0F2LyC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 07:54:02 -0400
In-Reply-To: <20100629115056.17702.56622.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

We want to split old FS USB platform init code and stop doing pin multiplexing
under plat-omap. First move 24xx specific init code into omap2_usb[012]_init
functions.

Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/usb.c |  252 +++++++++++++++++++++++++++++-----------------
 1 files changed, 157 insertions(+), 95 deletions(-)

diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index d3bf17c..9c4929a 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -115,15 +115,56 @@ static void omap2_usb2_enable_5pinunitll(void)
 	omap_ctrl_writel(r, OMAP2_CONTROL_DEVCONF0);
 }
 
+static u32 __init omap2_usb0_init(unsigned nwires, unsigned is_device)
+{
+	u32	syscon1 = 0;
+
+	omap2_usb_devconf_clear(0, USB_BIDIR_TLL);
+
+	if (nwires == 0)
+		return 0;
+
+	if (is_device)
+		omap_cfg_reg(J20_24XX_USB0_PUEN);
+
+	omap_cfg_reg(K18_24XX_USB0_DAT);
+	omap_cfg_reg(K19_24XX_USB0_TXEN);
+	omap_cfg_reg(J14_24XX_USB0_SE0);
+	if (nwires != 3)
+		omap_cfg_reg(J18_24XX_USB0_RCV);
+
+	switch (nwires) {
+	case 3:
+		syscon1 = 2;
+		omap2_usb_devconf_set(0, USB_BIDIR);
+		break;
+	case 4:
+		syscon1 = 1;
+		omap2_usb_devconf_set(0, USB_BIDIR);
+		break;
+	case 6:
+		syscon1 = 3;
+		omap_cfg_reg(J19_24XX_USB0_VP);
+		omap_cfg_reg(K20_24XX_USB0_VM);
+		omap2_usb_devconf_set(0, USB_UNIDIR);
+		break;
+	default:
+		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
+			0, nwires);
+	}
+
+	return syscon1 << 16;
+}
+
 static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 {
 	u32	syscon1 = 0;
 
 	if (cpu_is_omap24xx())
-		omap2_usb_devconf_clear(0, USB_BIDIR_TLL);
+		return omap2_usb0_init(nwires, is_device);
 
 	if (nwires == 0) {
-		if (cpu_class_is_omap1() && !cpu_is_omap15xx()) {
+		if (!cpu_is_omap15xx()) {
 			u32 l;
 
 			/* pulldown D+/D- */
@@ -135,9 +176,7 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 	}
 
 	if (is_device) {
-		if (cpu_is_omap24xx())
-			omap_cfg_reg(J20_24XX_USB0_PUEN);
-		else if (cpu_is_omap7xx()) {
+		if (cpu_is_omap7xx()) {
 			omap_cfg_reg(AA17_7XX_USB_DM);
 			omap_cfg_reg(W16_7XX_USB_PU_EN);
 			omap_cfg_reg(W17_7XX_USB_VBUSI);
@@ -147,8 +186,7 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 			omap_cfg_reg(W4_USB_PUEN);
 	}
 
-	/* internal transceiver (unavailable on 17xx, 24xx) */
-	if (!cpu_class_is_omap2() && nwires == 2) {
+	if (nwires == 2) {
 		u32 l;
 
 		// omap_cfg_reg(P9_USB_DP);
@@ -183,26 +221,18 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 		return 0;
 	}
 
-	if (cpu_is_omap24xx()) {
-		omap_cfg_reg(K18_24XX_USB0_DAT);
-		omap_cfg_reg(K19_24XX_USB0_TXEN);
-		omap_cfg_reg(J14_24XX_USB0_SE0);
-		if (nwires != 3)
-			omap_cfg_reg(J18_24XX_USB0_RCV);
-	} else {
-		omap_cfg_reg(V6_USB0_TXD);
-		omap_cfg_reg(W9_USB0_TXEN);
-		omap_cfg_reg(W5_USB0_SE0);
-		if (nwires != 3)
-			omap_cfg_reg(Y5_USB0_RCV);
-	}
+	omap_cfg_reg(V6_USB0_TXD);
+	omap_cfg_reg(W9_USB0_TXEN);
+	omap_cfg_reg(W5_USB0_SE0);
+	if (nwires != 3)
+		omap_cfg_reg(Y5_USB0_RCV);
 
 	/* NOTE:  SPEED and SUSP aren't configured here.  OTG hosts
 	 * may be able to use I2C requests to set those bits along
 	 * with VBUS switching and overcurrent detection.
 	 */
 
-	if (cpu_class_is_omap1() && nwires != 6) {
+	if (nwires != 6) {
 		u32 l;
 
 		l = omap_readl(USB_TRANSCEIVER_CTRL);
@@ -213,21 +243,13 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 	switch (nwires) {
 	case 3:
 		syscon1 = 2;
-		if (cpu_is_omap24xx())
-			omap2_usb_devconf_set(0, USB_BIDIR);
 		break;
 	case 4:
 		syscon1 = 1;
-		if (cpu_is_omap24xx())
-			omap2_usb_devconf_set(0, USB_BIDIR);
 		break;
 	case 6:
 		syscon1 = 3;
-		if (cpu_is_omap24xx()) {
-			omap_cfg_reg(J19_24XX_USB0_VP);
-			omap_cfg_reg(K20_24XX_USB0_VM);
-			omap2_usb_devconf_set(0, USB_UNIDIR);
-		} else {
+		{
 			u32 l;
 
 			omap_cfg_reg(AA9_USB0_VP);
@@ -244,30 +266,66 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 	return syscon1 << 16;
 }
 
+static u32 __init omap2_usb1_init(unsigned nwires)
+{
+	u32	syscon1 = 0;
+
+	omap2_usb_devconf_clear(1, USB_BIDIR_TLL);
+
+	if (nwires == 0)
+		return 0;
+
+	/* NOTE:  board-specific code must set up pin muxing for usb1,
+	 * since each signal could come out on either of two balls.
+	 */
+
+	switch (nwires) {
+	case 2:
+		/* NOTE: board-specific code must override this setting if
+		 * this TLL link is not using DP/DM
+		 */
+		syscon1 = 1;
+		omap2_usb_devconf_set(1, USB_BIDIR_TLL);
+		break;
+	case 3:
+		syscon1 = 2;
+		omap2_usb_devconf_set(1, USB_BIDIR);
+		break;
+	case 4:
+		syscon1 = 1;
+		omap2_usb_devconf_set(1, USB_BIDIR);
+		break;
+	case 6:
+	default:
+		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
+			1, nwires);
+	}
+
+	return syscon1 << 20;
+}
+
 static u32 __init omap_usb1_init(unsigned nwires)
 {
 	u32	syscon1 = 0;
 
-	if (cpu_class_is_omap1() && !cpu_is_omap15xx() && nwires != 6) {
+	if (cpu_is_omap24xx())
+		return omap2_usb1_init(nwires);
+
+	if (!cpu_is_omap15xx() && nwires != 6) {
 		u32 l;
 
 		l = omap_readl(USB_TRANSCEIVER_CTRL);
 		l &= ~CONF_USB1_UNI_R;
 		omap_writel(l, USB_TRANSCEIVER_CTRL);
 	}
-	if (cpu_is_omap24xx())
-		omap2_usb_devconf_clear(1, USB_BIDIR_TLL);
-
 	if (nwires == 0)
 		return 0;
 
 	/* external transceiver */
-	if (cpu_class_is_omap1()) {
-		omap_cfg_reg(USB1_TXD);
-		omap_cfg_reg(USB1_TXEN);
-		if (nwires != 3)
-			omap_cfg_reg(USB1_RCV);
-	}
+	omap_cfg_reg(USB1_TXD);
+	omap_cfg_reg(USB1_TXEN);
+	if (nwires != 3)
+		omap_cfg_reg(USB1_RCV);
 
 	if (cpu_is_omap15xx()) {
 		omap_cfg_reg(USB1_SEO);
@@ -280,10 +338,6 @@ static u32 __init omap_usb1_init(unsigned nwires)
 	} else if (cpu_is_omap1710()) {
 		omap_cfg_reg(R13_1710_USB1_SE0);
 		// SUSP
-	} else if (cpu_is_omap24xx()) {
-		/* NOTE:  board-specific code must set up pin muxing for usb1,
-		 * since each signal could come out on either of two balls.
-		 */
 	} else {
 		pr_debug("usb%d cpu unrecognized\n", 1);
 		return 0;
@@ -291,27 +345,14 @@ static u32 __init omap_usb1_init(unsigned nwires)
 
 	switch (nwires) {
 	case 2:
-		if (!cpu_is_omap24xx())
-			goto bad;
-		/* NOTE: board-specific code must override this setting if
-		 * this TLL link is not using DP/DM
-		 */
-		syscon1 = 1;
-		omap2_usb_devconf_set(1, USB_BIDIR_TLL);
-		break;
+		goto bad;
 	case 3:
 		syscon1 = 2;
-		if (cpu_is_omap24xx())
-			omap2_usb_devconf_set(1, USB_BIDIR);
 		break;
 	case 4:
 		syscon1 = 1;
-		if (cpu_is_omap24xx())
-			omap2_usb_devconf_set(1, USB_BIDIR);
 		break;
 	case 6:
-		if (cpu_is_omap24xx())
-			goto bad;
 		syscon1 = 3;
 		omap_cfg_reg(USB1_VP);
 		omap_cfg_reg(USB1_VM);
@@ -331,20 +372,70 @@ bad:
 	return syscon1 << 20;
 }
 
-static u32 __init omap_usb2_init(unsigned nwires, unsigned alt_pingroup)
+static u32 __init omap2_usb2_init(unsigned nwires, unsigned alt_pingroup)
 {
 	u32	syscon1 = 0;
 
-	if (cpu_is_omap24xx()) {
-		omap2_usb2_disable_5pinbitll();
-		alt_pingroup = 0;
+	omap2_usb2_disable_5pinbitll();
+	alt_pingroup = 0;
+
+	/* NOTE omap1 erratum: must leave USB2_UNI_R set if usb0 in use */
+	if (alt_pingroup || nwires == 0)
+		return 0;
+
+	omap_cfg_reg(Y11_24XX_USB2_DAT);
+	omap_cfg_reg(AA10_24XX_USB2_SE0);
+	if (nwires > 2)
+		omap_cfg_reg(AA12_24XX_USB2_TXEN);
+	if (nwires > 3)
+		omap_cfg_reg(AA6_24XX_USB2_RCV);
+
+	switch (nwires) {
+	case 2:
+		/* NOTE: board-specific code must override this setting if
+		 * this TLL link is not using DP/DM
+		 */
+		syscon1 = 1;
+		omap2_usb_devconf_set(2, USB_BIDIR_TLL);
+		break;
+	case 3:
+		syscon1 = 2;
+		omap2_usb_devconf_set(2, USB_BIDIR);
+		break;
+	case 4:
+		syscon1 = 1;
+		omap2_usb_devconf_set(2, USB_BIDIR);
+		break;
+	case 5:
+		omap_cfg_reg(AA4_24XX_USB2_TLLSE0);
+		/* NOTE: board-specific code must override this setting if
+		 * this TLL link is not using DP/DM.  Something must also
+		 * set up OTG_SYSCON2.HMC_TLL{ATTACH,SPEED}
+		 */
+		syscon1 = 3;
+		omap2_usb2_enable_5pinunitll();
+		break;
+	case 6:
+	default:
+		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
+			2, nwires);
 	}
 
+	return syscon1 << 24;
+}
+
+static u32 __init omap_usb2_init(unsigned nwires, unsigned alt_pingroup)
+{
+	u32	syscon1 = 0;
+
+	if (cpu_is_omap24xx())
+		return omap2_usb2_init(nwires, alt_pingroup);
+
 	/* NOTE omap1 erratum: must leave USB2_UNI_R set if usb0 in use */
 	if (alt_pingroup || nwires == 0)
 		return 0;
 
-	if (cpu_class_is_omap1() && !cpu_is_omap15xx() && nwires != 6) {
+	if (!cpu_is_omap15xx() && nwires != 6) {
 		u32 l;
 
 		l = omap_readl(USB_TRANSCEIVER_CTRL);
@@ -367,53 +458,24 @@ static u32 __init omap_usb2_init(unsigned nwires, unsigned alt_pingroup)
 		if (nwires != 3)
 			omap_cfg_reg(Y5_USB2_RCV);
 		// FIXME omap_cfg_reg(USB2_SPEED);
-	} else if (cpu_is_omap24xx()) {
-		omap_cfg_reg(Y11_24XX_USB2_DAT);
-		omap_cfg_reg(AA10_24XX_USB2_SE0);
-		if (nwires > 2)
-			omap_cfg_reg(AA12_24XX_USB2_TXEN);
-		if (nwires > 3)
-			omap_cfg_reg(AA6_24XX_USB2_RCV);
 	} else {
 		pr_debug("usb%d cpu unrecognized\n", 1);
 		return 0;
 	}
-	// if (cpu_class_is_omap1()) omap_cfg_reg(USB2_SUSP);
+	// omap_cfg_reg(USB2_SUSP);
 
 	switch (nwires) {
 	case 2:
-		if (!cpu_is_omap24xx())
-			goto bad;
-		/* NOTE: board-specific code must override this setting if
-		 * this TLL link is not using DP/DM
-		 */
-		syscon1 = 1;
-		omap2_usb_devconf_set(2, USB_BIDIR_TLL);
-		break;
+		goto bad;
 	case 3:
 		syscon1 = 2;
-		if (cpu_is_omap24xx())
-			omap2_usb_devconf_set(2, USB_BIDIR);
 		break;
 	case 4:
 		syscon1 = 1;
-		if (cpu_is_omap24xx())
-			omap2_usb_devconf_set(2, USB_BIDIR);
 		break;
 	case 5:
-		if (!cpu_is_omap24xx())
-			goto bad;
-		omap_cfg_reg(AA4_24XX_USB2_TLLSE0);
-		/* NOTE: board-specific code must override this setting if
-		 * this TLL link is not using DP/DM.  Something must also
-		 * set up OTG_SYSCON2.HMC_TLL{ATTACH,SPEED}
-		 */
-		syscon1 = 3;
-		omap2_usb2_enable_5pinunitll();
-		break;
+		goto bad;
 	case 6:
-		if (cpu_is_omap24xx())
-			goto bad;
 		syscon1 = 3;
 		if (cpu_is_omap15xx()) {
 			omap_cfg_reg(USB2_VP);

