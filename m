From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: usb_nop_xceiv_register() missing when OTG built as modules
Date: Wed, 26 May 2010 12:23:50 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E616B60@dbde02.ent.ti.com>
References: <87635d54nn.fsf@deeprootsystems.com>
 <19F8576C6E063C45BE387C64729E7394044DB7B6BD@dbde02.ent.ti.com>
 <87eik03scn.fsf@deeprootsystems.com> <20100305090426.GG12757@nokia.com>
 <871vfy3azr.fsf@deeprootsystems.com>
 <558f5bffd42210a777154737d6730232@secure211.sgcpanel.com>
 <87y6i6zatj.fsf@deeprootsystems.com> <20100522235310.GA15859@matterhorn.lan>
 <19F8576C6E063C45BE387C64729E7394044E61643A@dbde02.ent.ti.com>
 <20100526060321.GE3069@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50147 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934200Ab0EZGya convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 02:54:30 -0400
In-Reply-To: <20100526060321.GE3069@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>, Kevin Hilman <khilman@deeprootsystems.com>, "me@felipebalbi.com" <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

> ps: you really think that adding more and more ifdefs is better than
> Amit's patch ??

We can avoid using #ifdefs by introducing '.neednop' flag to board_data.
Here is the patch for this which can be used on top of my earlier patch.

------------------- cut here ---------------
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 77af4c9..fb29837 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -137,6 +137,7 @@ static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_UTMI,
 	.mode			= MUSB_PERIPHERAL,
 	.power			= 100,
+	.neednop		= 1,
 };
 
 static struct omap2_hsmmc_info mmc[] = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 83d3aa5..609f021 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -665,6 +665,7 @@ static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
 	.mode			= MUSB_OTG,
 	.power			= 100,
+	.neednop		= 1,
 };
 
 static void __init omap3_evm_init(void)
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index a32d3af..b53489a 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -69,6 +69,7 @@ struct omap_musb_board_data {
 	u8	mode;
 	u16	power;
 	unsigned extvbus:1;
+	unsigned neednop:1;	/* NOP transceiver */
 };
 
 enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index e71049c..b774312 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1964,6 +1964,7 @@ bad_config:
 	musb->board_set_power = plat->set_power;
 	musb->set_clock = plat->set_clock;
 	musb->min_power = plat->min_power;
+	musb->board_data = plat->board_data;
 
 	/* Clock usage is chip-specific ... functional clock (DaVinci,
 	 * OMAP2430), or PHY ref (some TUSB6010 boards).  All this core
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index eaabf98..b72e2e5 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -392,6 +392,7 @@ struct musb {
 	int			(*board_set_power)(int state);
 
 	int			(*set_clock)(struct clk *clk, int is_active);
+	void			*board_data;
 
 	u8			min_power;	/* vbus for periph, in mA/2 */
 
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 58acd0c..8488a23 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -198,12 +198,11 @@ int __init musb_platform_init(struct musb *musb, void *board_data)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
 #endif
 
-#if defined(CONFIG_MACH_OMAP3EVM) || defined(CONFIG_MACH_OMAP_4430SDP)
 	/* OMAP3EVM used ISP150x and OMAP4 SDP uses internal transceiver
 	 * so register nop transceiver
 	 */
-	usb_nop_xceiv_register();
-#endif
+	if (data->neednop)
+		usb_nop_xceiv_register();
 
 	/* We require some kind of external transceiver, hooked
 	 * up through ULPI.  TWL4030-family PMICs include one,
@@ -330,10 +329,10 @@ static int musb_platform_resume(struct musb *musb)
 
 int musb_platform_exit(struct musb *musb)
 {
+	struct omap_musb_board_data *data = musb->board_data;
 
 	musb_platform_suspend(musb);
-#if defined(CONFIG_MACH_OMAP3EVM) || defined(CONFIG_MACH_OMAP_4430SDP)
-	usb_nop_xceiv_unregister();
-#endif
+	if (data->neednop)
+		usb_nop_xceiv_unregister();
 	return 0;
 }

--------------------------------------------
-Ajay
> 
> --
> balbi
> 
> DefectiveByDesign.org
