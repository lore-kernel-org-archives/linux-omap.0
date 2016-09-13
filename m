From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] usb: musb: Fix unbalanced platform_disable
Date: Mon, 12 Sep 2016 20:18:05 -0700
Message-ID: <20160913031805.m5nzyqyclh4pyj6k@atomide.com>
References: <20160912153947.k4gnggur6usyujii@atomide.com>
 <20160912165455.GE18340@uda0271908>
 <20160912171938.5fmx2qi6xtzsohpy@atomide.com>
 <20160912173406.6qalsmolsylc2suq@atomide.com>
 <20160912200530.69cb195d@aktux>
 <20160912183552.GA9372@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160912183552.GA9372@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160912 11:36]:
> On Mon, Sep 12, 2016 at 08:05:30PM +0200, Andreas Kemnade wrote:
> > Hmm, then the question is: Couldn't the X_musb_disable simply be called
> > from X_probe if needed to be an the safe side?
> 
> In general, we try not to do so if all possible. We want to put common
> code in the core, not repleat them in glue layers.
> 
> In this specific case, we cannot do it. For example in dsps glue, the
> musb reset is done in dsps_musb_init(), so no place in dsps_probe() to
> call dsps_musb_disable().

OK yeah if we need to do something, then disabling the irq in
musb_core.c until we're done should be enough.

Anyways, I tested the $subject patch also with am35x code with the
following patch and no issues. So I've now tested with omap3,
omap4, am335x, and am35x.

There are also am35x musb device tree patches from last year by
Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>:

https://patchwork.kernel.org/project/linux-omap/list/?submitter=144061

And we now have new drivers/phy/phy-da8xx-usb.c that might be the
same phy on am35x except with register bits moved around.

So maybe we'll have it working with device tree quite easily.
Meanwhile, we should probably apply the following patch so we
get things working again.

Regards,

Tony

8< --------------------------
diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -90,5 +90,10 @@
 	status = "disabled";
 };
 
+/* Only on 34xx/36xx */
+&usb_otg_hs {
+	status = "disabled";
+};
+
 /include/ "am35xx-clocks.dtsi"
 /include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -12,6 +12,7 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/usb/musb.h>
 #include <linux/of_platform.h>
 #include <linux/ti_wilink_st.h>
 #include <linux/wl12xx.h>
@@ -38,6 +39,7 @@
 #include "omap-secure.h"
 #include "soc.h"
 #include "hsmmc.h"
+#include "usb.h"
 
 static struct omap_hsmmc_platform_data __maybe_unused mmc_pdata[2];
 
@@ -261,9 +263,39 @@ static void __init omap3_sbc_t3517_legacy_init(void)
 	omap3_sbc_t3517_wifi_init();
 }
 
+static struct omap_musb_board_data am3517_musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_ULPI,
+	.mode			= MUSB_OTG,
+	.power			= 500,
+	.set_phy_power		= am35x_musb_phy_power,
+	.clear_irq		= am35x_musb_clear_irq,
+	.set_mode		= am35x_set_mode,
+	.reset			= am35x_musb_reset,
+};
+
+static __init void am3517_evm_musb_init(void)
+{
+	u32 devconf2;
+
+	/*
+	 * Set up USB clock/mode in the DEVCONF2 register.
+	 */
+	devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
+
+	/* USB2.0 PHY reference clock is 13 MHz */
+	devconf2 &= ~(CONF2_REFFREQ | CONF2_OTGMODE | CONF2_PHY_GPIOMODE);
+	devconf2 |=  CONF2_REFFREQ_13MHZ | CONF2_SESENDEN | CONF2_VBDTCTEN
+		| CONF2_DATPOL;
+
+	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
+
+	usb_musb_init(&am3517_musb_board_data);
+}
+
 static void __init am3517_evm_legacy_init(void)
 {
 	am35xx_emac_reset();
+	am3517_evm_musb_init();
 }
 
 static struct platform_device omap3_rom_rng_device = {
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -82,8 +82,13 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
-	oh_name = "usb_otg_hs";
-	name = "musb-omap2430";
+	if (soc_is_am35xx()) {
+		oh_name = "am35x_otg_hs";
+		name = "musb-am35x";
+	} else {
+		oh_name = "usb_otg_hs";
+		name = "musb-omap2430";
+	}
 
         oh = omap_hwmod_lookup(oh_name);
         if (WARN(!oh, "%s: could not find omap_hwmod for %s\n",
diff --git a/arch/arm/mach-omap2/usb.h b/arch/arm/mach-omap2/usb.h
--- a/arch/arm/mach-omap2/usb.h
+++ b/arch/arm/mach-omap2/usb.h
@@ -1,3 +1,6 @@
+#ifndef __ARCH_ARM_MACH_OMAP2_USB_H
+#define __ARCH_ARM_MACH_OMAP2_USB_H
+
 #include <linux/platform_data/usb-omap.h>
 
 /* AM35x */
@@ -22,37 +25,6 @@
 #define CONF2_OTGPWRDN		(1 << 2)
 #define CONF2_DATPOL		(1 << 1)
 
-/* TI81XX specific definitions */
-#define USBCTRL0	0x620
-#define USBSTAT0	0x624
-
-/* TI816X PHY controls bits */
-#define TI816X_USBPHY0_NORMAL_MODE	(1 << 0)
-#define TI816X_USBPHY_REFCLK_OSC	(1 << 8)
-
-/* TI814X PHY controls bits */
-#define USBPHY_CM_PWRDN		(1 << 0)
-#define USBPHY_OTG_PWRDN	(1 << 1)
-#define USBPHY_CHGDET_DIS	(1 << 2)
-#define USBPHY_CHGDET_RSTRT	(1 << 3)
-#define USBPHY_SRCONDM		(1 << 4)
-#define USBPHY_SINKONDP		(1 << 5)
-#define USBPHY_CHGISINK_EN	(1 << 6)
-#define USBPHY_CHGVSRC_EN	(1 << 7)
-#define USBPHY_DMPULLUP		(1 << 8)
-#define USBPHY_DPPULLUP		(1 << 9)
-#define USBPHY_CDET_EXTCTL	(1 << 10)
-#define USBPHY_GPIO_MODE	(1 << 12)
-#define USBPHY_DPOPBUFCTL	(1 << 13)
-#define USBPHY_DMOPBUFCTL	(1 << 14)
-#define USBPHY_DPINPUT		(1 << 15)
-#define USBPHY_DMINPUT		(1 << 16)
-#define USBPHY_DPGPIO_PD	(1 << 17)
-#define USBPHY_DMGPIO_PD	(1 << 18)
-#define USBPHY_OTGVDET_EN	(1 << 19)
-#define USBPHY_OTGSESSEND_EN	(1 << 20)
-#define USBPHY_DATA_POLARITY	(1 << 23)
