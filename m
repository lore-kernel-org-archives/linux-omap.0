From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/16] omap: mux: Make omap2 FS USB code use new mux functions
Date: Wed, 30 Jun 2010 15:07:10 +0300
Message-ID: <20100630120710.2637.93333.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52051 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab0F3MHA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 08:07:00 -0400
In-Reply-To: <20100630120226.2637.31198.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

Make omap2 FS USB code use new mux functions. Do not mux usb2_tllse0
as it has multiple options.

Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-fs.c |   33 ++++++++++++++++++---------------
 1 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-fs.c b/arch/arm/mach-omap2/usb-fs.c
index a445519..a216d88 100644
--- a/arch/arm/mach-omap2/usb-fs.c
+++ b/arch/arm/mach-omap2/usb-fs.c
@@ -30,7 +30,6 @@
 #include <asm/irq.h>
 
 #include <plat/control.h>
-#include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/board.h>
 
@@ -40,6 +39,8 @@
 #define INT_USB_IRQ_HGEN	INT_24XX_USB_IRQ_HGEN
 #define INT_USB_IRQ_OTG		INT_24XX_USB_IRQ_OTG
 
+#include "mux.h"
+
 #if defined(CONFIG_ARCH_OMAP2)
 
 #ifdef	CONFIG_USB_GADGET_OMAP
@@ -209,13 +210,13 @@ static u32 __init omap2_usb0_init(unsigned nwires, unsigned is_device)
 		return 0;
 
 	if (is_device)
-		omap_cfg_reg(J20_24XX_USB0_PUEN);
+		omap_mux_init_signal("usb0_puen", 0);
 
-	omap_cfg_reg(K18_24XX_USB0_DAT);
-	omap_cfg_reg(K19_24XX_USB0_TXEN);
-	omap_cfg_reg(J14_24XX_USB0_SE0);
+	omap_mux_init_signal("usb0_dat", 0);
+	omap_mux_init_signal("usb0_txen", 0);
+	omap_mux_init_signal("usb0_se0", 0);
 	if (nwires != 3)
-		omap_cfg_reg(J18_24XX_USB0_RCV);
+		omap_mux_init_signal("usb0_rcv", 0);
 
 	switch (nwires) {
 	case 3:
@@ -228,8 +229,8 @@ static u32 __init omap2_usb0_init(unsigned nwires, unsigned is_device)
 		break;
 	case 6:
 		syscon1 = 3;
-		omap_cfg_reg(J19_24XX_USB0_VP);
-		omap_cfg_reg(K20_24XX_USB0_VM);
+		omap_mux_init_signal("usb0_vp", 0);
+		omap_mux_init_signal("usb0_vm", 0);
 		omap2_usb_devconf_set(0, USB_UNIDIR);
 		break;
 	default:
@@ -289,12 +290,12 @@ static u32 __init omap2_usb2_init(unsigned nwires, unsigned alt_pingroup)
 	if (alt_pingroup || nwires == 0)
 		return 0;
 
-	omap_cfg_reg(Y11_24XX_USB2_DAT);
-	omap_cfg_reg(AA10_24XX_USB2_SE0);
+	omap_mux_init_signal("usb2_dat", 0);
+	omap_mux_init_signal("usb2_se0", 0);
 	if (nwires > 2)
-		omap_cfg_reg(AA12_24XX_USB2_TXEN);
+		omap_mux_init_signal("usb2_txen", 0);
 	if (nwires > 3)
-		omap_cfg_reg(AA6_24XX_USB2_RCV);
+		omap_mux_init_signal("usb2_rcv", 0);
 
 	switch (nwires) {
 	case 2:
@@ -313,11 +314,13 @@ static u32 __init omap2_usb2_init(unsigned nwires, unsigned alt_pingroup)
 		omap2_usb_devconf_set(2, USB_BIDIR);
 		break;
 	case 5:
-		omap_cfg_reg(AA4_24XX_USB2_TLLSE0);
-		/* NOTE: board-specific code must override this setting if
-		 * this TLL link is not using DP/DM.  Something must also
+		/* NOTE: board-specific code must mux this setting depending
+		 * on TLL link using DP/DM.  Something must also
 		 * set up OTG_SYSCON2.HMC_TLL{ATTACH,SPEED}
+		 * 2420: hdq_sio.usb2_tllse0 or vlynq_rx0.usb2_tllse0
+		 * 2430: hdq_sio.usb2_tllse0 or sdmmc2_dat0.usb2_tllse0
 		 */
+
 		syscon1 = 3;
 		omap2_usb2_enable_5pinunitll();
 		break;

