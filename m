From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH 2/3] usb: musb: dsps: add phy control logic to glue
Date: Tue, 10 Jul 2012 11:39:59 +0530
Message-ID: <CAAe_U6+mnS1k2F-aQXkcAS7ZH5pzeNGz6vc=xk+q60D6YF13aA@mail.gmail.com>
References: <1341841690-23899-1-git-send-email-x0132156@ti.com>
	<1341841690-23899-2-git-send-email-x0132156@ti.com>
	<CAAe_U6+wYsiVOvYm8t4g8P5R4jWzBCQhC-XBfNVgM4GqWi-JLQ@mail.gmail.com>
	<47CEF8C4B26E8C44B22B028A650E0EA93EACDF73@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:48507 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753730Ab2GJGKA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jul 2012 02:10:00 -0400
Received: by vbbfc26 with SMTP id fc26so9194182vbb.26
        for <linux-omap@vger.kernel.org>; Mon, 09 Jul 2012 23:09:59 -0700 (PDT)
In-Reply-To: <47CEF8C4B26E8C44B22B028A650E0EA93EACDF73@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Santhapuri, Damodar" <x0132156@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, Jul 10, 2012 at 11:35 AM, Gupta, Ajay Kumar <ajay.gupta@ti.com> wrote:
> Hi,
>>
>> On Mon, Jul 9, 2012 at 7:18 PM, Damodar Santhapuri <x0132156@ti.com>
>> wrote:
>> > From: Ajay Kumar Gupta <ajay.gupta@ti.com>
>> >
>> > AM335x uses NOP transceiver driver and need to enable builtin PHY
>> > by writing into usb_ctrl register available in system control
>> > module register space. This is being added at musb glue driver
>> > layer untill a separate system control module driver is available.
>> >
>> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>> > Signed-off-by: Damodar Santhapuri <x0132156@ti.com>
>> > ---
>> >  arch/arm/mach-omap2/board-ti8168evm.c   |    1 -
>> >  arch/arm/mach-omap2/omap_phy_internal.c |   35 ------------
>> >  arch/arm/plat-omap/include/plat/usb.h   |    5 +-
>> >  drivers/usb/musb/musb_dsps.c            |   88
>> +++++++++++++++++++++++++------
>> >  4 files changed, 74 insertions(+), 55 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-
>> omap2/board-ti8168evm.c
>> > index d4c8392..0c7c098 100644
>> > --- a/arch/arm/mach-omap2/board-ti8168evm.c
>> > +++ b/arch/arm/mach-omap2/board-ti8168evm.c
>> > @@ -26,7 +26,6 @@
>> >  #include <plat/usb.h>
>> >
>> >  static struct omap_musb_board_data musb_board_data = {
>> > -       .set_phy_power  = ti81xx_musb_phy_power,
>> >         .interface_type = MUSB_INTERFACE_ULPI,
>> >         .mode           = MUSB_OTG,
>> >         .power          = 500,
>> > diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-
>> omap2/omap_phy_internal.c
>> > index d52651a..d80bb16 100644
>> > --- a/arch/arm/mach-omap2/omap_phy_internal.c
>> > +++ b/arch/arm/mach-omap2/omap_phy_internal.c
>> > @@ -254,38 +254,3 @@ void am35x_set_mode(u8 musb_mode)
>> >
>> >         omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
>> >  }
>> > -
>> > -void ti81xx_musb_phy_power(u8 on)
>> > -{
>> > -       void __iomem *scm_base = NULL;
>> > -       u32 usbphycfg;
>> > -
>> > -       scm_base = ioremap(TI81XX_SCM_BASE, SZ_2K);
>> > -       if (!scm_base) {
>> > -               pr_err("system control module ioremap failed\n");
>> > -               return;
>> > -       }
>> > -
>> > -       usbphycfg = __raw_readl(scm_base + USBCTRL0);
>> > -
>> > -       if (on) {
>> > -               if (cpu_is_ti816x()) {
>> > -                       usbphycfg |= TI816X_USBPHY0_NORMAL_MODE;
>> > -                       usbphycfg &= ~TI816X_USBPHY_REFCLK_OSC;
>> > -               } else if (cpu_is_ti814x()) {
>> > -                       usbphycfg &= ~(USBPHY_CM_PWRDN |
>> USBPHY_OTG_PWRDN
>> > -                               | USBPHY_DPINPUT | USBPHY_DMINPUT);
>> > -                       usbphycfg |= (USBPHY_OTGVDET_EN |
>> USBPHY_OTGSESSEND_EN
>> > -                               | USBPHY_DPOPBUFCTL |
>> USBPHY_DMOPBUFCTL);
>> > -               }
>> > -       } else {
>> > -               if (cpu_is_ti816x())
>> > -                       usbphycfg &= ~TI816X_USBPHY0_NORMAL_MODE;
>> > -               else if (cpu_is_ti814x())
>> > -                       usbphycfg |= USBPHY_CM_PWRDN |
>> USBPHY_OTG_PWRDN;
>> > -
>> > -       }
>> > -       __raw_writel(usbphycfg, scm_base + USBCTRL0);
>> > -
>> > -       iounmap(scm_base);
>> > -}
>> > diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-
>> omap/include/plat/usb.h
>> > index 548a4c8..c2aa4ae 100644
>> > --- a/arch/arm/plat-omap/include/plat/usb.h
>> > +++ b/arch/arm/plat-omap/include/plat/usb.h
>> > @@ -95,7 +95,6 @@ extern void am35x_musb_reset(void);
>> >  extern void am35x_musb_phy_power(u8 on);
>> >  extern void am35x_musb_clear_irq(void);
>> >  extern void am35x_set_mode(u8 musb_mode);
>> > -extern void ti81xx_musb_phy_power(u8 on);
>> >
>> >  /* AM35x */
>> >  /* USB 2.0 PHY Control */
>> > @@ -120,8 +119,8 @@ extern void ti81xx_musb_phy_power(u8 on);
>> >  #define CONF2_DATPOL           (1 << 1)
>> >
>> >  /* TI81XX specific definitions */
>> > -#define USBCTRL0       0x620
>> > -#define USBSTAT0       0x624
>> > +#define MUSB_USBSS_REV_816X    0x9
>> > +#define MUSB_USBSS_REV_814X    0xb
>> >
>> >  /* TI816X PHY controls bits */
>> >  #define TI816X_USBPHY0_NORMAL_MODE     (1 << 0)
>> > diff --git a/drivers/usb/musb/musb_dsps.c
>> b/drivers/usb/musb/musb_dsps.c
>> > index 494772f..f7271c3 100644
>> > --- a/drivers/usb/musb/musb_dsps.c
>> > +++ b/drivers/usb/musb/musb_dsps.c
>> > @@ -115,9 +115,46 @@ struct dsps_glue {
>> >         struct platform_device *musb;   /* child musb pdev */
>> >         const struct dsps_musb_wrapper *wrp; /* wrapper register
>> offsets */
>> >         struct timer_list timer;        /* otg_workaround timer */
>> > +       u32 __iomem *usb_ctrl;
>> > +       u8      usbss_rev;
>> >  };
>> >
>> >  /**
>> > + * musb_dsps_phy_control - phy on/off
>> > + * @glue: struct dsps_glue *
>> > + * @on: flag for phy to be switched on or off
>> > + *
>> > + * This is to enable the PHY using usb_ctrl register in system
>> control
>> > + * module space.
>> > + *
>> > + * XXX: This function will be removed once we have a seperate driver
>> for
>> %s/seperate/separate
>> > + * control module
>> > + */
>> > +static void musb_dsps_phy_control(struct dsps_glue *glue, u8 on)
>> > +{
>> > +       u32 usbphycfg;
>> > +
>> > +       usbphycfg = __raw_readl(glue->usb_ctrl);
>>
>> How about using readl instead of __raw_readl here and below?
>> > +
>> > +       if (on) {
>> > +               if (glue->usbss_rev == MUSB_USBSS_REV_816X) {
>> > +                       usbphycfg |= TI816X_USBPHY0_NORMAL_MODE;
>> > +                       usbphycfg &= ~TI816X_USBPHY_REFCLK_OSC;
>> > +               } else if (glue->usbss_rev == MUSB_USBSS_REV_814X) {
>> > +                       usbphycfg &= ~(USBPHY_CM_PWRDN |
>> USBPHY_OTG_PWRDN
>> > +                               | USBPHY_DPINPUT | USBPHY_DMINPUT);
>> > +                       usbphycfg |= (USBPHY_OTGVDET_EN |
>> USBPHY_OTGSESSEND_EN
>> > +                               | USBPHY_DPOPBUFCTL |
>> USBPHY_DMOPBUFCTL);
>> > +               }
>> > +       } else {
>> > +               if (glue->usbss_rev == MUSB_USBSS_REV_816X)
>> > +                       usbphycfg &= ~TI816X_USBPHY0_NORMAL_MODE;
>> > +               else if (glue->usbss_rev == MUSB_USBSS_REV_814X)
>> > +                       usbphycfg |= USBPHY_CM_PWRDN |
>> USBPHY_OTG_PWRDN;
>> > +       }
>> > +       __raw_writel(usbphycfg, glue->usb_ctrl);
>> only writel()?
>> > +}
>> > +/**
>> >   * dsps_musb_enable - enable interrupts
>> >   */
>> >  static void dsps_musb_enable(struct musb *musb)
>> > @@ -363,11 +400,9 @@ static irqreturn_t dsps_interrupt(int irq, void
>> *hci)
>> >  static int dsps_musb_init(struct musb *musb)
>> >  {
>> >         struct device *dev = musb->controller;
>> > -       struct musb_hdrc_platform_data *plat = dev->platform_data;
>> >         struct platform_device *pdev = to_platform_device(dev-
>> >parent);
>> >         struct dsps_glue *glue = platform_get_drvdata(pdev);
>> >         const struct dsps_musb_wrapper *wrp = glue->wrp;
>> > -       struct omap_musb_board_data *data = plat->board_data;
>> >         void __iomem *reg_base = musb->ctrl_base;
>> >         u32 rev, val;
>> >         int status;
>> > @@ -395,8 +430,7 @@ static int dsps_musb_init(struct musb *musb)
>> >         dsps_writel(reg_base, wrp->control, (1 << wrp->reset));
>> >
>> >         /* Start the on-chip PHY and its PLL. */
>> > -       if (data->set_phy_power)
>> > -               data->set_phy_power(1);
>> > +       musb_dsps_phy_control(glue, 1);
>> >
>> >         musb->isr = dsps_interrupt;
>> >
>> > @@ -418,8 +452,6 @@ err0:
>> >  static int dsps_musb_exit(struct musb *musb)
>> >  {
>> >         struct device *dev = musb->controller;
>> > -       struct musb_hdrc_platform_data *plat = dev->platform_data;
>> > -       struct omap_musb_board_data *data = plat->board_data;
>> >         struct platform_device *pdev = to_platform_device(dev-
>> >parent);
>> >         struct dsps_glue *glue = platform_get_drvdata(pdev);
>> >
>> > @@ -427,8 +459,7 @@ static int dsps_musb_exit(struct musb *musb)
>> >                 del_timer_sync(&glue->timer);
>> >
>> >         /* Shutdown the on-chip PHY and its PLL. */
>> > -       if (data->set_phy_power)
>> > -               data->set_phy_power(0);
>> > +       musb_dsps_phy_control(glue, 0);
>> >
>> >         /* NOP driver needs change if supporting dual instance */
>> >         usb_put_phy(musb->xceiv);
>> > @@ -460,6 +491,22 @@ static int __devinit
>> dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
>> >         char res_name[10];
>> >         int ret;
>> >
>> > +       /* get memory resource for usb control register */
>> > +       sprintf(res_name, "usb_ctrl%d", id);
>> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> res_name);
>> Avoid getting resource by name.. With dt, you wont be able to do
>> those..
>
> When we are completely on DT then this would anyways go and we can
> get these resource data for each usb port from DT APIs.

Even with dt, you will still get the resources using
platform_get_resource() API's.. So why not have it that way from the
beginning itself..

Thanks
Kishon
