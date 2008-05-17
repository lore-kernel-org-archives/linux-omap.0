From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/5] USB: Change omap USB code to use omap_read/write
	instead of __REG for multi-omap
Date: Sat, 17 May 2008 13:19:00 +0300
Message-ID: <20080517101857.GA17642@kedavra.cpe.vivax.com.br>
References: <1210972076-23911-1-git-send-email-tony@atomide.com> <1210972076-23911-2-git-send-email-tony@atomide.com> <1210972076-23911-3-git-send-email-tony@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35297 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbYEQKSY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 May 2008 06:18:24 -0400
Content-Disposition: inline
In-Reply-To: <1210972076-23911-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, david-b@pacbell.net, felipe.balbi@nokia.com

On Fri, May 16, 2008 at 02:07:53PM -0700, Tony Lindgren wrote:
> Change omap USB code to use omap_read/write instead of __REG for multi-omap

Well, I'll try them all on monday but i like the idea :-)

And this will also help me (a bit) converting twl4030 to platform_device
and use __raw_read/write() later.

> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap1/board-osk.c  |    7 +-
>  arch/arm/plat-omap/usb.c         |  138 ++++++++----
>  drivers/cbus/tahvo-usb.c         |   91 +++++---
>  drivers/i2c/chips/isp1301_omap.c |  163 ++++++++-----
>  drivers/i2c/chips/twl4030-usb.c  |   39 ++--
>  drivers/usb/gadget/omap_udc.c    |  471 +++++++++++++++++++++-----------------
>  drivers/usb/gadget/omap_udc.h    |   61 +++---
>  drivers/usb/host/ohci-omap.c     |    5 +-
>  include/asm-arm/arch-omap/usb.h  |   23 +-
>  9 files changed, 592 insertions(+), 406 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
> index a66505f..f2c47b9 100644
> --- a/arch/arm/mach-omap1/board-osk.c
> +++ b/arch/arm/mach-omap1/board-osk.c
> @@ -526,6 +526,8 @@ static void __init osk_mistral_init(void) { }
>  
>  static void __init osk_init(void)
>  {
> +	u32 l;
> +
>  	/* Workaround for wrong CS3 (NOR flash) timing
>  	 * There are some U-Boot versions out there which configure
>  	 * wrong CS3 memory timings. This mainly leads to CRC
> @@ -539,7 +541,10 @@ static void __init osk_init(void)
>  	platform_add_devices(osk5912_devices, ARRAY_SIZE(osk5912_devices));
>  	omap_board_config = osk_config;
>  	omap_board_config_size = ARRAY_SIZE(osk_config);
> -	USB_TRANSCEIVER_CTRL_REG |= (3 << 1);
> +
> +	l = omap_readl(USB_TRANSCEIVER_CTRL);
> +	l |= (3 << 1);
> +	omap_writel(l, USB_TRANSCEIVER_CTRL);
>  
>  	/* irq for tps65010 chip */
>  	/* bootloader effectively does:  omap_cfg_reg(U19_1610_MPUIO1); */
> diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
> index a619475..9ebf318 100644
> --- a/arch/arm/plat-omap/usb.c
> +++ b/arch/arm/plat-omap/usb.c
> @@ -156,8 +156,12 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
>  
>  	if (nwires == 0) {
>  		if (cpu_class_is_omap1() && !cpu_is_omap15xx()) {
> +			u32 l;
> +
>  			/* pulldown D+/D- */
> -			USB_TRANSCEIVER_CTRL_REG &= ~(3 << 1);
> +			l = omap_readl(USB_TRANSCEIVER_CTRL);
> +			l &= ~(3 << 1);
> +			omap_writel(l, USB_TRANSCEIVER_CTRL);
>  		}
>  		return 0;
>  	}
> @@ -171,6 +175,8 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
>  
>  	/* internal transceiver (unavailable on 17xx, 24xx) */
>  	if (!cpu_class_is_omap2() && nwires == 2) {
> +		u32 l;
> +
>  		// omap_cfg_reg(P9_USB_DP);
>  		// omap_cfg_reg(R8_USB_DM);
>  
> @@ -185,9 +191,15 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
>  		 *  - OTG support on this port not yet written
>  		 */
>  
> -		USB_TRANSCEIVER_CTRL_REG &= ~(7 << 4);
> -		if (!is_device)
> -			USB_TRANSCEIVER_CTRL_REG |= (3 << 1);
> +		l = omap_readl(USB_TRANSCEIVER_CTRL);
> +		l &= ~(7 << 4);
> +		omap_writel(l, USB_TRANSCEIVER_CTRL);
> +
> +		if (!is_device) {
> +			l = omap_readl(USB_TRANSCEIVER_CTRL);
> +			l |= (3 << 1);
> +			omap_writel(l, USB_TRANSCEIVER_CTRL);
> +		}
>  
>  		return 3 << 16;
>  	}
> @@ -217,8 +229,13 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
>  	 * with VBUS switching and overcurrent detection.
>  	 */
>  
> -	if (cpu_class_is_omap1() && nwires != 6)
> -		USB_TRANSCEIVER_CTRL_REG &= ~CONF_USB2_UNI_R;
> +	if (cpu_class_is_omap1() && nwires != 6) {
> +		u32 l;
> +
> +		l = omap_readl(USB_TRANSCEIVER_CTRL);
> +		l &= ~CONF_USB2_UNI_R;
> +		omap_writel(l, USB_TRANSCEIVER_CTRL);
> +	}
>  
>  	switch (nwires) {
>  	case 3:
> @@ -238,9 +255,13 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
>  			omap_cfg_reg(K20_24XX_USB0_VM);
>  			omap2_usb_devconf_set(0, USB_UNIDIR);
>  		} else {
> +			u32 l;
> +
>  			omap_cfg_reg(AA9_USB0_VP);
>  			omap_cfg_reg(R9_USB0_VM);
> -			USB_TRANSCEIVER_CTRL_REG |= CONF_USB2_UNI_R;
> +			l = omap_readl(USB_TRANSCEIVER_CTRL);
> +			l |= CONF_USB2_UNI_R;
> +			omap_writel(l, USB_TRANSCEIVER_CTRL);
>  		}
>  		break;
>  	default:
> @@ -254,8 +275,13 @@ static u32 __init omap_usb1_init(unsigned nwires)
>  {
>  	u32	syscon1 = 0;
>  
> -	if (cpu_class_is_omap1() && !cpu_is_omap15xx() && nwires != 6)
> -		USB_TRANSCEIVER_CTRL_REG &= ~CONF_USB1_UNI_R;
> +	if (cpu_class_is_omap1() && !cpu_is_omap15xx() && nwires != 6) {
> +		u32 l;
> +
> +		l = omap_readl(USB_TRANSCEIVER_CTRL);
> +		l &= ~CONF_USB1_UNI_R;
> +		omap_writel(l, USB_TRANSCEIVER_CTRL);
> +	}
>  	if (cpu_is_omap24xx())
>  		omap2_usb_devconf_clear(1, USB_BIDIR_TLL);
>  
> @@ -316,8 +342,13 @@ static u32 __init omap_usb1_init(unsigned nwires)
>  		syscon1 = 3;
>  		omap_cfg_reg(USB1_VP);
>  		omap_cfg_reg(USB1_VM);
> -		if (!cpu_is_omap15xx())
> -			USB_TRANSCEIVER_CTRL_REG |= CONF_USB1_UNI_R;
> +		if (!cpu_is_omap15xx()) {
> +			u32 l;
> +
> +			l = omap_readl(USB_TRANSCEIVER_CTRL);
> +			l |= CONF_USB1_UNI_R;
> +			omap_writel(l, USB_TRANSCEIVER_CTRL);
> +		}
>  		break;
>  	default:
>  bad:
> @@ -340,8 +371,13 @@ static u32 __init omap_usb2_init(unsigned nwires, unsigned alt_pingroup)
>  	if (alt_pingroup || nwires == 0)
>  		return 0;
>  
> -	if (cpu_class_is_omap1() && !cpu_is_omap15xx() && nwires != 6)
> -		USB_TRANSCEIVER_CTRL_REG &= ~CONF_USB2_UNI_R;
> +	if (cpu_class_is_omap1() && !cpu_is_omap15xx() && nwires != 6) {
> +		u32 l;
> +
> +		l = omap_readl(USB_TRANSCEIVER_CTRL);
> +		l &= ~CONF_USB2_UNI_R;
> +		omap_writel(l, USB_TRANSCEIVER_CTRL);
> +	}
>  
>  	/* external transceiver */
>  	if (cpu_is_omap15xx()) {
> @@ -410,9 +446,13 @@ static u32 __init omap_usb2_init(unsigned nwires, unsigned alt_pingroup)
>  			omap_cfg_reg(USB2_VP);
>  			omap_cfg_reg(USB2_VM);
>  		} else {
> +			u32 l;
> +
>  			omap_cfg_reg(AA9_USB2_VP);
>  			omap_cfg_reg(R9_USB2_VM);
> -			USB_TRANSCEIVER_CTRL_REG |= CONF_USB2_UNI_R;
> +			l = omap_readl(USB_TRANSCEIVER_CTRL);
> +			l |= CONF_USB2_UNI_R;
> +			omap_writel(l, USB_TRANSCEIVER_CTRL);
>  		}
>  		break;
>  	default:
> @@ -531,10 +571,6 @@ static struct platform_device otg_device = {
>  
>  /*-------------------------------------------------------------------------*/
>  
> -#define ULPD_CLOCK_CTRL_REG	__REG16(ULPD_CLOCK_CTRL)
> -#define ULPD_SOFT_REQ_REG	__REG16(ULPD_SOFT_REQ)
> -
> -
>  // FIXME correct answer depends on hmc_mode,
>  // as does (on omap1) any nonzero value for config->otg port number
>  #ifdef	CONFIG_USB_GADGET_OMAP
> @@ -550,17 +586,17 @@ static struct platform_device otg_device = {
>  void __init
>  omap_otg_init(struct omap_usb_config *config)
>  {
> -	u32		syscon = OTG_SYSCON_1_REG & 0xffff;
> +	u32		syscon;
>  	int		status;
>  	int		alt_pingroup = 0;
>  
>  	/* NOTE:  no bus or clock setup (yet?) */
>  
> -	syscon = OTG_SYSCON_1_REG & 0xffff;
> +	syscon = omap_readl(OTG_SYSCON_1) & 0xffff;
>  	if (!(syscon & OTG_RESET_DONE))
>  		pr_debug("USB resets not complete?\n");
>  
> -	// OTG_IRQ_EN_REG = 0;
> +	//omap_writew(0, OTG_IRQ_EN);
>  
>  	/* pin muxing and transceiver pinouts */
>  	if (config->pins[0] > 2)	/* alt pingroup 2 */
> @@ -568,8 +604,8 @@ omap_otg_init(struct omap_usb_config *config)
>  	syscon |= omap_usb0_init(config->pins[0], is_usb0_device(config));
>  	syscon |= omap_usb1_init(config->pins[1]);
>  	syscon |= omap_usb2_init(config->pins[2], alt_pingroup);
> -	pr_debug("OTG_SYSCON_1_REG = %08x\n", syscon);
> -	OTG_SYSCON_1_REG = syscon;
> +	pr_debug("OTG_SYSCON_1 = %08x\n", omap_readl(OTG_SYSCON_1));
> +	omap_writel(syscon, OTG_SYSCON_1);
>  
>  	syscon = config->hmc_mode;
>  	syscon |= USBX_SYNCHRO | (4 << 16) /* B_ASE0_BRST */;
> @@ -578,9 +614,10 @@ omap_otg_init(struct omap_usb_config *config)
>  		syscon |= OTG_EN;
>  #endif
>  	if (cpu_class_is_omap1())
> -		pr_debug("USB_TRANSCEIVER_CTRL_REG = %03x\n", USB_TRANSCEIVER_CTRL_REG);
> -	pr_debug("OTG_SYSCON_2_REG = %08x\n", syscon);
> -	OTG_SYSCON_2_REG = syscon;
> +		pr_debug("USB_TRANSCEIVER_CTRL = %03x\n",
> +			 omap_readl(USB_TRANSCEIVER_CTRL));
> +	pr_debug("OTG_SYSCON_2 = %08x\n", omap_readl(OTG_SYSCON_2));
> +	omap_writel(syscon, OTG_SYSCON_2);
>  
>  	printk("USB: hmc %d", config->hmc_mode);
>  	if (!alt_pingroup)
> @@ -597,12 +634,22 @@ omap_otg_init(struct omap_usb_config *config)
>  	printk("\n");
>  
>  	if (cpu_class_is_omap1()) {
> +		u16 w;
> +
>  		/* leave USB clocks/controllers off until needed */
> -		ULPD_SOFT_REQ_REG &= ~SOFT_USB_CLK_REQ;
> -		ULPD_CLOCK_CTRL_REG &= ~USB_MCLK_EN;
> -		ULPD_CLOCK_CTRL_REG |= DIS_USB_PVCI_CLK;
> +		w = omap_readw(ULPD_SOFT_REQ);
> +		w &= ~SOFT_USB_CLK_REQ;
> +		omap_writew(w, ULPD_SOFT_REQ);
> +
> +		w = omap_readw(ULPD_CLOCK_CTRL);
> +		w &= ~USB_MCLK_EN;
> +		omap_writew(w, ULPD_CLOCK_CTRL);
> +
> +		w = omap_readw(ULPD_CLOCK_CTRL);
> +		w |= DIS_USB_PVCI_CLK;
> +		omap_writew(w, ULPD_CLOCK_CTRL);
>  	}
> -	syscon = OTG_SYSCON_1_REG;
> +	syscon = omap_readl(OTG_SYSCON_1);
>  	syscon |= HST_IDLE_EN|DEV_IDLE_EN|OTG_IDLE_EN;
>  
>  #ifdef	CONFIG_USB_GADGET_OMAP
> @@ -639,8 +686,8 @@ omap_otg_init(struct omap_usb_config *config)
>  			pr_debug("can't register OTG device, %d\n", status);
>  	}
>  #endif
> -	pr_debug("OTG_SYSCON_1_REG = %08x\n", syscon);
> -	OTG_SYSCON_1_REG = syscon;
> +	pr_debug("OTG_SYSCON_1 = %08x\n", omap_readl(OTG_SYSCON_1));
> +	omap_writel(syscon, OTG_SYSCON_1);
>  
>  	status = 0;
>  }
> @@ -653,18 +700,19 @@ static inline void omap_otg_init(struct omap_usb_config *config) {}
>  
>  #ifdef	CONFIG_ARCH_OMAP15XX
>  
> -#define ULPD_DPLL_CTRL_REG	__REG16(ULPD_DPLL_CTRL)
> +/* ULPD_DPLL_CTRL */
>  #define DPLL_IOB		(1 << 13)
>  #define DPLL_PLL_ENABLE		(1 << 4)
>  #define DPLL_LOCK		(1 << 0)
>  
> -#define ULPD_APLL_CTRL_REG	__REG16(ULPD_APLL_CTRL)
> +/* ULPD_APLL_CTRL */
>  #define APLL_NDPLL_SWITCH	(1 << 0)
>  
>  
>  static void __init omap_1510_usb_init(struct omap_usb_config *config)
>  {
>  	unsigned int val;
> +	u16 w;
>  
>  	omap_usb0_init(config->pins[0], is_usb0_device(config));
>  	omap_usb1_init(config->pins[1]);
> @@ -685,12 +733,22 @@ static void __init omap_1510_usb_init(struct omap_usb_config *config)
>  	printk("\n");
>  
>  	/* use DPLL for 48 MHz function clock */
> -	pr_debug("APLL %04x DPLL %04x REQ %04x\n", ULPD_APLL_CTRL_REG,
> -			ULPD_DPLL_CTRL_REG, ULPD_SOFT_REQ_REG);
> -	ULPD_APLL_CTRL_REG &= ~APLL_NDPLL_SWITCH;
> -	ULPD_DPLL_CTRL_REG |= DPLL_IOB | DPLL_PLL_ENABLE;
> -	ULPD_SOFT_REQ_REG |= SOFT_UDC_REQ | SOFT_DPLL_REQ;
> -	while (!(ULPD_DPLL_CTRL_REG & DPLL_LOCK))
> +	pr_debug("APLL %04x DPLL %04x REQ %04x\n", omap_readw(ULPD_APLL_CTRL),
> +			omap_readw(ULPD_DPLL_CTRL), omap_readw(ULPD_SOFT_REQ));
> +
> +	w = omap_readw(ULPD_APLL_CTRL);
> +	w &= ~APLL_NDPLL_SWITCH;
> +	omap_writew(w, ULPD_APLL_CTRL);
> +
> +	w = omap_readw(ULPD_DPLL_CTRL);
> +	w |= DPLL_IOB | DPLL_PLL_ENABLE;
> +	omap_writew(w, ULPD_DPLL_CTRL);
> +
> +	w = omap_readw(ULPD_SOFT_REQ);
> +	w |= SOFT_UDC_REQ | SOFT_DPLL_REQ;
> +	omap_writew(w, ULPD_SOFT_REQ);
> +
> +	while (!(omap_readw(ULPD_DPLL_CTRL) & DPLL_LOCK))
>  		cpu_relax();
>  
>  #ifdef	CONFIG_USB_GADGET_OMAP
> diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
> index 11de42d..c3e1b38 100644
> --- a/drivers/cbus/tahvo-usb.c
> +++ b/drivers/cbus/tahvo-usb.c
> @@ -61,7 +61,7 @@
>  #define USBR_NSUSPEND		(1 << 1)
>  #define USBR_SEMODE		(1 << 0)
>  
> -/* bits in OTG_CTRL_REG */
> +/* bits in OTG_CTRL */
>  
>  /* Bits that are controlled by OMAP OTG and are read-only */
>  #define OTG_CTRL_OMAP_MASK	(OTG_PULLDOWN|OTG_PULLUP|OTG_DRV_VBUS|\
> @@ -117,27 +117,27 @@ static irqreturn_t omap_otg_irq(int irq, void *arg)
>  	struct tahvo_usb *tu = (struct tahvo_usb *) otg_dev->dev.driver_data;
>  	u16 otg_irq;
>  
> -	otg_irq = OTG_IRQ_SRC_REG;
> +	otg_irq = omap_readw(OTG_IRQ_SRC);
>  	if (otg_irq & OPRT_CHG) {
> -		OTG_IRQ_SRC_REG = OPRT_CHG;
> +		omap_writew(OPRT_CHG, OTG_IRQ_SRC);
>  	} else if (otg_irq & B_SRP_TMROUT) {
> -		OTG_IRQ_SRC_REG = B_SRP_TMROUT;
> +		omap_writew(B_SRP_TMROUT, OTG_IRQ_SRC);
>  	} else if (otg_irq & B_HNP_FAIL) {
> -		OTG_IRQ_SRC_REG = B_HNP_FAIL;
> +		omap_writew(B_HNP_FAIL, OTG_IRQ_SRC);
>  	} else if (otg_irq & A_SRP_DETECT) {
> -		OTG_IRQ_SRC_REG = A_SRP_DETECT;
> +		omap_writew(A_SRP_DETECT, OTG_IRQ_SRC);
>  	} else if (otg_irq & A_REQ_TMROUT) {
> -		OTG_IRQ_SRC_REG = A_REQ_TMROUT;
> +		omap_writew(A_REQ_TMROUT, OTG_IRQ_SRC);
>  	} else if (otg_irq & A_VBUS_ERR) {
> -		OTG_IRQ_SRC_REG = A_VBUS_ERR;
> +		omap_writew(A_VBUS_ERR, OTG_IRQ_SRC);
>  	} else if (otg_irq & DRIVER_SWITCH) {
> -		if ((!(OTG_CTRL_REG & OTG_DRIVER_SEL)) &&
> +		if ((!(omap_readl(OTG_CTRL) & OTG_DRIVER_SEL)) &&
>  		   tu->otg.host && tu->otg.state == OTG_STATE_A_HOST) {
>  			/* role is host */
>  			usb_bus_start_enum(tu->otg.host,
>  					   tu->otg.host->otg_port);
>  		}
> -		OTG_IRQ_SRC_REG = DRIVER_SWITCH;
> +		omap_writew(DRIVER_SWITCH, OTG_IRQ_SRC);
>  	} else
>  		return IRQ_NONE;
>  
> @@ -147,6 +147,7 @@ static irqreturn_t omap_otg_irq(int irq, void *arg)
>  
>  static int omap_otg_init(void)
>  {
> +	u32 l;
>  
>  #ifdef CONFIG_USB_OTG
>  	if (!tahvo_otg_dev) {
> @@ -154,11 +155,15 @@ static int omap_otg_init(void)
>  		return -ENODEV;
>  	}
>  #endif
> -	OTG_SYSCON_1_REG &= ~OTG_IDLE_EN;
> +
> +	l = omap_readl(OTG_SYSCON_1);
> +	l &= ~OTG_IDLE_EN;
> +	omap_writel(l, OTG_SYSCON_1);
>  	udelay(100);
>  
>  	/* some of these values are board-specific... */
> -	OTG_SYSCON_2_REG |= OTG_EN
> +	l = omap_readl(OTG_SYSCON_2);
> +	l |= OTG_EN
>  		/* for B-device: */
>  		| SRP_GPDATA		/* 9msec Bdev D+ pulse */
>  		| SRP_GPDVBUS		/* discharge after VBUS pulse */
> @@ -167,11 +172,15 @@ static int omap_otg_init(void)
>  		| (0 << 20)		/* 200ms nominal A_WAIT_VRISE timer */
>  		| SRP_DPW		/* detect 167+ns SRP pulses */
>  		| SRP_DATA | SRP_VBUS;	/* accept both kinds of SRP pulse */
> +	omap_writel(l, OTG_SYSCON_2);
>  
> -	OTG_IRQ_EN_REG = DRIVER_SWITCH | OPRT_CHG
> +	omap_writew(DRIVER_SWITCH | OPRT_CHG
>  			| B_SRP_TMROUT | B_HNP_FAIL
> -			| A_VBUS_ERR | A_SRP_DETECT | A_REQ_TMROUT;
> -	OTG_SYSCON_2_REG |= OTG_EN;
> +				  | A_VBUS_ERR | A_SRP_DETECT | A_REQ_TMROUT,
> +					OTG_IRQ_EN);
> +	l = omap_readl(OTG_SYSCON_2);
> +	l |= OTG_EN;
> +	omap_writel(l, OTG_SYSCON_2);
>  
>  	return 0;
>  }
> @@ -271,6 +280,8 @@ static void check_vbus_state(struct tahvo_usb *tu)
>  
>  	reg = tahvo_read_reg(TAHVO_REG_IDSR);
>  	if (reg & 0x01) {
> +		u32 l;
> +
>  		vbus_active = 1;
>  		switch (tu->otg.state) {
>  		case OTG_STATE_B_IDLE:
> @@ -279,7 +290,10 @@ static void check_vbus_state(struct tahvo_usb *tu)
>  				usb_gadget_vbus_connect(tu->otg.gadget);
>  			/* Set B-session valid and not B-sessio ended to indicate
>  			 * Vbus to be ok. */
> -			OTG_CTRL_REG = (OTG_CTRL_REG & ~OTG_BSESSEND) | OTG_BSESSVLD;
> +			l = omap_readl(OTG_CTRL);
> +			l &= ~OTG_BSESSEND;
> +			l |= OTG_BSESSVLD;
> +			omap_writel(l, OTG_CTRL);
>  
>  			tu->otg.state = OTG_STATE_B_PERIPHERAL;
>  			break;
> @@ -323,10 +337,10 @@ static void tahvo_usb_become_host(struct tahvo_usb *tu)
>  	 * also mark the A-session is always valid */
>  	omap_otg_init();
>  
> -	l = OTG_CTRL_REG;
> -	l &= ~(OTG_CTRL_XCVR_MASK|OTG_CTRL_SYS_MASK);
> +	l = omap_readl(OTG_CTRL);
> +	l &= ~(OTG_CTRL_XCVR_MASK | OTG_CTRL_SYS_MASK);
>  	l |= OTG_ASESSVLD;
> -	OTG_CTRL_REG = l;
> +	omap_writel(l, OTG_CTRL);
>  
>  	/* Power up the transceiver in USB host mode */
>  	tahvo_write_reg(TAHVO_REG_USBR, USBR_REGOUT | USBR_NSUSPEND |
> @@ -344,12 +358,16 @@ static void tahvo_usb_stop_host(struct tahvo_usb *tu)
>  
>  static void tahvo_usb_become_peripheral(struct tahvo_usb *tu)
>  {
> +	u32 l;
> +
>  	/* Clear system and transceiver controlled bits
>  	 * and enable ID to mark peripheral mode and
>  	 * BSESSEND to mark no Vbus */
>  	omap_otg_init();
> -	OTG_CTRL_REG = (OTG_CTRL_REG & ~(OTG_CTRL_XCVR_MASK|OTG_CTRL_SYS_MASK|OTG_BSESSVLD))
> -		| OTG_ID | OTG_BSESSEND;
> +	l = omap_readl(OTG_CTRL);
> +	l &= ~(OTG_CTRL_XCVR_MASK | OTG_CTRL_SYS_MASK | OTG_BSESSVLD);
> +	l |= OTG_ID | OTG_BSESSEND;
> +	omap_writel(l, OTG_CTRL);
>  
>  	/* Power up transceiver and set it in USB perhiperal mode */
>  	tahvo_write_reg(TAHVO_REG_USBR, USBR_SLAVE_CONTROL | USBR_REGOUT | USBR_NSUSPEND | USBR_SLAVE_SW);
> @@ -360,7 +378,13 @@ static void tahvo_usb_become_peripheral(struct tahvo_usb *tu)
>  
>  static void tahvo_usb_stop_peripheral(struct tahvo_usb *tu)
>  {
> -	OTG_CTRL_REG = (OTG_CTRL_REG & ~OTG_BSESSVLD) | OTG_BSESSEND;
> +	u32 l;
> +
> +	l = omap_readl(OTG_CTRL);
> +	l &= ~OTG_BSESSVLD;
> +	l |= OTG_BSESSEND;
> +	omap_writel(l, OTG_CTRL);
> +
>  	if (tu->otg.gadget)
>  		usb_gadget_vbus_disconnect(tu->otg.gadget);
>  	tu->otg.state = OTG_STATE_B_IDLE;
> @@ -383,15 +407,19 @@ static void tahvo_usb_power_off(struct tahvo_usb *tu)
>  		id = OTG_ID;
>  	else
>  		id = 0;
> -	l = OTG_CTRL_REG;
> +	l = omap_readl(OTG_CTRL);
>  	l &= ~(OTG_CTRL_XCVR_MASK | OTG_CTRL_SYS_MASK | OTG_BSESSVLD);
>  	l |= id | OTG_BSESSEND;
> -	OTG_CTRL_REG = l;
> -	OTG_IRQ_EN_REG = 0;
> +	omap_writel(l, OTG_CTRL);
> +	omap_writew(0, OTG_IRQ_EN);
>  
> -	OTG_SYSCON_2_REG &= ~OTG_EN;
> +	l = omap_readl(OTG_SYSCON_2);
> +	l &= ~OTG_EN;
> +	omap_writel(l, OTG_SYSCON_2);
>  
> -	OTG_SYSCON_1_REG |= OTG_IDLE_EN;
> +	l = omap_readl(OTG_SYSCON_1);
> +	l |= OTG_IDLE_EN;
> +	omap_writel(l, OTG_SYSCON_1);
>  
>  	/* Power off transceiver */
>  	tahvo_write_reg(TAHVO_REG_USBR, 0);
> @@ -438,13 +466,13 @@ static int tahvo_usb_start_srp(struct otg_transceiver *dev)
>  	if (!dev || tu->otg.state != OTG_STATE_B_IDLE)
>  		return -ENODEV;
>  
> -	otg_ctrl = OTG_CTRL_REG;
> +	otg_ctrl = omap_readl(OTG_CTRL);
>  	if (!(otg_ctrl & OTG_BSESSEND))
>  		return -EINVAL;
>  
>  	otg_ctrl |= OTG_B_BUSREQ;
>  	otg_ctrl &= ~OTG_A_BUSREQ & OTG_CTRL_SYS_MASK;
> -	OTG_CTRL_REG = otg_ctrl;
> +	omap_writel(otg_ctrl, OTG_CTRL);
>  	tu->otg.state = OTG_STATE_B_SRP_INIT;
>  
>  	return 0;
> @@ -464,6 +492,7 @@ static int tahvo_usb_start_hnp(struct otg_transceiver *otg)
>  static int tahvo_usb_set_host(struct otg_transceiver *otg, struct usb_bus *host)
>  {
>  	struct tahvo_usb *tu = container_of(otg, struct tahvo_usb, otg);
> +	u32 l;
>  
>  	dev_dbg(&tu->pt_dev->dev, "set_host %p\n", host);
>  
> @@ -482,7 +511,9 @@ static int tahvo_usb_set_host(struct otg_transceiver *otg, struct usb_bus *host)
>  		return 0;
>  	}
>  
> -	OTG_SYSCON_1_REG &= ~(OTG_IDLE_EN | HST_IDLE_EN | DEV_IDLE_EN);
> +	l = omap_readl(OTG_SYSCON_1);
> +	l &= ~(OTG_IDLE_EN | HST_IDLE_EN | DEV_IDLE_EN);
> +	omap_writel(l, OTG_SYSCON_1);
>  
>  	if (TAHVO_MODE(tu) == TAHVO_MODE_HOST) {
>  		tu->otg.host = NULL;
> diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
> index 1525543..c198426 100644
> --- a/drivers/i2c/chips/isp1301_omap.c
> +++ b/drivers/i2c/chips/isp1301_omap.c
> @@ -69,7 +69,7 @@ struct isp1301 {
>  };
>  
>  
> -/* bits in OTG_CTRL_REG */
> +/* bits in OTG_CTRL */
>  
>  #define	OTG_XCEIV_OUTPUTS \
>  	(OTG_ASESSVLD|OTG_BSESSEND|OTG_BSESSVLD|OTG_VBUSVLD|OTG_ID)
> @@ -186,8 +186,8 @@ isp1301_clear_bits(struct isp1301 *isp, u8 reg, u8 bits)
>  
>  /* operational registers */
>  #define	ISP1301_MODE_CONTROL_1		0x04	/* u8 read, set, +1 clear */
> -#	define	MC1_SPEED_REG		(1 << 0)
> -#	define	MC1_SUSPEND_REG		(1 << 1)
> +#	define	MC1_SPEED		(1 << 0)
> +#	define	MC1_SUSPEND		(1 << 1)
>  #	define	MC1_DAT_SE0		(1 << 2)
>  #	define	MC1_TRANSPARENT		(1 << 3)
>  #	define	MC1_BDIS_ACON_EN	(1 << 4)
> @@ -274,7 +274,7 @@ static void power_down(struct isp1301 *isp)
>  	isp->otg.state = OTG_STATE_UNDEFINED;
>  
>  	// isp1301_set_bits(isp, ISP1301_MODE_CONTROL_2, MC2_GLOBAL_PWR_DN);
> -	isp1301_set_bits(isp, ISP1301_MODE_CONTROL_1, MC1_SUSPEND_REG);
> +	isp1301_set_bits(isp, ISP1301_MODE_CONTROL_1, MC1_SUSPEND);
>  
>  	isp1301_clear_bits(isp, ISP1301_OTG_CONTROL_1, OTG1_ID_PULLDOWN);
>  	isp1301_clear_bits(isp, ISP1301_MODE_CONTROL_1, MC1_DAT_SE0);
> @@ -283,7 +283,7 @@ static void power_down(struct isp1301 *isp)
>  static void power_up(struct isp1301 *isp)
>  {
>  	// isp1301_clear_bits(isp, ISP1301_MODE_CONTROL_2, MC2_GLOBAL_PWR_DN);
> -	isp1301_clear_bits(isp, ISP1301_MODE_CONTROL_1, MC1_SUSPEND_REG);
> +	isp1301_clear_bits(isp, ISP1301_MODE_CONTROL_1, MC1_SUSPEND);
>  
>  	/* do this only when cpu is driving transceiver,
>  	 * so host won't see a low speed device...
> @@ -360,6 +360,8 @@ isp1301_defer_work(struct isp1301 *isp, int work)
>  /* called from irq handlers */
>  static void a_idle(struct isp1301 *isp, const char *tag)
>  {
> +	u32 l;
> +
>  	if (isp->otg.state == OTG_STATE_A_IDLE)
>  		return;
>  
> @@ -373,13 +375,17 @@ static void a_idle(struct isp1301 *isp, const char *tag)
>  		gadget_suspend(isp);
>  	}
>  	isp->otg.state = OTG_STATE_A_IDLE;
> -	isp->last_otg_ctrl = OTG_CTRL_REG = OTG_CTRL_REG & OTG_XCEIV_OUTPUTS;
> +	l = omap_readl(OTG_CTRL) & OTG_XCEIV_OUTPUTS;
> +	omap_writel(l, OTG_CTRL);
> +	isp->last_otg_ctrl = l;
>  	pr_debug("  --> %s/%s\n", state_name(isp), tag);
>  }
>  
>  /* called from irq handlers */
>  static void b_idle(struct isp1301 *isp, const char *tag)
>  {
> +	u32 l;
> +
>  	if (isp->otg.state == OTG_STATE_B_IDLE)
>  		return;
>  
> @@ -393,7 +399,9 @@ static void b_idle(struct isp1301 *isp, const char *tag)
>  		gadget_suspend(isp);
>  	}
>  	isp->otg.state = OTG_STATE_B_IDLE;
> -	isp->last_otg_ctrl = OTG_CTRL_REG = OTG_CTRL_REG & OTG_XCEIV_OUTPUTS;
> +	l = omap_readl(OTG_CTRL) & OTG_XCEIV_OUTPUTS;
> +	omap_writel(l, OTG_CTRL);
> +	isp->last_otg_ctrl = l;
>  	pr_debug("  --> %s/%s\n", state_name(isp), tag);
>  }
>  
> @@ -406,7 +414,7 @@ dump_regs(struct isp1301 *isp, const char *label)
>  	u8	src = isp1301_get_u8(isp, ISP1301_INTERRUPT_SOURCE);
>  
>  	pr_debug("otg: %06x, %s %s, otg/%02x stat/%02x.%02x\n",
> -		OTG_CTRL_REG, label, state_name(isp),
> +		omap_readl(OTG_CTRL), label, state_name(isp),
>  		ctrl, status, src);
>  	/* mode control and irq enables don't change much */
>  #endif
> @@ -429,7 +437,7 @@ dump_regs(struct isp1301 *isp, const char *label)
>  static void check_state(struct isp1301 *isp, const char *tag)
>  {
>  	enum usb_otg_state	state = OTG_STATE_UNDEFINED;
> -	u8			fsm = OTG_TEST_REG & 0x0ff;
> +	u8			fsm = omap_readw(OTG_TEST) & 0x0ff;
>  	unsigned		extra = 0;
>  
>  	switch (fsm) {
> @@ -494,7 +502,8 @@ static void check_state(struct isp1301 *isp, const char *tag)
>  	if (isp->otg.state == state && !extra)
>  		return;
>  	pr_debug("otg: %s FSM %s/%02x, %s, %06x\n", tag,
> -		state_string(state), fsm, state_name(isp), OTG_CTRL_REG);
> +		state_string(state), fsm, state_name(isp),
> +		omap_readl(OTG_CTRL));
>  }
>  
>  #else
> @@ -509,10 +518,11 @@ static void update_otg1(struct isp1301 *isp, u8 int_src)
>  	u32	otg_ctrl;
>  	u8      int_id;
>  
> -	otg_ctrl = OTG_CTRL_REG
> -			& OTG_CTRL_MASK
> -			& ~OTG_XCEIV_INPUTS
> -			& ~(OTG_ID|OTG_ASESSVLD|OTG_VBUSVLD);
> +	otg_ctrl = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
> +	otg_ctrl &= ~OTG_XCEIV_INPUTS;
> +	otg_ctrl &= (OTG_ID|OTG_ASESSVLD|OTG_VBUSVLD);
> +
> +
>  	if (int_src & INTR_SESS_VLD)
>  		otg_ctrl |= OTG_ASESSVLD;
>  	else if (isp->otg.state == OTG_STATE_A_WAIT_VFALL) {
> @@ -538,7 +548,7 @@ static void update_otg1(struct isp1301 *isp, u8 int_src)
>  			return;
>  		}
>  	}
> -	OTG_CTRL_REG = otg_ctrl;
> +	omap_writel(otg_ctrl, OTG_CTRL);
>  }
>  
>  /* outputs from ISP1301_OTG_STATUS */
> @@ -546,15 +556,14 @@ static void update_otg2(struct isp1301 *isp, u8 otg_status)
>  {
>  	u32	otg_ctrl;
>  
> -	otg_ctrl = OTG_CTRL_REG
> -			& OTG_CTRL_MASK
> -			& ~OTG_XCEIV_INPUTS
> -			& ~(OTG_BSESSVLD|OTG_BSESSEND);
> +	otg_ctrl = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
> +	otg_ctrl &= ~OTG_XCEIV_INPUTS;
> +	otg_ctrl &= ~(OTG_BSESSVLD | OTG_BSESSEND);
>  	if (otg_status & OTG_B_SESS_VLD)
>  		otg_ctrl |= OTG_BSESSVLD;
>  	else if (otg_status & OTG_B_SESS_END)
>  		otg_ctrl |= OTG_BSESSEND;
> -	OTG_CTRL_REG = otg_ctrl;
> +	omap_writel(otg_ctrl, OTG_CTRL);
>  }
>  
>  /* inputs going to ISP1301 */
> @@ -563,7 +572,7 @@ static void otg_update_isp(struct isp1301 *isp)
>  	u32	otg_ctrl, otg_change;
>  	u8	set = OTG1_DM_PULLDOWN, clr = OTG1_DM_PULLUP;
>  
> -	otg_ctrl = OTG_CTRL_REG;
> +	otg_ctrl = omap_readl(OTG_CTRL);
>  	otg_change = otg_ctrl ^ isp->last_otg_ctrl;
>  	isp->last_otg_ctrl = otg_ctrl;
>  	otg_ctrl = otg_ctrl & OTG_XCEIV_INPUTS;
> @@ -643,6 +652,8 @@ pulldown:
>  
>  	/* HNP switch to host or peripheral; and SRP */
>  	if (otg_change & OTG_PULLUP) {
> +		u32 l;
> +
>  		switch (isp->otg.state) {
>  		case OTG_STATE_B_IDLE:
>  			if (clr & OTG1_DP_PULLUP)
> @@ -659,7 +670,9 @@ pulldown:
>  		default:
>  			break;
>  		}
> -		OTG_CTRL_REG |= OTG_PULLUP;
> +		l = omap_readl(OTG_CTRL);
> +		l |= OTG_PULLUP;
> +		omap_writel(l, OTG_CTRL);
>  	}
>  
>  	check_state(isp, __func__);
> @@ -668,20 +681,20 @@ pulldown:
>  
>  static irqreturn_t omap_otg_irq(int irq, void *_isp)
>  {
> -	u16		otg_irq = OTG_IRQ_SRC_REG;
> +	u16		otg_irq = omap_readw(OTG_IRQ_SRC);
>  	u32		otg_ctrl;
>  	int		ret = IRQ_NONE;
>  	struct isp1301	*isp = _isp;
>  
>  	/* update ISP1301 transciever from OTG controller */
>  	if (otg_irq & OPRT_CHG) {
> -		OTG_IRQ_SRC_REG = OPRT_CHG;
> +		omap_writew(OPRT_CHG, OTG_IRQ_SRC);
>  		isp1301_defer_work(isp, WORK_UPDATE_ISP);
>  		ret = IRQ_HANDLED;
>  
>  	/* SRP to become b_peripheral failed */
>  	} else if (otg_irq & B_SRP_TMROUT) {
> -		pr_debug("otg: B_SRP_TIMEOUT, %06x\n", OTG_CTRL_REG);
> +		pr_debug("otg: B_SRP_TIMEOUT, %06x\n", omap_readl(OTG_CTRL));
>  		notresponding(isp);
>  
>  		/* gadget drivers that care should monitor all kinds of
> @@ -691,31 +704,31 @@ static irqreturn_t omap_otg_irq(int irq, void *_isp)
>  		if (isp->otg.state == OTG_STATE_B_SRP_INIT)
>  			b_idle(isp, "srp_timeout");
>  
> -		OTG_IRQ_SRC_REG = B_SRP_TMROUT;
> +		omap_writew(B_SRP_TMROUT, OTG_IRQ_SRC);
>  		ret = IRQ_HANDLED;
>  
>  	/* HNP to become b_host failed */
>  	} else if (otg_irq & B_HNP_FAIL) {
>  		pr_debug("otg: %s B_HNP_FAIL, %06x\n",
> -				state_name(isp), OTG_CTRL_REG);
> +				state_name(isp), omap_readl(OTG_CTRL));
>  		notresponding(isp);
>  
> -		otg_ctrl = OTG_CTRL_REG;
> +		otg_ctrl = omap_readl(OTG_CTRL);
>  		otg_ctrl |= OTG_BUSDROP;
>  		otg_ctrl &= OTG_CTRL_MASK & ~OTG_XCEIV_INPUTS;
> -		OTG_CTRL_REG = otg_ctrl;
> +		omap_writel(otg_ctrl, OTG_CTRL);
>  
>  		/* subset of b_peripheral()... */
>  		isp->otg.state = OTG_STATE_B_PERIPHERAL;
>  		pr_debug("  --> b_peripheral\n");
>  
> -		OTG_IRQ_SRC_REG = B_HNP_FAIL;
> +		omap_writew(B_HNP_FAIL, OTG_IRQ_SRC);
>  		ret = IRQ_HANDLED;
>  
>  	/* detect SRP from B-device ... */
>  	} else if (otg_irq & A_SRP_DETECT) {
>  		pr_debug("otg: %s SRP_DETECT, %06x\n",
> -				state_name(isp), OTG_CTRL_REG);
> +				state_name(isp), omap_readl(OTG_CTRL));
>  
>  		isp1301_defer_work(isp, WORK_UPDATE_OTG);
>  		switch (isp->otg.state) {
> @@ -723,49 +736,49 @@ static irqreturn_t omap_otg_irq(int irq, void *_isp)
>  			if (!isp->otg.host)
>  				break;
>  			isp1301_defer_work(isp, WORK_HOST_RESUME);
> -			otg_ctrl = OTG_CTRL_REG;
> +			otg_ctrl = omap_readl(OTG_CTRL);
>  			otg_ctrl |= OTG_A_BUSREQ;
>  			otg_ctrl &= ~(OTG_BUSDROP|OTG_B_BUSREQ)
>  					& ~OTG_XCEIV_INPUTS
>  					& OTG_CTRL_MASK;
> -			OTG_CTRL_REG = otg_ctrl;
> +			omap_writel(otg_ctrl, OTG_CTRL);
>  			break;
>  		default:
>  			break;
>  		}
>  
> -		OTG_IRQ_SRC_REG = A_SRP_DETECT;
> +		omap_writew(A_SRP_DETECT, OTG_IRQ_SRC);
>  		ret = IRQ_HANDLED;
>  
>  	/* timer expired:  T(a_wait_bcon) and maybe T(a_wait_vrise)
>  	 * we don't track them separately
>  	 */
>  	} else if (otg_irq & A_REQ_TMROUT) {
> -		otg_ctrl = OTG_CTRL_REG;
> +		otg_ctrl = omap_readl(OTG_CTRL);
>  		pr_info("otg: BCON_TMOUT from %s, %06x\n",
>  				state_name(isp), otg_ctrl);
>  		notresponding(isp);
>  
>  		otg_ctrl |= OTG_BUSDROP;
>  		otg_ctrl &= ~OTG_A_BUSREQ & OTG_CTRL_MASK & ~OTG_XCEIV_INPUTS;
> -		OTG_CTRL_REG = otg_ctrl;
> +		omap_writel(otg_ctrl, OTG_CTRL);
>  		isp->otg.state = OTG_STATE_A_WAIT_VFALL;
>  
> -		OTG_IRQ_SRC_REG = A_REQ_TMROUT;
> +		omap_writew(A_REQ_TMROUT, OTG_IRQ_SRC);
>  		ret = IRQ_HANDLED;
>  
>  	/* A-supplied voltage fell too low; overcurrent */
>  	} else if (otg_irq & A_VBUS_ERR) {
> -		otg_ctrl = OTG_CTRL_REG;
> +		otg_ctrl = omap_readl(OTG_CTRL);
>  		printk(KERN_ERR "otg: %s, VBUS_ERR %04x ctrl %06x\n",
>  			state_name(isp), otg_irq, otg_ctrl);
>  
>  		otg_ctrl |= OTG_BUSDROP;
>  		otg_ctrl &= ~OTG_A_BUSREQ & OTG_CTRL_MASK & ~OTG_XCEIV_INPUTS;
> -		OTG_CTRL_REG = otg_ctrl;
> +		omap_writel(otg_ctrl, OTG_CTRL);
>  		isp->otg.state = OTG_STATE_A_VBUS_ERR;
>  
> -		OTG_IRQ_SRC_REG = A_VBUS_ERR;
> +		omap_writew(A_VBUS_ERR, OTG_IRQ_SRC);
>  		ret = IRQ_HANDLED;
>  
>  	/* switch driver; the transciever code activates it,
> @@ -774,7 +787,7 @@ static irqreturn_t omap_otg_irq(int irq, void *_isp)
>  	} else if (otg_irq & DRIVER_SWITCH) {
>  		int	kick = 0;
>  
> -		otg_ctrl = OTG_CTRL_REG;
> +		otg_ctrl = omap_readl(OTG_CTRL);
>  		printk(KERN_NOTICE "otg: %s, SWITCH to %s, ctrl %06x\n",
>  				state_name(isp),
>  				(otg_ctrl & OTG_DRIVER_SEL)
> @@ -797,7 +810,7 @@ static irqreturn_t omap_otg_irq(int irq, void *_isp)
>  		} else {
>  			if (!(otg_ctrl & OTG_ID)) {
>  				otg_ctrl &= OTG_CTRL_MASK & ~OTG_XCEIV_INPUTS;
> -				OTG_CTRL_REG = otg_ctrl | OTG_A_BUSREQ;
> +				omap_writel(otg_ctrl | OTG_A_BUSREQ, OTG_CTRL);
>  			}
>  
>  			if (isp->otg.host) {
> @@ -822,7 +835,7 @@ static irqreturn_t omap_otg_irq(int irq, void *_isp)
>  			}
>  		}
>  
> -		OTG_IRQ_SRC_REG = DRIVER_SWITCH;
> +		omap_writew(DRIVER_SWITCH, OTG_IRQ_SRC);
>  		ret = IRQ_HANDLED;
>  
>  		if (kick)
> @@ -838,12 +851,15 @@ static struct platform_device *otg_dev;
>  
>  static int otg_init(struct isp1301 *isp)
>  {
> +	u32 l;
> +
>  	if (!otg_dev)
>  		return -ENODEV;
>  
>  	dump_regs(isp, __func__);
>  	/* some of these values are board-specific... */
> -	OTG_SYSCON_2_REG |= OTG_EN
> +	l = omap_readl(OTG_SYSCON_2);
> +	l |= OTG_EN
>  		/* for B-device: */
>  		| SRP_GPDATA		/* 9msec Bdev D+ pulse */
>  		| SRP_GPDVBUS		/* discharge after VBUS pulse */
> @@ -853,18 +869,22 @@ static int otg_init(struct isp1301 *isp)
>  		| SRP_DPW		/* detect 167+ns SRP pulses */
>  		| SRP_DATA | SRP_VBUS	/* accept both kinds of SRP pulse */
>  		;
> +	omap_writel(l, OTG_SYSCON_2);
>  
>  	update_otg1(isp, isp1301_get_u8(isp, ISP1301_INTERRUPT_SOURCE));
>  	update_otg2(isp, isp1301_get_u8(isp, ISP1301_OTG_STATUS));
>  
>  	check_state(isp, __func__);
>  	pr_debug("otg: %s, %s %06x\n",
> -			state_name(isp), __func__, OTG_CTRL_REG);
> +			state_name(isp), __func__, omap_readl(OTG_CTRL));
>  
> -	OTG_IRQ_EN_REG = DRIVER_SWITCH | OPRT_CHG
> +	omap_writew(DRIVER_SWITCH | OPRT_CHG
>  			| B_SRP_TMROUT | B_HNP_FAIL
> -			| A_VBUS_ERR | A_SRP_DETECT | A_REQ_TMROUT;
> -	OTG_SYSCON_2_REG |= OTG_EN;
> +			| A_VBUS_ERR | A_SRP_DETECT | A_REQ_TMROUT, OTG_IRQ_EN);
> +
> +	l = omap_readl(OTG_SYSCON_2);
> +	l |= OTG_EN;
> +	omap_writel(l, OTG_SYSCON_2);
>  
>  	return 0;
>  }
> @@ -931,7 +951,11 @@ static void otg_unbind(struct isp1301 *isp)
>  
>  static void b_peripheral(struct isp1301 *isp)
>  {
> -	OTG_CTRL_REG = OTG_CTRL_REG & OTG_XCEIV_OUTPUTS;
> +	u32 l;
> +
> +	l = omap_readl(OTG_CTRL) & OTG_XCEIV_OUTPUTS;
> +	omap_writel(l, OTG_CTRL);
> +
>  	usb_gadget_vbus_connect(isp->otg.gadget);
>  
>  #ifdef	CONFIG_USB_OTG
> @@ -1003,6 +1027,8 @@ static void isp_update_otg(struct isp1301 *isp, u8 stat)
>  			isp_bstat = 0;
>  		}
>  	} else {
> +		u32 l;
> +
>  		/* if user unplugged mini-A end of cable,
>  		 * don't bypass A_WAIT_VFALL.
>  		 */
> @@ -1023,8 +1049,9 @@ static void isp_update_otg(struct isp1301 *isp, u8 stat)
>  				isp1301_clear_bits(isp, ISP1301_MODE_CONTROL_1,
>  						MC1_BDIS_ACON_EN);
>  				isp->otg.state = OTG_STATE_B_IDLE;
> -				OTG_CTRL_REG &= OTG_CTRL_REG & OTG_CTRL_MASK
> -						& ~OTG_CTRL_BITS;
> +				l = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
> +				l &= ~OTG_CTRL_BITS;
> +				omap_writel(l, OTG_CTRL);
>  				break;
>  			case OTG_STATE_B_IDLE:
>  				break;
> @@ -1050,7 +1077,8 @@ static void isp_update_otg(struct isp1301 *isp, u8 stat)
>  			/* FALLTHROUGH */
>  		case OTG_STATE_B_SRP_INIT:
>  			b_idle(isp, __func__);
> -			OTG_CTRL_REG &= OTG_CTRL_REG & OTG_XCEIV_OUTPUTS;
> +			l = omap_readl(OTG_CTRL) & OTG_XCEIV_OUTPUTS;
> +			omap_writel(l, OTG_CTRL);
>  			/* FALLTHROUGH */
>  		case OTG_STATE_B_IDLE:
>  			if (isp->otg.gadget && (isp_bstat & OTG_B_SESS_VLD)) {
> @@ -1134,11 +1162,11 @@ isp1301_work(struct work_struct *work)
>  			case OTG_STATE_A_WAIT_VRISE:
>  				isp->otg.state = OTG_STATE_A_HOST;
>  				pr_debug("  --> a_host\n");
> -				otg_ctrl = OTG_CTRL_REG;
> +				otg_ctrl = omap_readl(OTG_CTRL);
>  				otg_ctrl |= OTG_A_BUSREQ;
>  				otg_ctrl &= ~(OTG_BUSDROP|OTG_B_BUSREQ)
>  						& OTG_CTRL_MASK;
> -				OTG_CTRL_REG = otg_ctrl;
> +				omap_writel(otg_ctrl, OTG_CTRL);
>  				break;
>  			case OTG_STATE_B_WAIT_ACON:
>  				isp->otg.state = OTG_STATE_B_HOST;
> @@ -1277,7 +1305,7 @@ isp1301_set_host(struct otg_transceiver *otg, struct usb_bus *host)
>  		return -ENODEV;
>  
>  	if (!host) {
> -		OTG_IRQ_EN_REG = 0;
> +		omap_writew(0, OTG_IRQ_EN);
>  		power_down(isp);
>  		isp->otg.host = 0;
>  		return 0;
> @@ -1325,12 +1353,13 @@ static int
>  isp1301_set_peripheral(struct otg_transceiver *otg, struct usb_gadget *gadget)
>  {
>  	struct isp1301	*isp = container_of(otg, struct isp1301, otg);
> +	u32 l;
>  
>  	if (!otg || isp != the_transceiver)
>  		return -ENODEV;
>  
>  	if (!gadget) {
> -		OTG_IRQ_EN_REG = 0;
> +		omap_writew(0, OTG_IRQ_EN);
>  		if (!isp->otg.default_a)
>  			enable_vbus_draw(isp, 0);
>  		usb_gadget_vbus_disconnect(isp->otg.gadget);
> @@ -1351,9 +1380,11 @@ isp1301_set_peripheral(struct otg_transceiver *otg, struct usb_gadget *gadget)
>  	isp->otg.gadget = gadget;
>  	// FIXME update its refcount
>  
> -	OTG_CTRL_REG = (OTG_CTRL_REG & OTG_CTRL_MASK
> -				& ~(OTG_XCEIV_OUTPUTS|OTG_CTRL_BITS))
> -			| OTG_ID;
> +	l = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
> +	l &= ~(OTG_XCEIV_OUTPUTS|OTG_CTRL_BITS);
> +	l |= OTG_ID;
> +	omap_writel(l, OTG_CTRL);
> +
>  	power_up(isp);
>  	isp->otg.state = OTG_STATE_B_IDLE;
>  
> @@ -1406,16 +1437,17 @@ isp1301_start_srp(struct otg_transceiver *dev)
>  			|| isp->otg.state != OTG_STATE_B_IDLE)
>  		return -ENODEV;
>  
> -	otg_ctrl = OTG_CTRL_REG;
> +	otg_ctrl = omap_readl(OTG_CTRL);
>  	if (!(otg_ctrl & OTG_BSESSEND))
>  		return -EINVAL;
>  
>  	otg_ctrl |= OTG_B_BUSREQ;
>  	otg_ctrl &= ~OTG_A_BUSREQ & OTG_CTRL_MASK;
> -	OTG_CTRL_REG = otg_ctrl;
> +	omap_writel(otg_ctrl, OTG_CTRL);
>  	isp->otg.state = OTG_STATE_B_SRP_INIT;
>  
> -	pr_debug("otg: SRP, %s ... %06x\n", state_name(isp), OTG_CTRL_REG);
> +	pr_debug("otg: SRP, %s ... %06x\n", state_name(isp),
> +			omap_readl(OTG_CTRL));
>  #ifdef	CONFIG_USB_OTG
>  	check_state(isp, __func__);
>  #endif
> @@ -1427,6 +1459,7 @@ isp1301_start_hnp(struct otg_transceiver *dev)
>  {
>  #ifdef	CONFIG_USB_OTG
>  	struct isp1301	*isp = container_of(dev, struct isp1301, otg);
> +	u32 l;
>  
>  	if (!dev || isp != the_transceiver)
>  		return -ENODEV;
> @@ -1457,7 +1490,9 @@ isp1301_start_hnp(struct otg_transceiver *dev)
>  #endif
>  		/* caller must suspend then clear A_BUSREQ */
>  		usb_gadget_vbus_connect(isp->otg.gadget);
> -		OTG_CTRL_REG |= OTG_A_SETB_HNPEN;
> +		l = omap_readl(OTG_CTRL);
> +		l |= OTG_A_SETB_HNPEN;
> +		omap_writel(l, OTG_CTRL);
>  
>  		break;
>  	case OTG_STATE_A_PERIPHERAL:
> @@ -1467,7 +1502,7 @@ isp1301_start_hnp(struct otg_transceiver *dev)
>  		return -EILSEQ;
>  	}
>  	pr_debug("otg: HNP %s, %06x ...\n",
> -		state_name(isp), OTG_CTRL_REG);
> +		state_name(isp), omap_readl(OTG_CTRL));
>  	check_state(isp, __func__);
>  	return 0;
>  #else
> diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
> index 5cf1c5c..099a882 100644
> --- a/drivers/i2c/chips/twl4030-usb.c
> +++ b/drivers/i2c/chips/twl4030-usb.c
> @@ -66,15 +66,15 @@
>  #define IFC_CTRL_CARKITMODE		(1 << 2)
>  #define IFC_CTRL_FSLSSERIALMODE_3PIN	(1 << 1)
>  
> -#define OTG_CTRL			0x0A
> -#define OTG_CTRL_SET			0x0B
> -#define OTG_CTRL_CLR			0x0C
> -#define OTG_CTRL_DRVVBUS		(1 << 5)
> -#define OTG_CTRL_CHRGVBUS		(1 << 4)
> -#define OTG_CTRL_DISCHRGVBUS		(1 << 3)
> -#define OTG_CTRL_DMPULLDOWN		(1 << 2)
> -#define OTG_CTRL_DPPULLDOWN		(1 << 1)
> -#define OTG_CTRL_IDPULLUP		(1 << 0)
> +#define TWL4030_OTG_CTRL		0x0A
> +#define TWL4030_OTG_CTRL_SET		0x0B
> +#define TWL4030_OTG_CTRL_CLR		0x0C
> +#define TWL4030_OTG_CTRL_DRVVBUS	(1 << 5)
> +#define TWL4030_OTG_CTRL_CHRGVBUS	(1 << 4)
> +#define TWL4030_OTG_CTRL_DISCHRGVBUS	(1 << 3)
> +#define TWL4030_OTG_CTRL_DMPULLDOWN	(1 << 2)
> +#define TWL4030_OTG_CTRL_DPPULLDOWN	(1 << 1)
> +#define TWL4030_OTG_CTRL_IDPULLUP	(1 << 0)
>  
>  #define USB_INT_EN_RISE			0x0D
>  #define USB_INT_EN_RISE_SET		0x0E
> @@ -252,7 +252,7 @@
>  /* internal define on top of container_of */
>  #define xceiv_to_twl(x)		container_of((x), struct twl4030_usb, otg);
>  
> -/* bits in OTG_CTRL_REG */
> +/* bits in OTG_CTRL */
>  
>  #define	OTG_XCEIV_OUTPUTS \
>  	(OTG_ASESSVLD|OTG_BSESSEND|OTG_BSESSVLD|OTG_VBUSVLD|OTG_ID)
> @@ -625,12 +625,13 @@ static int twl4030_set_peripheral(struct otg_transceiver *xceiv,
>  		struct usb_gadget *gadget)
>  {
>  	struct twl4030_usb *twl = xceiv_to_twl(xceiv);
> +	u32 l;
>  
>  	if (!xceiv)
>  		return -ENODEV;
>  
>  	if (!gadget) {
> -		OTG_IRQ_EN_REG = 0;
> +		omap_writew(0, OTG_IRQ_EN);
>  		twl4030_phy_suspend(1);
>  		twl->otg.gadget = NULL;
>  
> @@ -640,9 +641,10 @@ static int twl4030_set_peripheral(struct otg_transceiver *xceiv,
>  	twl->otg.gadget = gadget;
>  	twl4030_phy_resume();
>  
> -	OTG_CTRL_REG = (OTG_CTRL_REG & OTG_CTRL_MASK
> -			& ~(OTG_XCEIV_OUTPUTS|OTG_CTRL_BITS))
> -			| OTG_ID;
> +	l = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
> +	l &= ~(OTG_XCEIV_OUTPUTS|OTG_CTRL_BITS);
> +	l |= OTG_ID;
> +	omap_writel(l, OTG_CTRL);
>  
>  	twl->otg.state = OTG_STATE_B_IDLE;
>  
> @@ -662,7 +664,7 @@ static int twl4030_set_host(struct otg_transceiver *xceiv, struct usb_bus *host)
>  		return -ENODEV;
>  
>  	if (!host) {
> -		OTG_IRQ_EN_REG = 0;
> +		omap_writew(0, OTG_IRQ_EN);
>  		twl4030_phy_suspend(1);
>  		twl->otg.host = NULL;
>  
> @@ -672,12 +674,13 @@ static int twl4030_set_host(struct otg_transceiver *xceiv, struct usb_bus *host)
>  	twl->otg.host = host;
>  	twl4030_phy_resume();
>  
> -	twl4030_usb_set_bits(twl, OTG_CTRL,
> -			OTG_CTRL_DMPULLDOWN | OTG_CTRL_DPPULLDOWN);
> +	twl4030_usb_set_bits(twl, TWL4030_OTG_CTRL,
> +			TWL4030_OTG_CTRL_DMPULLDOWN
> +				| TWL4030_OTG_CTRL_DPPULLDOWN);
>  	twl4030_usb_set_bits(twl, USB_INT_EN_RISE, USB_INT_IDGND);
>  	twl4030_usb_set_bits(twl, USB_INT_EN_FALL, USB_INT_IDGND);
>  	twl4030_usb_set_bits(twl, FUNC_CTRL, FUNC_CTRL_SUSPENDM);
> -	twl4030_usb_set_bits(twl, OTG_CTRL, OTG_CTRL_DRVVBUS);
> +	twl4030_usb_set_bits(twl, TWL4030_OTG_CTRL, TWL4030_OTG_CTRL_DRVVBUS);
>  
>  	return 0;
>  }
> diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
> index 9d274c9..b18447f 100644
> --- a/drivers/usb/gadget/omap_udc.c
> +++ b/drivers/usb/gadget/omap_udc.c
> @@ -136,13 +136,17 @@ static void use_ep(struct omap_ep *ep, u16 select)
>  
>  	if (ep->bEndpointAddress & USB_DIR_IN)
>  		num |= UDC_EP_DIR;
> -	UDC_EP_NUM_REG = num | select;
> +	omap_writew(num | select, UDC_EP_NUM);
>  	/* when select, MUST deselect later !! */
>  }
>  
>  static inline void deselect_ep(void)
>  {
> -	UDC_EP_NUM_REG &= ~UDC_EP_SEL;
> +	u16 w;
> +
> +	w = omap_readw(UDC_EP_NUM);
> +	w &= ~UDC_EP_SEL;
> +	omap_writew(w, UDC_EP_NUM);
>  	/* 6 wait states before TX will happen */
>  }
>  
> @@ -217,7 +221,7 @@ static int omap_ep_enable(struct usb_ep *_ep,
>  	ep->has_dma = 0;
>  	ep->lch = -1;
>  	use_ep(ep, UDC_EP_SEL);
> -	UDC_CTRL_REG = udc->clr_halt;
> +	omap_writew(udc->clr_halt, UDC_CTRL);
>  	ep->ackwait = 0;
>  	deselect_ep();
>  
> @@ -233,7 +237,7 @@ static int omap_ep_enable(struct usb_ep *_ep,
>  	if (desc->bmAttributes != USB_ENDPOINT_XFER_ISOC
>  			&& !ep->has_dma
>  			&& !(ep->bEndpointAddress & USB_DIR_IN)) {
> -		UDC_CTRL_REG = UDC_SET_FIFO_EN;
> +		omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
>  		ep->ackwait = 1 + ep->double_buf;
>  	}
>  
> @@ -260,7 +264,7 @@ static int omap_ep_disable(struct usb_ep *_ep)
>  	nuke (ep, -ESHUTDOWN);
>  	ep->ep.maxpacket = ep->maxpacket;
>  	ep->has_dma = 0;
> -	UDC_CTRL_REG = UDC_SET_HALT;
> +	omap_writew(UDC_SET_HALT, UDC_CTRL);
>  	list_del_init(&ep->iso);
>  	del_timer(&ep->timer);
>  
> @@ -361,13 +365,13 @@ write_packet(u8 *buf, struct omap_req *req, unsigned max)
>  	if (likely((((int)buf) & 1) == 0)) {
>  		wp = (u16 *)buf;
>  		while (max >= 2) {
> -			UDC_DATA_REG = *wp++;
> +			omap_writew(*wp++, UDC_DATA);
>  			max -= 2;
>  		}
>  		buf = (u8 *)wp;
>  	}
>  	while (max--)
> -		*(volatile u8 *)&UDC_DATA_REG = *buf++;
> +		omap_writeb(*buf++, UDC_DATA);
>  	return len;
>  }
>  
> @@ -386,13 +390,13 @@ static int write_fifo(struct omap_ep *ep, struct omap_req *req)
>  	prefetch(buf);
>  
>  	/* PIO-IN isn't double buffered except for iso */
> -	ep_stat = UDC_STAT_FLG_REG;
> +	ep_stat = omap_readw(UDC_STAT_FLG);
>  	if (ep_stat & UDC_FIFO_UNWRITABLE)
>  		return 0;
>  
>  	count = ep->ep.maxpacket;
>  	count = write_packet(buf, req, count);
> -	UDC_CTRL_REG = UDC_SET_FIFO_EN;
> +	omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
>  	ep->ackwait = 1;
>  
>  	/* last packet is often short (sometimes a zlp) */
> @@ -426,13 +430,13 @@ read_packet(u8 *buf, struct omap_req *req, unsigned avail)
>  	if (likely((((int)buf) & 1) == 0)) {
>  		wp = (u16 *)buf;
>  		while (avail >= 2) {
> -			*wp++ = UDC_DATA_REG;
> +			*wp++ = omap_readw(UDC_DATA);
>  			avail -= 2;
>  		}
>  		buf = (u8 *)wp;
>  	}
>  	while (avail--)
> -		*buf++ = *(volatile u8 *)&UDC_DATA_REG;
> +		*buf++ = omap_readb(UDC_DATA);
>  	return len;
>  }
>  
> @@ -447,7 +451,7 @@ static int read_fifo(struct omap_ep *ep, struct omap_req *req)
>  	prefetchw(buf);
>  
>  	for (;;) {
> -		u16	ep_stat = UDC_STAT_FLG_REG;
> +		u16	ep_stat = omap_readw(UDC_STAT_FLG);
>  
>  		is_last = 0;
>  		if (ep_stat & FIFO_EMPTY) {
> @@ -461,7 +465,7 @@ static int read_fifo(struct omap_ep *ep, struct omap_req *req)
>  		if (ep_stat & UDC_FIFO_FULL)
>  			avail = ep->ep.maxpacket;
>  		else  {
> -			avail = UDC_RXFSTAT_REG;
> +			avail = omap_readw(UDC_RXFSTAT);
>  			ep->fnf = ep->double_buf;
>  		}
>  		count = read_packet(buf, req, avail);
> @@ -474,7 +478,7 @@ static int read_fifo(struct omap_ep *ep, struct omap_req *req)
>  				req->req.status = -EOVERFLOW;
>  				avail -= count;
>  				while (avail--)
> -					(void) *(volatile u8 *)&UDC_DATA_REG;
> +					omap_readw(UDC_DATA);
>  			}
>  		} else if (req->req.length == req->req.actual)
>  			is_last = 1;
> @@ -536,7 +540,7 @@ static u16 dma_dest_len(struct omap_ep *ep, dma_addr_t start)
>  
>  static void next_in_dma(struct omap_ep *ep, struct omap_req *req)
>  {
> -	u16		txdma_ctrl;
> +	u16		txdma_ctrl, w;
>  	unsigned	length = req->req.length - req->req.actual;
>  	const int	sync_mode = cpu_is_omap15xx()
>  				? OMAP_DMA_SYNC_FRAME
> @@ -568,13 +572,17 @@ static void next_in_dma(struct omap_ep *ep, struct omap_req *req)
>  
>  	omap_start_dma(ep->lch);
>  	ep->dma_counter = omap_get_dma_src_pos(ep->lch);
> -	UDC_DMA_IRQ_EN_REG |= UDC_TX_DONE_IE(ep->dma_channel);
> -	UDC_TXDMA_REG(ep->dma_channel) = UDC_TXN_START | txdma_ctrl;
> +	w = omap_readw(UDC_DMA_IRQ_EN);
> +	w |= UDC_TX_DONE_IE(ep->dma_channel);
> +	omap_writew(w, UDC_DMA_IRQ_EN);
> +	omap_writew(UDC_TXN_START | txdma_ctrl, UDC_TXDMA(ep->dma_channel));
>  	req->dma_bytes = length;
>  }
>  
>  static void finish_in_dma(struct omap_ep *ep, struct omap_req *req, int status)
>  {
> +	u16 w;
> +
>  	if (status == 0) {
>  		req->req.actual += req->dma_bytes;
>  
> @@ -591,7 +599,9 @@ static void finish_in_dma(struct omap_ep *ep, struct omap_req *req, int status)
>  
>  	/* tx completion */
>  	omap_stop_dma(ep->lch);
> -	UDC_DMA_IRQ_EN_REG &= ~UDC_TX_DONE_IE(ep->dma_channel);
> +	w = omap_readw(UDC_DMA_IRQ_EN);
> +	w &= ~UDC_TX_DONE_IE(ep->dma_channel);
> +	omap_writew(w, UDC_DMA_IRQ_EN);
>  	done(ep, req, status);
>  }
>  
> @@ -599,6 +609,7 @@ static void next_out_dma(struct omap_ep *ep, struct omap_req *req)
>  {
>  	unsigned packets = req->req.length - req->req.actual;
>  	int dma_trigger = 0;
> +	u16 w;
>  
>  	if (cpu_is_omap24xx())
>  		dma_trigger = OMAP24XX_DMA(USB_W2FC_RX0, ep->dma_channel);
> @@ -627,10 +638,12 @@ static void next_out_dma(struct omap_ep *ep, struct omap_req *req)
>  		0, 0);
>  	ep->dma_counter = omap_get_dma_dst_pos(ep->lch);
>  
> -	UDC_RXDMA_REG(ep->dma_channel) = UDC_RXN_STOP | (packets - 1);
> -	UDC_DMA_IRQ_EN_REG |= UDC_RX_EOT_IE(ep->dma_channel);
> -	UDC_EP_NUM_REG = (ep->bEndpointAddress & 0xf);
> -	UDC_CTRL_REG = UDC_SET_FIFO_EN;
> +	omap_writew(UDC_RXN_STOP | (packets - 1), UDC_RXDMA(ep->dma_channel));
> +	w = omap_readw(UDC_DMA_IRQ_EN);
> +	w |= UDC_RX_EOT_IE(ep->dma_channel);
> +	omap_writew(w, UDC_DMA_IRQ_EN);
> +	omap_writew(ep->bEndpointAddress & 0xf, UDC_EP_NUM);
> +	omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
>  
>  	omap_start_dma(ep->lch);
>  }
> @@ -638,7 +651,7 @@ static void next_out_dma(struct omap_ep *ep, struct omap_req *req)
>  static void
>  finish_out_dma(struct omap_ep *ep, struct omap_req *req, int status, int one)
>  {
> -	u16	count;
> +	u16	count, w;
>  
>  	if (status == 0)
>  		ep->dma_counter = (u16) (req->req.dma + req->req.actual);
> @@ -657,13 +670,15 @@ finish_out_dma(struct omap_ep *ep, struct omap_req *req, int status, int one)
>  		return;
>  
>  	/* rx completion */
> -	UDC_DMA_IRQ_EN_REG &= ~UDC_RX_EOT_IE(ep->dma_channel);
> +	w = omap_readw(UDC_DMA_IRQ_EN);
> +	w &= ~UDC_RX_EOT_IE(ep->dma_channel);
> +	omap_writew(w, UDC_DMA_IRQ_EN);
>  	done(ep, req, status);
>  }
>  
>  static void dma_irq(struct omap_udc *udc, u16 irq_src)
>  {
> -	u16		dman_stat = UDC_DMAN_STAT_REG;
> +	u16		dman_stat = omap_readw(UDC_DMAN_STAT);
>  	struct omap_ep	*ep;
>  	struct omap_req	*req;
>  
> @@ -677,7 +692,7 @@ static void dma_irq(struct omap_udc *udc, u16 irq_src)
>  						struct omap_req, queue);
>  			finish_in_dma(ep, req, 0);
>  		}
> -		UDC_IRQ_SRC_REG = UDC_TXN_DONE;
> +		omap_writew(UDC_TXN_DONE, UDC_IRQ_SRC);
>  
>  		if (!list_empty (&ep->queue)) {
>  			req = container_of(ep->queue.next,
> @@ -696,7 +711,7 @@ static void dma_irq(struct omap_udc *udc, u16 irq_src)
>  					struct omap_req, queue);
>  			finish_out_dma(ep, req, 0, dman_stat & UDC_DMA_RX_SB);
>  		}
> -		UDC_IRQ_SRC_REG = UDC_RXN_EOT;
> +		omap_writew(UDC_RXN_EOT, UDC_IRQ_SRC);
>  
>  		if (!list_empty (&ep->queue)) {
>  			req = container_of(ep->queue.next,
> @@ -710,7 +725,7 @@ static void dma_irq(struct omap_udc *udc, u16 irq_src)
>  		ep->irqs++;
>  		/* omap15xx does this unasked... */
>  		VDBG("%s, RX_CNT irq?\n", ep->ep.name);
> -		UDC_IRQ_SRC_REG = UDC_RXN_CNT;
> +		omap_writew(UDC_RXN_CNT, UDC_IRQ_SRC);
>  	}
>  }
>  
> @@ -733,9 +748,9 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
>  
>  	is_in = ep->bEndpointAddress & USB_DIR_IN;
>  	if (is_in)
> -		reg = UDC_TXDMA_CFG_REG;
> +		reg = omap_readw(UDC_TXDMA_CFG);
>  	else
> -		reg = UDC_RXDMA_CFG_REG;
> +		reg = omap_readw(UDC_RXDMA_CFG);
>  	reg |= UDC_DMA_REQ;		/* "pulse" activated */
>  
>  	ep->dma_channel = 0;
> @@ -763,7 +778,7 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
>  		status = omap_request_dma(dma_channel,
>  			ep->ep.name, dma_error, ep, &ep->lch);
>  		if (status == 0) {
> -			UDC_TXDMA_CFG_REG = reg;
> +			omap_writew(reg, UDC_TXDMA_CFG);
>  			/* EMIFF or SDRC */
>  			omap_set_dma_src_burst_mode(ep->lch,
>  						OMAP_DMA_DATA_BURST_4);
> @@ -772,7 +787,7 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
>  			omap_set_dma_dest_params(ep->lch,
>  				OMAP_DMA_PORT_TIPB,
>  				OMAP_DMA_AMODE_CONSTANT,
> -				(unsigned long) io_v2p((u32)&UDC_DATA_DMA_REG),
> +				(unsigned long) io_v2p(UDC_DATA_DMA),
>  				0, 0);
>  		}
>  	} else {
> @@ -784,12 +799,12 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
>  		status = omap_request_dma(dma_channel,
>  			ep->ep.name, dma_error, ep, &ep->lch);
>  		if (status == 0) {
> -			UDC_RXDMA_CFG_REG = reg;
> +			omap_writew(reg, UDC_RXDMA_CFG);
>  			/* TIPB */
>  			omap_set_dma_src_params(ep->lch,
>  				OMAP_DMA_PORT_TIPB,
>  				OMAP_DMA_AMODE_CONSTANT,
> -				(unsigned long) io_v2p((u32)&UDC_DATA_DMA_REG),
> +				(unsigned long) io_v2p(UDC_DATA_DMA),
>  				0, 0);
>  			/* EMIFF or SDRC */
>  			omap_set_dma_dest_burst_mode(ep->lch,
> @@ -832,7 +847,7 @@ just_restart:
>  			(is_in ? write_fifo : read_fifo)(ep, req);
>  			deselect_ep();
>  			if (!is_in) {
> -				UDC_CTRL_REG = UDC_SET_FIFO_EN;
> +				omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
>  				ep->ackwait = 1 + ep->double_buf;
>  			}
>  			/* IN: 6 wait states before it'll tx */
> @@ -866,23 +881,25 @@ static void dma_channel_release(struct omap_ep *ep)
>  
>  	/* wait till current packet DMA finishes, and fifo empties */
>  	if (ep->bEndpointAddress & USB_DIR_IN) {
> -		UDC_TXDMA_CFG_REG = (UDC_TXDMA_CFG_REG & ~mask) | UDC_DMA_REQ;
> +		omap_writew((omap_readw(UDC_TXDMA_CFG) & ~mask) | UDC_DMA_REQ,
> +					UDC_TXDMA_CFG);
>  
>  		if (req) {
>  			finish_in_dma(ep, req, -ECONNRESET);
>  
>  			/* clear FIFO; hosts probably won't empty it */
>  			use_ep(ep, UDC_EP_SEL);
> -			UDC_CTRL_REG = UDC_CLR_EP;
> +			omap_writew(UDC_CLR_EP, UDC_CTRL);
>  			deselect_ep();
>  		}
> -		while (UDC_TXDMA_CFG_REG & mask)
> +		while (omap_readw(UDC_TXDMA_CFG) & mask)
>  			udelay(10);
>  	} else {
> -		UDC_RXDMA_CFG_REG = (UDC_RXDMA_CFG_REG & ~mask) | UDC_DMA_REQ;
> +		omap_writew((omap_readw(UDC_RXDMA_CFG) & ~mask) | UDC_DMA_REQ,
> +					UDC_RXDMA_CFG);
>  
>  		/* dma empties the fifo */
> -		while (UDC_RXDMA_CFG_REG & mask)
> +		while (omap_readw(UDC_RXDMA_CFG) & mask)
>  			udelay(10);
>  		if (req)
>  			finish_out_dma(ep, req, -ECONNRESET, 0);
> @@ -969,9 +986,13 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
>  	req->req.actual = 0;
>  
>  	/* maybe kickstart non-iso i/o queues */
> -	if (is_iso)
> -		UDC_IRQ_EN_REG |= UDC_SOF_IE;
> -	else if (list_empty(&ep->queue) && !ep->stopped && !ep->ackwait) {
> +	if (is_iso) {
> +		u16 w;
> +
> +		w = omap_readw(UDC_IRQ_EN);
> +		w |= UDC_SOF_IE;
> +		omap_writew(w, UDC_IRQ_EN);
> +	} else if (list_empty(&ep->queue) && !ep->stopped && !ep->ackwait) {
>  		int	is_in;
>  
>  		if (ep->bEndpointAddress == 0) {
> @@ -989,23 +1010,23 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
>  				 * requests to non-control endpoints
>  				 */
>  				if (udc->ep0_set_config) {
> -					u16	irq_en = UDC_IRQ_EN_REG;
> +					u16	irq_en = omap_readw(UDC_IRQ_EN);
>  
>  					irq_en |= UDC_DS_CHG_IE | UDC_EP0_IE;
>  					if (!udc->ep0_reset_config)
>  						irq_en |= UDC_EPN_RX_IE
>  							| UDC_EPN_TX_IE;
> -					UDC_IRQ_EN_REG = irq_en;
> +					omap_writew(irq_en, UDC_IRQ_EN);
>  				}
>  
>  				/* STATUS for zero length DATA stages is
>  				 * always an IN ... even for IN transfers,
>  				 * a weird case which seem to stall OMAP.
>  				 */
> -				UDC_EP_NUM_REG = (UDC_EP_SEL|UDC_EP_DIR);
> -				UDC_CTRL_REG = UDC_CLR_EP;
> -				UDC_CTRL_REG = UDC_SET_FIFO_EN;
> -				UDC_EP_NUM_REG = UDC_EP_DIR;
> +				omap_writew(UDC_EP_SEL | UDC_EP_DIR, UDC_EP_NUM);
> +				omap_writew(UDC_CLR_EP, UDC_CTRL);
> +				omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
> +				omap_writew(UDC_EP_DIR, UDC_EP_NUM);
>  
>  				/* cleanup */
>  				udc->ep0_pending = 0;
> @@ -1014,11 +1035,11 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
>  
>  			/* non-empty DATA stage */
>  			} else if (is_in) {
> -				UDC_EP_NUM_REG = UDC_EP_SEL|UDC_EP_DIR;
> +				omap_writew(UDC_EP_SEL | UDC_EP_DIR, UDC_EP_NUM);
>  			} else {
>  				if (udc->ep0_setup)
>  					goto irq_wait;
> -				UDC_EP_NUM_REG = UDC_EP_SEL;
> +				omap_writew(UDC_EP_SEL, UDC_EP_NUM);
>  			}
>  		} else {
>  			is_in = ep->bEndpointAddress & USB_DIR_IN;
> @@ -1034,7 +1055,7 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
>  				req = NULL;
>  			deselect_ep();
>  			if (!is_in) {
> -				UDC_CTRL_REG = UDC_SET_FIFO_EN;
> +				omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
>  				ep->ackwait = 1 + ep->double_buf;
>  			}
>  			/* IN: 6 wait states before it'll tx */
> @@ -1102,9 +1123,9 @@ static int omap_ep_set_halt(struct usb_ep *_ep, int value)
>  		else if (value) {
>  			if (ep->udc->ep0_set_config) {
>  				WARN("error changing config?\n");
> -				UDC_SYSCON2_REG = UDC_CLR_CFG;
> +				omap_writew(UDC_CLR_CFG, UDC_SYSCON2);
>  			}
> -			UDC_SYSCON2_REG = UDC_STALL_CMD;
> +			omap_writew(UDC_STALL_CMD, UDC_SYSCON2);
>  			ep->udc->ep0_pending = 0;
>  			status = 0;
>  		} else /* NOP */
> @@ -1131,8 +1152,8 @@ static int omap_ep_set_halt(struct usb_ep *_ep, int value)
>  				channel = 0;
>  
>  			use_ep(ep, UDC_EP_SEL);
> -			if (UDC_STAT_FLG_REG & UDC_NON_ISO_FIFO_EMPTY) {
> -				UDC_CTRL_REG = UDC_SET_HALT;
> +			if (omap_readw(UDC_STAT_FLG) & UDC_NON_ISO_FIFO_EMPTY) {
> +				omap_writew(UDC_SET_HALT, UDC_CTRL);
>  				status = 0;
>  			} else
>  				status = -EAGAIN;
> @@ -1142,10 +1163,10 @@ static int omap_ep_set_halt(struct usb_ep *_ep, int value)
>  				dma_channel_claim(ep, channel);
>  		} else {
>  			use_ep(ep, 0);
> -			UDC_CTRL_REG = ep->udc->clr_halt;
> +			omap_writew(ep->udc->clr_halt, UDC_CTRL);
>  			ep->ackwait = 0;
>  			if (!(ep->bEndpointAddress & USB_DIR_IN)) {
> -				UDC_CTRL_REG = UDC_SET_FIFO_EN;
> +				omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
>  				ep->ackwait = 1 + ep->double_buf;
>  			}
>  		}
> @@ -1177,7 +1198,7 @@ static struct usb_ep_ops omap_ep_ops = {
>  
>  static int omap_get_frame(struct usb_gadget *gadget)
>  {
> -	u16	sof = UDC_SOF_REG;
> +	u16	sof = omap_readw(UDC_SOF);
>  	return (sof & UDC_TS_OK) ? (sof & UDC_TS) : -EL2NSYNC;
>  }
>  
> @@ -1196,7 +1217,7 @@ static int omap_wakeup(struct usb_gadget *gadget)
>  		 */
>  		if (udc->devstat & (UDC_B_HNP_ENABLE|UDC_R_WK_OK)) {
>  			DBG("remote wakeup...\n");
> -			UDC_SYSCON2_REG = UDC_RMT_WKP;
> +			omap_writew(UDC_RMT_WKP, UDC_SYSCON2);
>  			retval = 0;
>  		}
>  
> @@ -1219,12 +1240,12 @@ omap_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
>  
>  	udc = container_of(gadget, struct omap_udc, gadget);
>  	spin_lock_irqsave(&udc->lock, flags);
> -	syscon1 = UDC_SYSCON1_REG;
> +	syscon1 = omap_readw(UDC_SYSCON1);
>  	if (is_selfpowered)
>  		syscon1 |= UDC_SELF_PWR;
>  	else
>  		syscon1 &= ~UDC_SELF_PWR;
> -	UDC_SYSCON1_REG = syscon1;
> +	omap_writew(syscon1, UDC_SYSCON1);
>  	spin_unlock_irqrestore(&udc->lock, flags);
>  
>  	return 0;
> @@ -1237,18 +1258,36 @@ static int can_pullup(struct omap_udc *udc)
>  
>  static void pullup_enable(struct omap_udc *udc)
>  {
> -	UDC_SYSCON1_REG |= UDC_PULLUP_EN;
> -	if (!gadget_is_otg(&udc->gadget) && !cpu_is_omap15xx())
> -		OTG_CTRL_REG |= OTG_BSESSVLD;
> -	UDC_IRQ_EN_REG = UDC_DS_CHG_IE;
> +	u16 w;
> +
> +	w = omap_readw(UDC_SYSCON1);
> +	w |= UDC_PULLUP_EN;
> +	omap_writew(w, UDC_SYSCON1);
> +	if (!gadget_is_otg(&udc->gadget) && !cpu_is_omap15xx()) {
> +		u32 l;
> +
> +		l = omap_readl(OTG_CTRL);
> +		l |= OTG_BSESSVLD;
> +		omap_writel(l, OTG_CTRL);
> +	}
> +	omap_writew(UDC_DS_CHG_IE, UDC_IRQ_EN);
>  }
>  
>  static void pullup_disable(struct omap_udc *udc)
>  {
> -	if (!gadget_is_otg(&udc->gadget) && !cpu_is_omap15xx())
> -		OTG_CTRL_REG &= ~OTG_BSESSVLD;
> -	UDC_IRQ_EN_REG = UDC_DS_CHG_IE;
> -	UDC_SYSCON1_REG &= ~UDC_PULLUP_EN;
> +	u16 w;
> +
> +	if (!gadget_is_otg(&udc->gadget) && !cpu_is_omap15xx()) {
> +		u32 l;
> +
> +		l = omap_readl(OTG_CTRL);
> +		l &= ~OTG_BSESSVLD;
> +		omap_writel(l, OTG_CTRL);
> +	}
> +	omap_writew(UDC_DS_CHG_IE, UDC_IRQ_EN);
> +	w = omap_readw(UDC_SYSCON1);
> +	w &= ~UDC_PULLUP_EN;
> +	omap_writew(w, UDC_SYSCON1);
>  }
>  
>  static struct omap_udc *udc;
> @@ -1276,6 +1315,7 @@ static int omap_vbus_session(struct usb_gadget *gadget, int is_active)
>  {
>  	struct omap_udc	*udc;
>  	unsigned long	flags;
> +	u32 l;
>  
>  	udc = container_of(gadget, struct omap_udc, gadget);
>  	spin_lock_irqsave(&udc->lock, flags);
> @@ -1283,10 +1323,12 @@ static int omap_vbus_session(struct usb_gadget *gadget, int is_active)
>  	udc->vbus_active = (is_active != 0);
>  	if (cpu_is_omap15xx()) {
>  		/* "software" detect, ignored if !VBUS_MODE_1510 */
> +		l = omap_readl(FUNC_MUX_CTRL_0);
>  		if (is_active)
> -			FUNC_MUX_CTRL_0_REG |= VBUS_CTRL_1510;
> +			l |= VBUS_CTRL_1510;
>  		else
> -			FUNC_MUX_CTRL_0_REG &= ~VBUS_CTRL_1510;
> +			l &= ~VBUS_CTRL_1510;
> +		omap_writel(l, FUNC_MUX_CTRL_0);
>  	}
>  	if (udc->dc_clk != NULL && is_active) {
>  		if (!udc->clk_requested) {
> @@ -1356,9 +1398,9 @@ static void nuke(struct omap_ep *ep, int status)
>  		dma_channel_release(ep);
>  
>  	use_ep(ep, 0);
> -	UDC_CTRL_REG = UDC_CLR_EP;
> +	omap_writew(UDC_CLR_EP, UDC_CTRL);
>  	if (ep->bEndpointAddress && ep->bmAttributes != USB_ENDPOINT_XFER_ISOC)
> -		UDC_CTRL_REG = UDC_SET_HALT;
> +		omap_writew(UDC_SET_HALT, UDC_CTRL);
>  
>  	while (!list_empty(&ep->queue)) {
>  		req = list_entry(ep->queue.next, struct omap_req, queue);
> @@ -1386,8 +1428,8 @@ static void update_otg(struct omap_udc *udc)
>  	if (!gadget_is_otg(&udc->gadget))
>  		return;
>  
> -	if (OTG_CTRL_REG & OTG_ID)
> -		devstat = UDC_DEVSTAT_REG;
> +	if (omap_readl(OTG_CTRL) & OTG_ID)
> +		devstat = omap_readw(UDC_DEVSTAT);
>  	else
>  		devstat = 0;
>  
> @@ -1398,9 +1440,14 @@ static void update_otg(struct omap_udc *udc)
>  	/* Enable HNP early, avoiding races on suspend irq path.
>  	 * ASSUMES OTG state machine B_BUS_REQ input is true.
>  	 */
> -	if (udc->gadget.b_hnp_enable)
> -		OTG_CTRL_REG = (OTG_CTRL_REG | OTG_B_HNPEN | OTG_B_BUSREQ)
> -				& ~OTG_PULLUP;
> +	if (udc->gadget.b_hnp_enable) {
> +		u32 l;
> +
> +		l = omap_readl(OTG_CTRL);
> +		l |= OTG_B_HNPEN | OTG_B_BUSREQ;
> +		l &= ~OTG_PULLUP;
> +		omap_writel(l, OTG_CTRL);
> +	}
>  }
>  
>  static void ep0_irq(struct omap_udc *udc, u16 irq_src)
> @@ -1418,7 +1465,7 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
>  
>  		nuke(ep0, 0);
>  		if (ack) {
> -			UDC_IRQ_SRC_REG = ack;
> +			omap_writew(ack, UDC_IRQ_SRC);
>  			irq_src = UDC_SETUP;
>  		}
>  	}
> @@ -1438,9 +1485,9 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
>  	if (irq_src & UDC_EP0_TX) {
>  		int	stat;
>  
> -		UDC_IRQ_SRC_REG = UDC_EP0_TX;
> -		UDC_EP_NUM_REG = UDC_EP_SEL|UDC_EP_DIR;
> -		stat = UDC_STAT_FLG_REG;
> +		omap_writew(UDC_EP0_TX, UDC_IRQ_SRC);
> +		omap_writew(UDC_EP_SEL|UDC_EP_DIR, UDC_EP_NUM);
> +		stat = omap_readw(UDC_STAT_FLG);
>  		if (stat & UDC_ACK) {
>  			if (udc->ep0_in) {
>  				/* write next IN packet from response,
> @@ -1448,26 +1495,26 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
>  				 */
>  				if (req)
>  					stat = write_fifo(ep0, req);
> -				UDC_EP_NUM_REG = UDC_EP_DIR;
> +				omap_writew(UDC_EP_DIR, UDC_EP_NUM);
>  				if (!req && udc->ep0_pending) {
> -					UDC_EP_NUM_REG = UDC_EP_SEL;
> -					UDC_CTRL_REG = UDC_CLR_EP;
> -					UDC_CTRL_REG = UDC_SET_FIFO_EN;
> -					UDC_EP_NUM_REG = 0;
> +					omap_writew(UDC_EP_SEL, UDC_EP_NUM);
> +					omap_writew(UDC_CLR_EP, UDC_CTRL);
> +					omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
> +					omap_writew(0, UDC_EP_NUM);
>  					udc->ep0_pending = 0;
>  				} /* else:  6 wait states before it'll tx */
>  			} else {
>  				/* ack status stage of OUT transfer */
> -				UDC_EP_NUM_REG = UDC_EP_DIR;
> +				omap_writew(UDC_EP_DIR, UDC_EP_NUM);
>  				if (req)
>  					done(ep0, req, 0);
>  			}
>  			req = NULL;
>  		} else if (stat & UDC_STALL) {
> -			UDC_CTRL_REG = UDC_CLR_HALT;
> -			UDC_EP_NUM_REG = UDC_EP_DIR;
> +			omap_writew(UDC_CLR_HALT, UDC_CTRL);
> +			omap_writew(UDC_EP_DIR, UDC_EP_NUM);
>  		} else {
> -			UDC_EP_NUM_REG = UDC_EP_DIR;
> +			omap_writew(UDC_EP_DIR, UDC_EP_NUM);
>  		}
>  	}
>  
> @@ -1475,9 +1522,9 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
>  	if (irq_src & UDC_EP0_RX) {
>  		int	stat;
>  
> -		UDC_IRQ_SRC_REG = UDC_EP0_RX;
> -		UDC_EP_NUM_REG = UDC_EP_SEL;
> -		stat = UDC_STAT_FLG_REG;
> +		omap_writew(UDC_EP0_RX, UDC_IRQ_SRC);
> +		omap_writew(UDC_EP_SEL, UDC_EP_NUM);
> +		stat = omap_readw(UDC_STAT_FLG);
>  		if (stat & UDC_ACK) {
>  			if (!udc->ep0_in) {
>  				stat = 0;
> @@ -1485,34 +1532,35 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
>  				 * reactiviting the fifo; stall on errors.
>  				 */
>  				if (!req || (stat = read_fifo(ep0, req)) < 0) {
> -					UDC_SYSCON2_REG = UDC_STALL_CMD;
> +					omap_writew(UDC_STALL_CMD, UDC_SYSCON2);
>  					udc->ep0_pending = 0;
>  					stat = 0;
>  				} else if (stat == 0)
> -					UDC_CTRL_REG = UDC_SET_FIFO_EN;
> -				UDC_EP_NUM_REG = 0;
> +					omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
> +				omap_writew(0, UDC_EP_NUM);
>  
>  				/* activate status stage */
>  				if (stat == 1) {
>  					done(ep0, req, 0);
>  					/* that may have STALLed ep0... */
> -					UDC_EP_NUM_REG = UDC_EP_SEL|UDC_EP_DIR;
> -					UDC_CTRL_REG = UDC_CLR_EP;
> -					UDC_CTRL_REG = UDC_SET_FIFO_EN;
> -					UDC_EP_NUM_REG = UDC_EP_DIR;
> +					omap_writew(UDC_EP_SEL | UDC_EP_DIR,
> +							UDC_EP_NUM);
> +					omap_writew(UDC_CLR_EP, UDC_CTRL);
> +					omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
> +					omap_writew(UDC_EP_DIR, UDC_EP_NUM);
>  					udc->ep0_pending = 0;
>  				}
>  			} else {
>  				/* ack status stage of IN transfer */
> -				UDC_EP_NUM_REG = 0;
> +				omap_writew(0, UDC_EP_NUM);
>  				if (req)
>  					done(ep0, req, 0);
>  			}
>  		} else if (stat & UDC_STALL) {
> -			UDC_CTRL_REG = UDC_CLR_HALT;
> -			UDC_EP_NUM_REG = 0;
> +			omap_writew(UDC_CLR_HALT, UDC_CTRL);
> +			omap_writew(0, UDC_EP_NUM);
>  		} else {
> -			UDC_EP_NUM_REG = 0;
> +			omap_writew(0, UDC_EP_NUM);
>  		}
>  	}
>  
> @@ -1527,14 +1575,14 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
>  
>  		/* read the (latest) SETUP message */
>  		do {
> -			UDC_EP_NUM_REG = UDC_SETUP_SEL;
> +			omap_writew(UDC_SETUP_SEL, UDC_EP_NUM);
>  			/* two bytes at a time */
> -			u.word[0] = UDC_DATA_REG;
> -			u.word[1] = UDC_DATA_REG;
> -			u.word[2] = UDC_DATA_REG;
> -			u.word[3] = UDC_DATA_REG;
> -			UDC_EP_NUM_REG = 0;
> -		} while (UDC_IRQ_SRC_REG & UDC_SETUP);
> +			u.word[0] = omap_readw(UDC_DATA);
> +			u.word[1] = omap_readw(UDC_DATA);
> +			u.word[2] = omap_readw(UDC_DATA);
> +			u.word[3] = omap_readw(UDC_DATA);
> +			omap_writew(0, UDC_EP_NUM);
> +		} while (omap_readw(UDC_IRQ_SRC) & UDC_SETUP);
>  
>  #define	w_value		le16_to_cpu(u.r.wValue)
>  #define	w_index		le16_to_cpu(u.r.wIndex)
> @@ -1565,9 +1613,9 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
>  			 * later if it fails the request.
>  			 */
>  			if (udc->ep0_reset_config)
> -				UDC_SYSCON2_REG = UDC_CLR_CFG;
> +				omap_writew(UDC_CLR_CFG, UDC_SYSCON2);
>  			else
> -				UDC_SYSCON2_REG = UDC_DEV_CFG;
> +				omap_writew(UDC_DEV_CFG, UDC_SYSCON2);
>  			update_otg(udc);
>  			goto delegate;
>  		case USB_REQ_CLEAR_FEATURE:
> @@ -1585,10 +1633,10 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
>  						|| !ep->desc)
>  					goto do_stall;
>  				use_ep(ep, 0);
> -				UDC_CTRL_REG = udc->clr_halt;
> +				omap_writew(udc->clr_halt, UDC_CTRL);
>  				ep->ackwait = 0;
>  				if (!(ep->bEndpointAddress & USB_DIR_IN)) {
> -					UDC_CTRL_REG = UDC_SET_FIFO_EN;
> +					omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
>  					ep->ackwait = 1 + ep->double_buf;
>  				}
>  				/* NOTE:  assumes the host behaves sanely,
> @@ -1621,15 +1669,15 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
>  			}
>  			use_ep(ep, 0);
>  			/* can't halt if fifo isn't empty... */
> -			UDC_CTRL_REG = UDC_CLR_EP;
> -			UDC_CTRL_REG = UDC_SET_HALT;
> +			omap_writew(UDC_CLR_EP, UDC_CTRL);
> +			omap_writew(UDC_SET_HALT, UDC_CTRL);
>  			VDBG("%s halted by host\n", ep->name);
>  ep0out_status_stage:
>  			status = 0;
> -			UDC_EP_NUM_REG = UDC_EP_SEL|UDC_EP_DIR;
> -			UDC_CTRL_REG = UDC_CLR_EP;
> -			UDC_CTRL_REG = UDC_SET_FIFO_EN;
> -			UDC_EP_NUM_REG = UDC_EP_DIR;
> +			omap_writew(UDC_EP_SEL|UDC_EP_DIR, UDC_EP_NUM);
> +			omap_writew(UDC_CLR_EP, UDC_CTRL);
> +			omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
> +			omap_writew(UDC_EP_DIR, UDC_EP_NUM);
>  			udc->ep0_pending = 0;
>  			break;
>  		case USB_REQ_GET_STATUS:
> @@ -1666,10 +1714,10 @@ intf_status:
>  
>  zero_status:
>  			/* return two zero bytes */
> -			UDC_EP_NUM_REG = UDC_EP_SEL|UDC_EP_DIR;
> -			UDC_DATA_REG = 0;
> -			UDC_CTRL_REG = UDC_SET_FIFO_EN;
> -			UDC_EP_NUM_REG = UDC_EP_DIR;
> +			omap_writew(UDC_EP_SEL|UDC_EP_DIR, UDC_EP_NUM);
> +			omap_writew(0, UDC_DATA);
> +			omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
> +			omap_writew(UDC_EP_DIR, UDC_EP_NUM);
>  			status = 0;
>  			VDBG("GET_STATUS, interface %d\n", w_index);
>  			/* next, status stage */
> @@ -1678,8 +1726,8 @@ zero_status:
>  delegate:
>  			/* activate the ep0out fifo right away */
>  			if (!udc->ep0_in && w_length) {
> -				UDC_EP_NUM_REG = 0;
> -				UDC_CTRL_REG = UDC_SET_FIFO_EN;
> +				omap_writew(0, UDC_EP_NUM);
> +				omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
>  			}
>  
>  			/* gadget drivers see class/vendor specific requests,
> @@ -1720,9 +1768,9 @@ do_stall:
>  				if (udc->ep0_reset_config)
>  					WARN("error resetting config?\n");
>  				else
> -					UDC_SYSCON2_REG = UDC_CLR_CFG;
> +					omap_writew(UDC_CLR_CFG, UDC_SYSCON2);
>  			}
> -			UDC_SYSCON2_REG = UDC_STALL_CMD;
> +			omap_writew(UDC_STALL_CMD, UDC_SYSCON2);
>  			udc->ep0_pending = 0;
>  		}
>  	}
> @@ -1736,7 +1784,7 @@ static void devstate_irq(struct omap_udc *udc, u16 irq_src)
>  {
>  	u16	devstat, change;
>  
> -	devstat = UDC_DEVSTAT_REG;
> +	devstat = omap_readw(UDC_DEVSTAT);
>  	change = devstat ^ udc->devstat;
>  	udc->devstat = devstat;
>  
> @@ -1776,7 +1824,8 @@ static void devstate_irq(struct omap_udc *udc, u16 irq_src)
>  				INFO("USB reset done, gadget %s\n",
>  					udc->driver->driver.name);
>  				/* ep0 traffic is legal from now on */
> -				UDC_IRQ_EN_REG = UDC_DS_CHG_IE | UDC_EP0_IE;
> +				omap_writew(UDC_DS_CHG_IE | UDC_EP0_IE,
> +						UDC_IRQ_EN);
>  			}
>  			change &= ~UDC_USB_RESET;
>  		}
> @@ -1820,7 +1869,7 @@ static void devstate_irq(struct omap_udc *udc, u16 irq_src)
>  		VDBG("devstat %03x, ignore change %03x\n",
>  			devstat,  change);
>  
> -	UDC_IRQ_SRC_REG = UDC_DS_CHG;
> +	omap_writew(UDC_DS_CHG, UDC_IRQ_SRC);
>  }
>  
>  static irqreturn_t omap_udc_irq(int irq, void *_udc)
> @@ -1831,7 +1880,7 @@ static irqreturn_t omap_udc_irq(int irq, void *_udc)
>  	unsigned long	flags;
>  
>  	spin_lock_irqsave(&udc->lock, flags);
> -	irq_src = UDC_IRQ_SRC_REG;
> +	irq_src = omap_readw(UDC_IRQ_SRC);
>  
>  	/* Device state change (usb ch9 stuff) */
>  	if (irq_src & UDC_DS_CHG) {
> @@ -1854,7 +1903,7 @@ static irqreturn_t omap_udc_irq(int irq, void *_udc)
>  		irq_src &= ~(UDC_TXN_DONE|UDC_RXN_CNT|UDC_RXN_EOT);
>  	}
>  
> -	irq_src &= ~(UDC_SOF|UDC_EPN_TX|UDC_EPN_RX);
> +	irq_src &= ~(UDC_IRQ_SOF | UDC_EPN_TX|UDC_EPN_RX);
>  	if (irq_src)
>  		DBG("udc_irq, unhandled %03x\n", irq_src);
>  	spin_unlock_irqrestore(&udc->lock, flags);
> @@ -1875,7 +1924,7 @@ static void pio_out_timer(unsigned long _ep)
>  	spin_lock_irqsave(&ep->udc->lock, flags);
>  	if (!list_empty(&ep->queue) && ep->ackwait) {
>  		use_ep(ep, UDC_EP_SEL);
> -		stat_flg = UDC_STAT_FLG_REG;
> +		stat_flg = omap_readw(UDC_STAT_FLG);
>  
>  		if ((stat_flg & UDC_ACK) && (!(stat_flg & UDC_FIFO_EN)
>  				|| (ep->double_buf && HALF_FULL(stat_flg)))) {
> @@ -1885,8 +1934,8 @@ static void pio_out_timer(unsigned long _ep)
>  			req = container_of(ep->queue.next,
>  					struct omap_req, queue);
>  			(void) read_fifo(ep, req);
> -			UDC_EP_NUM_REG = ep->bEndpointAddress;
> -			UDC_CTRL_REG = UDC_SET_FIFO_EN;
> +			omap_writew(ep->bEndpointAddress, UDC_EP_NUM);
> +			omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
>  			ep->ackwait = 1 + ep->double_buf;
>  		} else
>  			deselect_ep();
> @@ -1906,20 +1955,20 @@ static irqreturn_t omap_udc_pio_irq(int irq, void *_dev)
>  	unsigned long	flags;
>  
>  	spin_lock_irqsave(&udc->lock, flags);
> -	epn_stat = UDC_EPN_STAT_REG;
> -	irq_src = UDC_IRQ_SRC_REG;
> +	epn_stat = omap_readw(UDC_EPN_STAT);
> +	irq_src = omap_readw(UDC_IRQ_SRC);
>  
>  	/* handle OUT first, to avoid some wasteful NAKs */
>  	if (irq_src & UDC_EPN_RX) {
>  		epnum = (epn_stat >> 8) & 0x0f;
> -		UDC_IRQ_SRC_REG = UDC_EPN_RX;
> +		omap_writew(UDC_EPN_RX, UDC_IRQ_SRC);
>  		status = IRQ_HANDLED;
>  		ep = &udc->ep[epnum];
>  		ep->irqs++;
>  
> -		UDC_EP_NUM_REG = epnum | UDC_EP_SEL;
> +		omap_writew(epnum | UDC_EP_SEL, UDC_EP_NUM);
>  		ep->fnf = 0;
> -		if ((UDC_STAT_FLG_REG & UDC_ACK)) {
> +		if (omap_readw(UDC_STAT_FLG) & UDC_ACK) {
>  			ep->ackwait--;
>  			if (!list_empty(&ep->queue)) {
>  				int stat;
> @@ -1931,15 +1980,15 @@ static irqreturn_t omap_udc_pio_irq(int irq, void *_dev)
>  			}
>  		}
>  		/* min 6 clock delay before clearing EP_SEL ... */
> -		epn_stat = UDC_EPN_STAT_REG;
> -		epn_stat = UDC_EPN_STAT_REG;
> -		UDC_EP_NUM_REG = epnum;
> +		epn_stat = omap_readw(UDC_EPN_STAT);
> +		epn_stat = omap_readw(UDC_EPN_STAT);
> +		omap_writew(epnum, UDC_EP_NUM);
>  
>  		/* enabling fifo _after_ clearing ACK, contrary to docs,
>  		 * reduces lossage; timer still needed though (sigh).
>  		 */
>  		if (ep->fnf) {
> -			UDC_CTRL_REG = UDC_SET_FIFO_EN;
> +			omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
>  			ep->ackwait = 1 + ep->double_buf;
>  		}
>  		mod_timer(&ep->timer, PIO_OUT_TIMEOUT);
> @@ -1948,13 +1997,13 @@ static irqreturn_t omap_udc_pio_irq(int irq, void *_dev)
>  	/* then IN transfers */
>  	else if (irq_src & UDC_EPN_TX) {
>  		epnum = epn_stat & 0x0f;
> -		UDC_IRQ_SRC_REG = UDC_EPN_TX;
> +		omap_writew(UDC_EPN_TX, UDC_IRQ_SRC);
>  		status = IRQ_HANDLED;
>  		ep = &udc->ep[16 + epnum];
>  		ep->irqs++;
>  
> -		UDC_EP_NUM_REG = epnum | UDC_EP_DIR | UDC_EP_SEL;
> -		if ((UDC_STAT_FLG_REG & UDC_ACK)) {
> +		omap_writew(epnum | UDC_EP_DIR | UDC_EP_SEL, UDC_EP_NUM);
> +		if (omap_readw(UDC_STAT_FLG & UDC_ACK)) {
>  			ep->ackwait = 0;
>  			if (!list_empty(&ep->queue)) {
>  				req = container_of(ep->queue.next,
> @@ -1963,9 +2012,9 @@ static irqreturn_t omap_udc_pio_irq(int irq, void *_dev)
>  			}
>  		}
>  		/* min 6 clock delay before clearing EP_SEL ... */
> -		epn_stat = UDC_EPN_STAT_REG;
> -		epn_stat = UDC_EPN_STAT_REG;
> -		UDC_EP_NUM_REG = epnum | UDC_EP_DIR;
> +		epn_stat = omap_readw(UDC_EPN_STAT);
> +		epn_stat = omap_readw(UDC_EPN_STAT);
> +		omap_writew(epnum | UDC_EP_DIR, UDC_EP_NUM);
>  		/* then 6 clocks before it'd tx */
>  	}
>  
> @@ -1993,7 +2042,7 @@ static irqreturn_t omap_udc_iso_irq(int irq, void *_dev)
>  		req = list_entry(ep->queue.next, struct omap_req, queue);
>  
>  		use_ep(ep, UDC_EP_SEL);
> -		stat = UDC_STAT_FLG_REG;
> +		stat = omap_readw(UDC_STAT_FLG);
>  
>  		/* NOTE: like the other controller drivers, this isn't
>  		 * currently reporting lost or damaged frames.
> @@ -2025,9 +2074,14 @@ static irqreturn_t omap_udc_iso_irq(int irq, void *_dev)
>  		if (!list_empty(&ep->queue))
>  			pending = 1;
>  	}
> -	if (!pending)
> -		UDC_IRQ_EN_REG &= ~UDC_SOF_IE;
> -	UDC_IRQ_SRC_REG = UDC_SOF;
> +	if (!pending) {
> +		u16 w;
> +
> +		w = omap_readw(UDC_IRQ_EN);
> +		w &= ~UDC_SOF_IE;
> +		omap_writew(w, UDC_IRQ_EN);
> +	}
> +	omap_writew(UDC_IRQ_SOF, UDC_IRQ_SRC);
>  
>  	spin_unlock_irqrestore(&udc->lock, flags);
>  	return IRQ_HANDLED;
> @@ -2076,7 +2130,7 @@ int usb_gadget_register_driver (struct usb_gadget_driver *driver)
>  		if (ep->bmAttributes == USB_ENDPOINT_XFER_ISOC)
>  			continue;
>  		use_ep(ep, 0);
> -		UDC_CTRL_REG = UDC_SET_HALT;
> +		omap_writew(UDC_SET_HALT, UDC_CTRL);
>  	}
>  	udc->ep0_pending = 0;
>  	udc->ep[0].irqs = 0;
> @@ -2100,7 +2154,7 @@ int usb_gadget_register_driver (struct usb_gadget_driver *driver)
>  	}
>  	DBG("bound to driver %s\n", driver->driver.name);
>  
> -	UDC_IRQ_SRC_REG = UDC_IRQ_SRC_MASK;
> +	omap_writew(UDC_IRQ_SRC_MASK, UDC_IRQ_SRC);
>  
>  	/* connect to bus through transceiver */
>  	if (udc->transceiver) {
> @@ -2197,7 +2251,7 @@ static void proc_ep_show(struct seq_file *s, struct omap_ep *ep)
>  	else
>  		buf[0] = 0;
>  
> -	stat_flg = UDC_STAT_FLG_REG;
> +	stat_flg = omap_readw(UDC_STAT_FLG);
>  	seq_printf(s,
>  		"\n%s %s%s%sirqs %ld stat %04x " EIGHTBITS FOURBITS "%s\n",
>  		ep->name, buf,
> @@ -2258,12 +2312,12 @@ static int proc_otg_show(struct seq_file *s)
>  	u32		trans;
>  	char		*ctrl_name;
>  
> -	tmp = OTG_REV_REG;
> +	tmp = omap_readw(OTG_REV);
>  	if (cpu_is_omap24xx()) {
>  		/*
>  		 * REVISIT: Not clear how this works on OMAP2.  trans
>  		 * is ANDed to produce bits 7 and 8, which might make
> -		 * sense for USB_TRANSCEIVER_CTRL_REG on OMAP1,
> +		 * sense for USB_TRANSCEIVER_CTRL on OMAP1,
>  		 * but with CONTROL_DEVCONF, these bits have something to
>  		 * do with the frame adjustment counter and McBSP2.
>  		 */
> @@ -2271,11 +2325,11 @@ static int proc_otg_show(struct seq_file *s)
>  		trans = omap_ctrl_readb(OMAP2_CONTROL_DEVCONF0);
>  	} else {
>  		ctrl_name = "tranceiver_ctrl";
> -		trans = USB_TRANSCEIVER_CTRL_REG;
> +		trans = omap_readw(USB_TRANSCEIVER_CTRL);
>  	}
>  	seq_printf(s, "\nOTG rev %d.%d, %s %05x\n",
>  		tmp >> 4, tmp & 0xf, ctrl_name, trans);
> -	tmp = OTG_SYSCON_1_REG;
> +	tmp = omap_readw(OTG_SYSCON_1);
>  	seq_printf(s, "otg_syscon1 %08x usb2 %s, usb1 %s, usb0 %s,"
>  			FOURBITS "\n", tmp,
>  		trx_mode(USB2_TRX_MODE(tmp), trans & CONF_USB2_UNI_R),
> @@ -2287,7 +2341,7 @@ static int proc_otg_show(struct seq_file *s)
>  		(tmp & HST_IDLE_EN) ? " !host" : "",
>  		(tmp & DEV_IDLE_EN) ? " !dev" : "",
>  		(tmp & OTG_RESET_DONE) ? " reset_done" : " reset_active");
> -	tmp = OTG_SYSCON_2_REG;
> +	tmp = omap_readl(OTG_SYSCON_2);
>  	seq_printf(s, "otg_syscon2 %08x%s" EIGHTBITS
>  			" b_ase_brst=%d hmc=%d\n", tmp,
>  		(tmp & OTG_EN) ? " otg_en" : "",
> @@ -2302,7 +2356,7 @@ static int proc_otg_show(struct seq_file *s)
>  		(tmp & HMC_TLLATTACH) ? " tllattach" : "",
>  		B_ASE_BRST(tmp),
>  		OTG_HMC(tmp));
> -	tmp = OTG_CTRL_REG;
> +	tmp = omap_readl(OTG_CTRL);
>  	seq_printf(s, "otg_ctrl    %06x" EIGHTBITS EIGHTBITS "%s\n", tmp,
>  		(tmp & OTG_ASESSVLD) ? " asess" : "",
>  		(tmp & OTG_BSESSEND) ? " bsess_end" : "",
> @@ -2322,13 +2376,13 @@ static int proc_otg_show(struct seq_file *s)
>  		(tmp & OTG_PU_VBUS) ? " pu_vb" : "",
>  		(tmp & OTG_PU_ID) ? " pu_id" : ""
>  		);
> -	tmp = OTG_IRQ_EN_REG;
> +	tmp = omap_readw(OTG_IRQ_EN);
>  	seq_printf(s, "otg_irq_en  %04x" "\n", tmp);
> -	tmp = OTG_IRQ_SRC_REG;
> +	tmp = omap_readw(OTG_IRQ_SRC);
>  	seq_printf(s, "otg_irq_src %04x" "\n", tmp);
> -	tmp = OTG_OUTCTRL_REG;
> +	tmp = omap_readw(OTG_OUTCTRL);
>  	seq_printf(s, "otg_outctrl %04x" "\n", tmp);
> -	tmp = OTG_TEST_REG;
> +	tmp = omap_readw(OTG_TEST);
>  	seq_printf(s, "otg_test    %04x" "\n", tmp);
>  	return 0;
>  }
> @@ -2349,7 +2403,7 @@ static int proc_udc_show(struct seq_file *s, void *_)
>  		driver_desc,
>  		use_dma ?  " (dma)" : "");
>  
> -	tmp = UDC_REV_REG & 0xff;
> +	tmp = omap_readw(UDC_REV) & 0xff;
>  	seq_printf(s,
>  		"UDC rev %d.%d, fifo mode %d, gadget %s\n"
>  		"hmc %d, transceiver %s\n",
> @@ -2363,16 +2417,16 @@ static int proc_udc_show(struct seq_file *s, void *_)
>  				? "external" : "(none)"));
>  	if (cpu_class_is_omap1()) {
>  		seq_printf(s, "ULPD control %04x req %04x status %04x\n",
> -			__REG16(ULPD_CLOCK_CTRL),
> -			__REG16(ULPD_SOFT_REQ),
> -			__REG16(ULPD_STATUS_REQ));
> +			omap_readw(ULPD_CLOCK_CTRL),
> +			omap_readw(ULPD_SOFT_REQ),
> +			omap_readw(ULPD_STATUS_REQ));
>  	}
>  
>  	/* OTG controller registers */
>  	if (!cpu_is_omap15xx())
>  		proc_otg_show(s);
>  
> -	tmp = UDC_SYSCON1_REG;
> +	tmp = omap_readw(UDC_SYSCON1);
>  	seq_printf(s, "\nsyscon1     %04x" EIGHTBITS "\n", tmp,
>  		(tmp & UDC_CFG_LOCK) ? " cfg_lock" : "",
>  		(tmp & UDC_DATA_ENDIAN) ? " data_endian" : "",
> @@ -2391,7 +2445,7 @@ static int proc_udc_show(struct seq_file *s, void *_)
>  		return 0;
>  	}
>  
> -	tmp = UDC_DEVSTAT_REG;
> +	tmp = omap_readw(UDC_DEVSTAT);
>  	seq_printf(s, "devstat     %04x" EIGHTBITS "%s%s\n", tmp,
>  		(tmp & UDC_B_HNP_ENABLE) ? " b_hnp" : "",
>  		(tmp & UDC_A_HNP_SUPPORT) ? " a_hnp" : "",
> @@ -2403,20 +2457,20 @@ static int proc_udc_show(struct seq_file *s, void *_)
>  		(tmp & UDC_ADD) ? " ADD" : "",
>  		(tmp & UDC_DEF) ? " DEF" : "",
>  		(tmp & UDC_ATT) ? " ATT" : "");
> -	seq_printf(s, "sof         %04x\n", UDC_SOF_REG);
> -	tmp = UDC_IRQ_EN_REG;
> +	seq_printf(s, "sof         %04x\n", omap_readw(UDC_SOF));
> +	tmp = omap_readw(UDC_IRQ_EN);
>  	seq_printf(s, "irq_en      %04x" FOURBITS "%s\n", tmp,
>  		(tmp & UDC_SOF_IE) ? " sof" : "",
>  		(tmp & UDC_EPN_RX_IE) ? " epn_rx" : "",
>  		(tmp & UDC_EPN_TX_IE) ? " epn_tx" : "",
>  		(tmp & UDC_DS_CHG_IE) ? " ds_chg" : "",
>  		(tmp & UDC_EP0_IE) ? " ep0" : "");
> -	tmp = UDC_IRQ_SRC_REG;
> +	tmp = omap_readw(UDC_IRQ_SRC);
>  	seq_printf(s, "irq_src     %04x" EIGHTBITS "%s%s\n", tmp,
>  		(tmp & UDC_TXN_DONE) ? " txn_done" : "",
>  		(tmp & UDC_RXN_CNT) ? " rxn_cnt" : "",
>  		(tmp & UDC_RXN_EOT) ? " rxn_eot" : "",
> -		(tmp & UDC_SOF) ? " sof" : "",
> +		(tmp & UDC_IRQ_SOF) ? " sof" : "",
>  		(tmp & UDC_EPN_RX) ? " epn_rx" : "",
>  		(tmp & UDC_EPN_TX) ? " epn_tx" : "",
>  		(tmp & UDC_DS_CHG) ? " ds_chg" : "",
> @@ -2426,7 +2480,7 @@ static int proc_udc_show(struct seq_file *s, void *_)
>  	if (use_dma) {
>  		unsigned i;
>  
> -		tmp = UDC_DMA_IRQ_EN_REG;
> +		tmp = omap_readw(UDC_DMA_IRQ_EN);
>  		seq_printf(s, "dma_irq_en  %04x%s" EIGHTBITS "\n", tmp,
>  			(tmp & UDC_TX_DONE_IE(3)) ? " tx2_done" : "",
>  			(tmp & UDC_RX_CNT_IE(3)) ? " rx2_cnt" : "",
> @@ -2440,29 +2494,29 @@ static int proc_udc_show(struct seq_file *s, void *_)
>  			(tmp & UDC_RX_CNT_IE(1)) ? " rx0_cnt" : "",
>  			(tmp & UDC_RX_EOT_IE(1)) ? " rx0_eot" : "");
>  
> -		tmp = UDC_RXDMA_CFG_REG;
> +		tmp = omap_readw(UDC_RXDMA_CFG);
>  		seq_printf(s, "rxdma_cfg   %04x\n", tmp);
>  		if (tmp) {
>  			for (i = 0; i < 3; i++) {
>  				if ((tmp & (0x0f << (i * 4))) == 0)
>  					continue;
>  				seq_printf(s, "rxdma[%d]    %04x\n", i,
> -						UDC_RXDMA_REG(i + 1));
> +						omap_readw(UDC_RXDMA(i + 1)));
>  			}
>  		}
> -		tmp = UDC_TXDMA_CFG_REG;
> +		tmp = omap_readw(UDC_TXDMA_CFG);
>  		seq_printf(s, "txdma_cfg   %04x\n", tmp);
>  		if (tmp) {
>  			for (i = 0; i < 3; i++) {
>  				if (!(tmp & (0x0f << (i * 4))))
>  					continue;
>  				seq_printf(s, "txdma[%d]    %04x\n", i,
> -						UDC_TXDMA_REG(i + 1));
> +						omap_readw(UDC_TXDMA(i + 1)));
>  			}
>  		}
>  	}
>  
> -	tmp = UDC_DEVSTAT_REG;
> +	tmp = omap_readw(UDC_DEVSTAT);
>  	if (tmp & UDC_ATT) {
>  		proc_ep_show(s, &udc->ep[0]);
>  		if (tmp & UDC_ADD) {
> @@ -2514,7 +2568,7 @@ static inline void remove_proc_file(void) {}
>   * buffer space among the endpoints we'll be operating.
>   *
>   * NOTE: as of OMAP 1710 ES2.0, writing a new endpoint config when
> - * UDC_SYSCON_1_REG.CFG_LOCK is set can now work.  We won't use that
> + * UDC_SYSCON_1.CFG_LOCK is set can now work.  We won't use that
>   * capability yet though.
>   */
>  static unsigned __init
> @@ -2578,9 +2632,9 @@ omap_ep_setup(char *name, u8 addr, u8 type,
>  		name, addr, epn_rxtx, maxp, dbuf ? "x2" : "", buf);
>  
>  	if (addr & USB_DIR_IN)
> -		UDC_EP_TX_REG(addr & 0xf) = epn_rxtx;
> +		omap_writew(epn_rxtx, UDC_EP_TX(addr & 0xf));
>  	else
> -		UDC_EP_RX_REG(addr) = epn_rxtx;
> +		omap_writew(epn_rxtx, UDC_EP_RX(addr));
>  
>  	/* next endpoint's buffer starts after this one's */
>  	buf += maxp;
> @@ -2619,15 +2673,15 @@ omap_udc_setup(struct platform_device *odev, struct otg_transceiver *xceiv)
>  	unsigned	tmp, buf;
>  
>  	/* abolish any previous hardware state */
> -	UDC_SYSCON1_REG = 0;
> -	UDC_IRQ_EN_REG = 0;
> -	UDC_IRQ_SRC_REG = UDC_IRQ_SRC_MASK;
> -	UDC_DMA_IRQ_EN_REG = 0;
> -	UDC_RXDMA_CFG_REG = 0;
> -	UDC_TXDMA_CFG_REG = 0;
> +	omap_writew(0, UDC_SYSCON1);
> +	omap_writew(0, UDC_IRQ_EN);
> +	omap_writew(UDC_IRQ_SRC_MASK, UDC_IRQ_SRC);
> +	omap_writew(0, UDC_DMA_IRQ_EN);
> +	omap_writew(0, UDC_RXDMA_CFG);
> +	omap_writew(0, UDC_TXDMA_CFG);
>  
>  	/* UDC_PULLUP_EN gates the chip clock */
> -	// OTG_SYSCON_1_REG |= DEV_IDLE_EN;
> +	// OTG_SYSCON_1 |= DEV_IDLE_EN;
>  
>  	udc = kzalloc(sizeof(*udc), GFP_KERNEL);
>  	if (!udc)
> @@ -2658,8 +2712,8 @@ omap_udc_setup(struct platform_device *odev, struct otg_transceiver *xceiv)
>  
>  	/* initially disable all non-ep0 endpoints */
>  	for (tmp = 1; tmp < 15; tmp++) {
> -		UDC_EP_RX_REG(tmp) = 0;
> -		UDC_EP_TX_REG(tmp) = 0;
> +		omap_writew(0, UDC_EP_RX(tmp));
> +		omap_writew(0, UDC_EP_TX(tmp));
>  	}
>  
>  #define OMAP_BULK_EP(name,addr) \
> @@ -2744,7 +2798,7 @@ omap_udc_setup(struct platform_device *odev, struct otg_transceiver *xceiv)
>  		ERR("unsupported fifo_mode #%d\n", fifo_mode);
>  		return -ENODEV;
>  	}
> -	UDC_SYSCON1_REG = UDC_CFG_LOCK|UDC_SELF_PWR;
> +	omap_writew(UDC_CFG_LOCK|UDC_SELF_PWR, UDC_SYSCON1);
>  	INFO("fifo mode %d, %d bytes not used\n", fifo_mode, 2048 - buf);
>  	return 0;
>  }
> @@ -2788,7 +2842,7 @@ static int __init omap_udc_probe(struct platform_device *pdev)
>  	}
>  
>  	INFO("OMAP UDC rev %d.%d%s\n",
> -		UDC_REV_REG >> 4, UDC_REV_REG & 0xf,
> +		omap_readw(UDC_REV) >> 4, omap_readw(UDC_REV) & 0xf,
>  		config->otg ? ", Mini-AB" : "");
>  
>  	/* use the mode given to us by board init code */
> @@ -2803,12 +2857,13 @@ static int __init omap_udc_probe(struct platform_device *pdev)
>  			 * know when to turn PULLUP_EN on/off; and that
>  			 * means we always "need" the 48MHz clock.
>  			 */
> -			u32 tmp = FUNC_MUX_CTRL_0_REG;
> +			u32 tmp = omap_readl(FUNC_MUX_CTRL_0);
>  
> -			FUNC_MUX_CTRL_0_REG &= ~VBUS_CTRL_1510;
> +			tmp &= ~VBUS_CTRL_1510;
> +			omap_writel(tmp, FUNC_MUX_CTRL_0);
>  			tmp |= VBUS_MODE_1510;
>  			tmp &= ~VBUS_CTRL_1510;
> -			FUNC_MUX_CTRL_0_REG = tmp;
> +			omap_writel(tmp, FUNC_MUX_CTRL_0);
>  		}
>  	} else {
>  		/* The transceiver may package some GPIO logic or handle
> @@ -2888,7 +2943,7 @@ known:
>  #endif
>  
>  	/* starting with omap1710 es2.0, clear toggle is a separate bit */
> -	if (UDC_REV_REG >= 0x61)
> +	if (omap_readw(UDC_REV) >= 0x61)
>  		udc->clr_halt = UDC_RESET_EP | UDC_CLRDATA_TOGGLE;
>  	else
>  		udc->clr_halt = UDC_RESET_EP;
> @@ -2986,7 +3041,7 @@ static int __exit omap_udc_remove(struct platform_device *pdev)
>  		put_device(udc->transceiver->dev);
>  		udc->transceiver = NULL;
>  	}
> -	UDC_SYSCON1_REG = 0;
> +	omap_writew(0, UDC_SYSCON1);
>  
>  	remove_proc_file();
>  
> @@ -3017,7 +3072,7 @@ static int __exit omap_udc_remove(struct platform_device *pdev)
>   *
>   * REVISIT we should probably reject suspend requests when there's a host
>   * session active, rather than disconnecting, at least on boards that can
> - * report VBUS irqs (UDC_DEVSTAT_REG.UDC_ATT).  And in any case, we need to
> + * report VBUS irqs (UDC_DEVSTAT.UDC_ATT).  And in any case, we need to
>   * make host resumes and VBUS detection trigger OMAP wakeup events; that
>   * may involve talking to an external transceiver (e.g. isp1301).
>   */
> @@ -3026,7 +3081,7 @@ static int omap_udc_suspend(struct platform_device *dev, pm_message_t message)
>  {
>  	u32	devstat;
>  
> -	devstat = UDC_DEVSTAT_REG;
> +	devstat = omap_readw(UDC_DEVSTAT);
>  
>  	/* we're requesting 48 MHz clock if the pullup is enabled
>  	 * (== we're attached to the host) and we're not suspended,
> diff --git a/drivers/usb/gadget/omap_udc.h b/drivers/usb/gadget/omap_udc.h
> index c6b9cbc..67993d9 100644
> --- a/drivers/usb/gadget/omap_udc.h
> +++ b/drivers/usb/gadget/omap_udc.h
> @@ -8,23 +8,22 @@
>  /*
>   * USB device/endpoint management registers
>   */
> -#define UDC_REG(offset)              __REG16(UDC_BASE + (offset))
>  
> -#define	UDC_REV_REG			UDC_REG(0x0)	/* Revision */
> -#define	UDC_EP_NUM_REG			UDC_REG(0x4)	/* Which endpoint */
> +#define	UDC_REV				(UDC_BASE + 0x0)	/* Revision */
> +#define	UDC_EP_NUM			(UDC_BASE + 0x4)	/* Which endpoint */
>  #	define	UDC_SETUP_SEL		(1 << 6)
>  #	define	UDC_EP_SEL		(1 << 5)
>  #	define	UDC_EP_DIR		(1 << 4)
>  	/* low 4 bits for endpoint number */
> -#define	UDC_DATA_REG			UDC_REG(0x08)	/* Endpoint FIFO */
> -#define	UDC_CTRL_REG			UDC_REG(0x0C)	/* Endpoint control */
> +#define	UDC_DATA			(UDC_BASE + 0x08)	/* Endpoint FIFO */
> +#define	UDC_CTRL			(UDC_BASE + 0x0C)	/* Endpoint control */
>  #	define	UDC_CLR_HALT		(1 << 7)
>  #	define	UDC_SET_HALT		(1 << 6)
>  #	define	UDC_CLRDATA_TOGGLE	(1 << 3)
>  #	define	UDC_SET_FIFO_EN		(1 << 2)
>  #	define	UDC_CLR_EP		(1 << 1)
>  #	define	UDC_RESET_EP		(1 << 0)
> -#define	UDC_STAT_FLG_REG		UDC_REG(0x10)	/* Endpoint status */
> +#define	UDC_STAT_FLG			(UDC_BASE + 0x10)	/* Endpoint status */
>  #	define	UDC_NO_RXPACKET		(1 << 15)
>  #	define	UDC_MISS_IN		(1 << 14)
>  #	define	UDC_DATA_FLUSH		(1 << 13)
> @@ -38,8 +37,8 @@
>  #	define	UDC_FIFO_EN		(1 << 2)
>  #	define	UDC_NON_ISO_FIFO_EMPTY	(1 << 1)
>  #	define	UDC_NON_ISO_FIFO_FULL	(1 << 0)
> -#define	UDC_RXFSTAT_REG			UDC_REG(0x14)	/* OUT bytecount */
> -#define	UDC_SYSCON1_REG			UDC_REG(0x18)	/* System config 1 */
> +#define	UDC_RXFSTAT			(UDC_BASE + 0x14)	/* OUT bytecount */
> +#define	UDC_SYSCON1			(UDC_BASE + 0x18)	/* System config 1 */
>  #	define	UDC_CFG_LOCK		(1 << 8)
>  #	define	UDC_DATA_ENDIAN		(1 << 7)
>  #	define	UDC_DMA_ENDIAN		(1 << 6)
> @@ -48,12 +47,12 @@
>  #	define	UDC_SELF_PWR		(1 << 2)
>  #	define	UDC_SOFF_DIS		(1 << 1)
>  #	define	UDC_PULLUP_EN		(1 << 0)
> -#define	UDC_SYSCON2_REG			UDC_REG(0x1C)	/* System config 2 */
> +#define	UDC_SYSCON2			(UDC_BASE + 0x1C)	/* System config 2 */
>  #	define	UDC_RMT_WKP		(1 << 6)
>  #	define	UDC_STALL_CMD		(1 << 5)
>  #	define	UDC_DEV_CFG		(1 << 3)
>  #	define	UDC_CLR_CFG		(1 << 2)
> -#define	UDC_DEVSTAT_REG			UDC_REG(0x20)	/* Device status */
> +#define	UDC_DEVSTAT			(UDC_BASE + 0x20)	/* Device status */
>  #	define	UDC_B_HNP_ENABLE	(1 << 9)
>  #	define	UDC_A_HNP_SUPPORT	(1 << 8)
>  #	define	UDC_A_ALT_HNP_SUPPORT	(1 << 7)
> @@ -64,26 +63,26 @@
>  #	define	UDC_ADD			(1 << 2)
>  #	define	UDC_DEF			(1 << 1)
>  #	define	UDC_ATT			(1 << 0)
> -#define	UDC_SOF_REG			UDC_REG(0x24)	/* Start of frame */
> +#define	UDC_SOF				(UDC_BASE + 0x24)	/* Start of frame */
>  #	define	UDC_FT_LOCK		(1 << 12)
>  #	define	UDC_TS_OK		(1 << 11)
>  #	define	UDC_TS			0x03ff
> -#define	UDC_IRQ_EN_REG			UDC_REG(0x28)	/* Interrupt enable */
> +#define	UDC_IRQ_EN			(UDC_BASE + 0x28)	/* Interrupt enable */
>  #	define	UDC_SOF_IE		(1 << 7)
>  #	define	UDC_EPN_RX_IE		(1 << 5)
>  #	define	UDC_EPN_TX_IE		(1 << 4)
>  #	define	UDC_DS_CHG_IE		(1 << 3)
>  #	define	UDC_EP0_IE		(1 << 0)
> -#define	UDC_DMA_IRQ_EN_REG		UDC_REG(0x2C)	/* DMA irq enable */
> +#define	UDC_DMA_IRQ_EN			(UDC_BASE + 0x2C)	/* DMA irq enable */
>  	/* rx/tx dma channels numbered 1-3 not 0-2 */
>  #	define	UDC_TX_DONE_IE(n)	(1 << (4 * (n) - 2))
>  #	define	UDC_RX_CNT_IE(n)	(1 << (4 * (n) - 3))
>  #	define	UDC_RX_EOT_IE(n)	(1 << (4 * (n) - 4))
> -#define	UDC_IRQ_SRC_REG			UDC_REG(0x30)	/* Interrupt source */
> +#define	UDC_IRQ_SRC			(UDC_BASE + 0x30)	/* Interrupt source */
>  #	define	UDC_TXN_DONE		(1 << 10)
>  #	define	UDC_RXN_CNT		(1 << 9)
>  #	define	UDC_RXN_EOT		(1 << 8)
> -#	define	UDC_SOF			(1 << 7)
> +#	define	UDC_IRQ_SOF		(1 << 7)
>  #	define	UDC_EPN_RX		(1 << 5)
>  #	define	UDC_EPN_TX		(1 << 4)
>  #	define	UDC_DS_CHG		(1 << 3)
> @@ -91,41 +90,41 @@
>  #	define	UDC_EP0_RX		(1 << 1)
>  #	define	UDC_EP0_TX		(1 << 0)
>  #	define	UDC_IRQ_SRC_MASK	0x7bf
> -#define	UDC_EPN_STAT_REG		UDC_REG(0x34)	/* EP irq status */
> -#define	UDC_DMAN_STAT_REG		UDC_REG(0x38)	/* DMA irq status */
> +#define	UDC_EPN_STAT			(UDC_BASE + 0x34)	/* EP irq status */
> +#define	UDC_DMAN_STAT			(UDC_BASE + 0x38)	/* DMA irq status */
>  #	define	UDC_DMA_RX_SB		(1 << 12)
>  #	define	UDC_DMA_RX_SRC(x)	(((x)>>8) & 0xf)
>  #	define	UDC_DMA_TX_SRC(x)	(((x)>>0) & 0xf)
>  
>  
>  /* DMA configuration registers:  up to three channels in each direction.  */
> -#define	UDC_RXDMA_CFG_REG		UDC_REG(0x40)	/* 3 eps for RX DMA */
> +#define	UDC_RXDMA_CFG			(UDC_BASE + 0x40)	/* 3 eps for RX DMA */
>  #	define	UDC_DMA_REQ		(1 << 12)
> -#define	UDC_TXDMA_CFG_REG		UDC_REG(0x44)	/* 3 eps for TX DMA */
> -#define	UDC_DATA_DMA_REG		UDC_REG(0x48)	/* rx/tx fifo addr */
> +#define	UDC_TXDMA_CFG			(UDC_BASE + 0x44)	/* 3 eps for TX DMA */
> +#define	UDC_DATA_DMA			(UDC_BASE + 0x48)	/* rx/tx fifo addr */
>  
>  /* rx/tx dma control, numbering channels 1-3 not 0-2 */
> -#define	UDC_TXDMA_REG(chan)		UDC_REG(0x50 - 4 + 4 * (chan))
> +#define	UDC_TXDMA(chan)			(UDC_BASE + 0x50 - 4 + 4 * (chan))
>  #	define UDC_TXN_EOT		(1 << 15)	/* bytes vs packets */
>  #	define UDC_TXN_START		(1 << 14)	/* start transfer */
>  #	define UDC_TXN_TSC		0x03ff		/* units in xfer */
> -#define	UDC_RXDMA_REG(chan)		UDC_REG(0x60 - 4 + 4 * (chan))
> +#define	UDC_RXDMA(chan)			(UDC_BASE + 0x60 - 4 + 4 * (chan))
>  #	define UDC_RXN_STOP		(1 << 15)	/* enable EOT irq */
>  #	define UDC_RXN_TC		0x00ff		/* packets in xfer */
>  
>  
>  /*
>   * Endpoint configuration registers (used before CFG_LOCK is set)
> - * UDC_EP_TX_REG(0) is unused
> + * UDC_EP_TX(0) is unused
>   */
> -#define	UDC_EP_RX_REG(endpoint)		UDC_REG(0x80 + (endpoint)*4)
> +#define	UDC_EP_RX(endpoint)		(UDC_BASE + 0x80 + (endpoint)*4)
>  #	define	UDC_EPN_RX_VALID	(1 << 15)
>  #	define	UDC_EPN_RX_DB		(1 << 14)
>  	/* buffer size in bits 13, 12 */
>  #	define	UDC_EPN_RX_ISO		(1 << 11)
>  	/* buffer pointer in low 11 bits */
> -#define	UDC_EP_TX_REG(endpoint)		UDC_REG(0xc0 + (endpoint)*4)
> -	/* same bitfields as in RX_REG */
> +#define	UDC_EP_TX(endpoint)		(UDC_BASE + 0xc0 + (endpoint)*4)
> +	/* same bitfields as in RX */
>  
>  /*-------------------------------------------------------------------------*/
>  
> @@ -195,14 +194,14 @@ struct omap_udc {
>  
>  /*-------------------------------------------------------------------------*/
>  
> -#define	MOD_CONF_CTRL_0_REG	__REG32(MOD_CONF_CTRL_0)
> -#define	VBUS_W2FC_1510		(1 << 17)	/* 0 gpio0, 1 dvdd2 pin */
> +/* MOD_CONF_CTRL_0 */
> +#define VBUS_W2FC_1510		(1 << 17)	/* 0 gpio0, 1 dvdd2 pin */
>  
> -#define	FUNC_MUX_CTRL_0_REG	__REG32(FUNC_MUX_CTRL_0)
> +/* FUNC_MUX_CTRL_0 */
>  #define	VBUS_CTRL_1510		(1 << 19)	/* 1 connected (software) */
>  #define	VBUS_MODE_1510		(1 << 18)	/* 0 hardware, 1 software */
>  
> -#define	HMC_1510	((MOD_CONF_CTRL_0_REG >> 1) & 0x3f)
> -#define	HMC_1610	(OTG_SYSCON_2_REG & 0x3f)
> +#define	HMC_1510	((omap_readl(MOD_CONF_CTRL_0) >> 1) & 0x3f)
> +#define	HMC_1610	omap_readl(OTG_SYSCON_2 & 0x3f)
>  #define	HMC		(cpu_is_omap15xx() ? HMC_1510 : HMC_1610)
>  
> diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
> index f14be49..c23caf6 100644
> --- a/drivers/usb/host/ohci-omap.c
> +++ b/drivers/usb/host/ohci-omap.c
> @@ -169,13 +169,16 @@ static void start_hnp(struct ohci_hcd *ohci)
>  {
>  	const unsigned	port = ohci_to_hcd(ohci)->self.otg_port - 1;
>  	unsigned long	flags;
> +	u32 l;
>  
>  	otg_start_hnp(ohci->transceiver);
>  
>  	local_irq_save(flags);
>  	ohci->transceiver->state = OTG_STATE_A_SUSPEND;
>  	writel (RH_PS_PSS, &ohci->regs->roothub.portstatus [port]);
> -	OTG_CTRL_REG &= ~OTG_A_BUSREQ;
> +	l = omap_readl(OTG_CTRL);
> +	l &= ~OTG_A_BUSREQ;
> +	omap_writel(l, OTG_CTRL);
>  	local_irq_restore(flags);
>  }
>  
> diff --git a/include/asm-arm/arch-omap/usb.h b/include/asm-arm/arch-omap/usb.h
> index 580a718..7a0967b 100644
> --- a/include/asm-arm/arch-omap/usb.h
> +++ b/include/asm-arm/arch-omap/usb.h
> @@ -37,11 +37,8 @@ void __init usb_ehci_init(void);
>  /*
>   * OTG and transceiver registers, for OMAPs starting with ARM926
>   */
> -#define OTG_REG32(offset)		__REG32(OTG_BASE + (offset))
> -#define OTG_REG16(offset)		__REG16(OTG_BASE + (offset))
> -
> -#define OTG_REV_REG			OTG_REG32(0x00)
> -#define OTG_SYSCON_1_REG		OTG_REG32(0x04)
> +#define OTG_REV				(OTG_BASE + 0x00)
> +#define OTG_SYSCON_1			(OTG_BASE + 0x04)
>  #	define	 USB2_TRX_MODE(w)	(((w)>>24)&0x07)
>  #	define	 USB1_TRX_MODE(w)	(((w)>>20)&0x07)
>  #	define	 USB0_TRX_MODE(w)	(((w)>>16)&0x07)
> @@ -50,7 +47,7 @@ void __init usb_ehci_init(void);
>  #	define	 DEV_IDLE_EN		(1 << 13)
>  #	define	 OTG_RESET_DONE		(1 << 2)
>  #	define	 OTG_SOFT_RESET		(1 << 1)
> -#define OTG_SYSCON_2_REG		OTG_REG32(0x08)
> +#define OTG_SYSCON_2			(OTG_BASE + 0x08)
>  #	define	 OTG_EN			(1 << 31)
>  #	define	 USBX_SYNCHRO		(1 << 30)
>  #	define	 OTG_MST16		(1 << 29)
> @@ -68,7 +65,7 @@ void __init usb_ehci_init(void);
>  #	define	 HMC_TLLSPEED		(1 << 7)
>  #	define	 HMC_TLLATTACH		(1 << 6)
>  #	define	 OTG_HMC(w)		(((w)>>0)&0x3f)
> -#define OTG_CTRL_REG			OTG_REG32(0x0c)
> +#define OTG_CTRL			(OTG_BASE + 0x0c)
>  #	define	 OTG_USB2_EN		(1 << 29)
>  #	define	 OTG_USB2_DP		(1 << 28)
>  #	define	 OTG_USB2_DM		(1 << 27)
> @@ -95,7 +92,7 @@ void __init usb_ehci_init(void);
>  #	define	 OTG_PD_VBUS		(1 << 2)
>  #	define	 OTG_PU_VBUS		(1 << 1)
>  #	define	 OTG_PU_ID		(1 << 0)
> -#define OTG_IRQ_EN_REG			OTG_REG16(0x10)
> +#define OTG_IRQ_EN			(OTG_BASE + 0x10)	/* 16-bit */
>  #	define	 DRIVER_SWITCH		(1 << 15)
>  #	define	 A_VBUS_ERR		(1 << 13)
>  #	define	 A_REQ_TMROUT		(1 << 12)
> @@ -105,9 +102,9 @@ void __init usb_ehci_init(void);
>  #	define	 B_SRP_DONE		(1 << 8)
>  #	define	 B_SRP_STARTED		(1 << 7)
>  #	define	 OPRT_CHG		(1 << 0)
> -#define OTG_IRQ_SRC_REG			OTG_REG16(0x14)
> +#define OTG_IRQ_SRC			(OTG_BASE + 0x14)	/* 16-bit */
>  	// same bits as in IRQ_EN
> -#define OTG_OUTCTRL_REG			OTG_REG16(0x18)
> +#define OTG_OUTCTRL			(OTG_BASE + 0x18)	/* 16-bit */
>  #	define	 OTGVPD			(1 << 14)
>  #	define	 OTGVPU			(1 << 13)
>  #	define	 OTGPUID		(1 << 12)
> @@ -120,13 +117,13 @@ void __init usb_ehci_init(void);
>  #	define	 USB0VDR		(1 << 2)
>  #	define	 USB0PDEN		(1 << 1)
>  #	define	 USB0PUEN		(1 << 0)
> -#define OTG_TEST_REG			OTG_REG16(0x20)
> -#define OTG_VENDOR_CODE_REG		OTG_REG32(0xfc)
> +#define OTG_TEST			(OTG_BASE + 0x20)	/* 16-bit */
> +#define OTG_VENDOR_CODE			(OTG_BASE + 0xfc)	/* 16-bit */
>  
>  /*-------------------------------------------------------------------------*/
>  
>  /* OMAP1 */
> -#define	USB_TRANSCEIVER_CTRL_REG	__REG32(0xfffe1000 + 0x0064)
> +#define	USB_TRANSCEIVER_CTRL		(0xfffe1000 + 0x0064)
>  #	define	CONF_USB2_UNI_R		(1 << 8)
>  #	define	CONF_USB1_UNI_R		(1 << 7)
>  #	define	CONF_USB_PORT0_R(x)	(((x)>>4)&0x7)
> -- 
> 1.5.3.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
