From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 3/3] omap3evm: musb: Update power capability for OMAP3EVM (Rev >= E)
Date: Wed, 28 Oct 2009 20:42:38 +0530
Message-ID: <1256742758-32702-3-git-send-email-ajay.gupta@ti.com>
References: <1256742758-32702-1-git-send-email-ajay.gupta@ti.com>
 <1256742758-32702-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49818 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754338AbZJ1PMp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Oct 2009 11:12:45 -0400
In-Reply-To: <1256742758-32702-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Updated the MUSB power sourcing capability for OMAP3EVM (Rev >=E).

MUSB interface can source 500mA on OMAP3EVM Rev >= E while Rev < E
supports only 100mA.MUSB PHY is programmed to use external Vbus for this.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
This patch is dependent on below patch,
[PATCH] omap3evm: Add board revision function

 arch/arm/mach-omap2/usb-musb.c |    8 ++++++--
 drivers/usb/musb/musb_regs.h   |    5 +++++
 drivers/usb/musb/omap2430.c    |    9 +++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index a80441d..529e2b1 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -148,10 +148,14 @@ static struct platform_device musb_device = {
 
 void __init usb_musb_init(void)
 {
-	if (cpu_is_omap243x())
+	if (cpu_is_omap243x()) {
 		musb_resources[0].start = OMAP243X_HS_BASE;
-	else
+	} else {
 		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
+		/* OMAP3EVM Rev >= E can source 500mA */
+		if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
+			musb_plat.power = 250;
+	}
 	musb_resources[0].end = musb_resources[0].start + SZ_8K - 1;
 
 	/*
diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index cc1d71b..a0314df 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -72,6 +72,10 @@
 #define MUSB_DEVCTL_HR		0x02
 #define MUSB_DEVCTL_SESSION	0x01
 
+/* ULPI VBUSCONTROL */
+#define ULPI_USE_EXTVBUS	0x01
+#define ULPI_USE_EXTVBUSIND	0x02
+
 /* TESTMODE */
 #define MUSB_TEST_FORCE_HOST	0x80
 #define MUSB_TEST_FIFO_ACCESS	0x40
@@ -246,6 +250,7 @@
 
 /* REVISIT: vctrl/vstatus: optional vendor utmi+phy register at 0x68 */
 #define MUSB_HWVERS		0x6C	/* 8 bit */
+#define MUSB_ULPI_BUSCONTROL	0x70	/* 8 bit */
 
 #define MUSB_EPINFO		0x78	/* 8 bit */
 #define MUSB_RAMINFO		0x79	/* 8 bit */
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 6761d20..c5fcc30 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -36,6 +36,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <plat/mux.h>
+#include <plat/board.h>
 
 #include "musb_core.h"
 #include "omap2430.h"
@@ -203,6 +204,7 @@ int musb_platform_set_mode(struct musb *musb, u8 musb_mode)
 int __init musb_platform_init(struct musb *musb)
 {
 	u32 l;
+	u8 val;
 
 #if defined(CONFIG_ARCH_OMAP2430)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
@@ -239,6 +241,13 @@ int __init musb_platform_init(struct musb *musb)
 	l |= ULPI_12PIN;
 	omap_writel(l, OTG_INTERFSEL);
 
+	/* Program PHY to use external Vbus supply for OMAP3EVM Rev >= E */
+	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
+		val = musb_readb(musb->mregs, MUSB_ULPI_BUSCONTROL);
+		val |= ULPI_USE_EXTVBUS;
+		musb_writeb(musb->mregs, MUSB_ULPI_BUSCONTROL, val);
+	}
+
 	pr_debug("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
 			"sysstatus 0x%x, intrfsel 0x%x, simenable  0x%x\n",
 			omap_readl(OTG_REVISION), omap_readl(OTG_SYSCONFIG),
-- 
1.6.2.4

