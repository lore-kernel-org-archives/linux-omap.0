From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/2] arm: omap: ehci: avoid compiler error with
 touchbook
Date: Wed, 10 Mar 2010 08:22:01 +0200
Message-ID: <20100310062159.GB3878@gandalf>
References: <20100304074434.GI15954@nokia.com>
 <1267688753-6344-1-git-send-email-felipe.balbi@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321CBCDFE@dbde02.ent.ti.com>
 <a05a09f453a7473f2ba54a9056589b72@secure211.sgcpanel.com>
 <20100305070330.GB12757@nokia.com>
 <20100308230422.GH2900@atomide.com>
 <20100309143020.GA12260@gandalf>
 <20100309153827.GR2900@atomide.com>
 <20100309154754.GI3851@gandalf>
 <20100310004826.GD2900@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50450 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab0CJGWJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 01:22:09 -0500
Content-Disposition: inline
In-Reply-To: <20100310004826.GD2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Felipe Balbi <felipe.balbi@nokia.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Mar 09, 2010 at 04:48:27PM -0800, Tony Lindgren wrote:
[snip]

> @@ -273,7 +273,7 @@ static void __init am3517_evm_init_irq(void)
>  	omap_gpio_init();
>  }
>  
> -static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
> +static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
>  	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
>  	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
>  	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,

[snip]

> diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
> index f1df873..2a77759 100644
> --- a/arch/arm/mach-omap2/usb-ehci.c
> +++ b/arch/arm/mach-omap2/usb-ehci.c
> @@ -213,7 +213,7 @@ static void setup_ehci_io_mux(enum ehci_hcd_omap_mode *port_mode)
>  	return;
>  }
>  
> -void __init usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata)
> +void __init usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata)
>  {
>  	platform_device_add_data(&ehci_device, pdata, sizeof(*pdata));
>  
> @@ -229,7 +229,7 @@ void __init usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata)
>  
>  #else
>  
> -void __init usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata)
> +void __init usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata)
>  
>  {
>  }
> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
> index 288e29e..568578d 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -53,7 +53,7 @@ enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
>  
>  extern void usb_musb_init(struct omap_musb_board_data *board_data);
>  
> -extern void usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata);
> +extern void usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata);
>  
>  #endif

won't this give you compile warnings ??

-- 
balbi
 

--HcAYCG3uE/tztfnV
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap-ehci-initconst.patch"

From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Thu, 4 Mar 2010 09:45:53 +0200
Subject: [PATCH] arm: omap: ehci: avoid compiler error with touchbook

the early_param() call in board-omap3touchbook.c expands to:

static const char __setup_str_early_touchbook_revision[]
	__section(.init.rodata) _aligned(1) = tbr;
[...]

and we have a non-const variable being added to the
same section:

static struct ehci_hcd_omap_platform_data ehci_pdata
__section(.init.rodata);

because of that, gcc generates a section type conflict
which can (and actually should) be avoided by marking
const every variable marked with __initconst.

This patch fixes that for the ehci_hdc_omap_platform_data.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index a101029..5822bcf 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -648,7 +648,7 @@ static void enable_board_wakeup_source(void)
 		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 4386d2b..a0a2a11 100755
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -54,7 +54,7 @@ static void enable_board_wakeup_source(void)
 		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 70c1861..6ae8805 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -273,7 +273,7 @@ static void __init am3517_evm_init_irq(void)
 	omap_gpio_init();
 }
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index afa77ca..2de4f79 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -612,7 +612,7 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata = {
+static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 3710190..5bfc13b 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -636,7 +636,7 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 9958987..4f1accf 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -442,7 +442,7 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 6eb77e1..962d377 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -410,7 +410,7 @@ static void __init omap3beagle_flash_init(void)
 	}
 }
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index d6bc88c..017bb2f 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -635,7 +635,7 @@ static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3_evm_dss_device,
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 4827f46..51a5315 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -537,7 +537,7 @@ static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_dss_device,
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 2a5bf5c..2504d41 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -493,7 +493,7 @@ static void __init omap3touchbook_flash_init(void)
 	}
 }
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 50872a4..8848c7c 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -394,7 +394,7 @@ static struct platform_device *overo_devices[] __initdata = {
 	&overo_lcd_device,
 };
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index d3e3cd5..cd3e40c 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -52,7 +52,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define board_mux	NULL
 #endif
 
-static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[0]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[1]		= EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index f1df873..2a77759 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -213,7 +213,7 @@ static void setup_ehci_io_mux(enum ehci_hcd_omap_mode *port_mode)
 	return;
 }
 
-void __init usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata)
+void __init usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata)
 {
 	platform_device_add_data(&ehci_device, pdata, sizeof(*pdata));
 
@@ -229,7 +229,7 @@ void __init usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata)
 
 #else
 
-void __init usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata)
+void __init usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata)
 
 {
 }
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 288e29e..568578d 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -53,7 +53,7 @@ enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
 
 extern void usb_musb_init(struct omap_musb_board_data *board_data);
 
-extern void usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata);
+extern void usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata);
 
 #endif
 

--HcAYCG3uE/tztfnV--
