From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v2 2/3] usb: musb: dsps: add phy control logic to glue
Date: Wed, 11 Jul 2012 10:48:19 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EAD01EE@DBDE01.ent.ti.com>
References: <1342002598-30633-1-git-send-email-x0132156@ti.com>
	<1342002598-30633-2-git-send-email-x0132156@ti.com>
 <CAAe_U6LuH+1gxHxvVwNb4fkFzVqEWUdPUhvSCBLPb44Ea_QqCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52535 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112Ab2GKKsZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jul 2012 06:48:25 -0400
In-Reply-To: <CAAe_U6LuH+1gxHxvVwNb4fkFzVqEWUdPUhvSCBLPb44Ea_QqCg@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "Santhapuri, Damodar" <x0132156@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>

Hi,
> On Wed, Jul 11, 2012 at 3:59 PM, Damodar Santhapuri <x0132156@ti.com>
> wrote:
> > From: Ajay Kumar Gupta <ajay.gupta@ti.com>
> >
> > AM335x uses NOP transceiver driver and need to enable builtin PHY
> > by writing into usb_ctrl register available in system control
> > module register space. This is being added at musb glue driver
> > layer untill a separate system control module driver is available.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > Signed-off-by: Damodar Santhapuri <x0132156@ti.com>
> > ---
> > Changes from v0:
> >         - Used platform_get_resource() instead of
> platform_get_resource_byname()
> > based on Kishon's comment.
> >
> >  arch/arm/mach-omap2/board-ti8168evm.c   |    1 -
> >  arch/arm/mach-omap2/omap_phy_internal.c |   35 ------------
> >  arch/arm/plat-omap/include/plat/usb.h   |    5 +-
> >  drivers/usb/musb/musb_dsps.c            |   87
> +++++++++++++++++++++++++------
> >  4 files changed, 73 insertions(+), 55 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-
> omap2/board-ti8168evm.c
> > index d4c8392..0c7c098 100644
> > --- a/arch/arm/mach-omap2/board-ti8168evm.c
> > +++ b/arch/arm/mach-omap2/board-ti8168evm.c
> > @@ -26,7 +26,6 @@
> >  #include <plat/usb.h>
> >
> >  static struct omap_musb_board_data musb_board_data = {
> > -       .set_phy_power  = ti81xx_musb_phy_power,
> >         .interface_type = MUSB_INTERFACE_ULPI,
> >         .mode           = MUSB_OTG,
> >         .power          = 500,
> > diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-
> omap2/omap_phy_internal.c
> > index d52651a..d80bb16 100644
> > --- a/arch/arm/mach-omap2/omap_phy_internal.c
> > +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> > @@ -254,38 +254,3 @@ void am35x_set_mode(u8 musb_mode)
> >
> >         omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
> >  }
> > -
> > -void ti81xx_musb_phy_power(u8 on)
> > -{
> > -       void __iomem *scm_base = NULL;
> > -       u32 usbphycfg;
> > -
> > -       scm_base = ioremap(TI81XX_SCM_BASE, SZ_2K);
> > -       if (!scm_base) {
> > -               pr_err("system control module ioremap failed\n");
> > -               return;
> > -       }
> > -
> > -       usbphycfg = __raw_readl(scm_base + USBCTRL0);
> > -
> > -       if (on) {
> > -               if (cpu_is_ti816x()) {
> > -                       usbphycfg |= TI816X_USBPHY0_NORMAL_MODE;
> > -                       usbphycfg &= ~TI816X_USBPHY_REFCLK_OSC;
> > -               } else if (cpu_is_ti814x()) {
> > -                       usbphycfg &= ~(USBPHY_CM_PWRDN |
> USBPHY_OTG_PWRDN
> > -                               | USBPHY_DPINPUT | USBPHY_DMINPUT);
> > -                       usbphycfg |= (USBPHY_OTGVDET_EN |
> USBPHY_OTGSESSEND_EN
> > -                               | USBPHY_DPOPBUFCTL |
> USBPHY_DMOPBUFCTL);
> > -               }
> > -       } else {
> > -               if (cpu_is_ti816x())
> > -                       usbphycfg &= ~TI816X_USBPHY0_NORMAL_MODE;
> > -               else if (cpu_is_ti814x())
> > -                       usbphycfg |= USBPHY_CM_PWRDN |
> USBPHY_OTG_PWRDN;
> > -
> > -       }
> > -       __raw_writel(usbphycfg, scm_base + USBCTRL0);
> > -
> > -       iounmap(scm_base);
> > -}
> > diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-
> omap/include/plat/usb.h
> > index 548a4c8..c2aa4ae 100644
> > --- a/arch/arm/plat-omap/include/plat/usb.h
> > +++ b/arch/arm/plat-omap/include/plat/usb.h
> > @@ -95,7 +95,6 @@ extern void am35x_musb_reset(void);
> >  extern void am35x_musb_phy_power(u8 on);
> >  extern void am35x_musb_clear_irq(void);
> >  extern void am35x_set_mode(u8 musb_mode);
> > -extern void ti81xx_musb_phy_power(u8 on);
> >
> >  /* AM35x */
> >  /* USB 2.0 PHY Control */
> > @@ -120,8 +119,8 @@ extern void ti81xx_musb_phy_power(u8 on);
> >  #define CONF2_DATPOL           (1 << 1)
> >
> >  /* TI81XX specific definitions */
> > -#define USBCTRL0       0x620
> > -#define USBSTAT0       0x624
> > +#define MUSB_USBSS_REV_816X    0x9
> > +#define MUSB_USBSS_REV_814X    0xb
> >
> >  /* TI816X PHY controls bits */
> >  #define TI816X_USBPHY0_NORMAL_MODE     (1 << 0)
> > diff --git a/drivers/usb/musb/musb_dsps.c
> b/drivers/usb/musb/musb_dsps.c
> > index 494772f..72eda64 100644
> > --- a/drivers/usb/musb/musb_dsps.c
> > +++ b/drivers/usb/musb/musb_dsps.c
> > @@ -115,9 +115,46 @@ struct dsps_glue {
> >         struct platform_device *musb;   /* child musb pdev */
> >         const struct dsps_musb_wrapper *wrp; /* wrapper register
> offsets */
> >         struct timer_list timer;        /* otg_workaround timer */
> > +       u32 __iomem *usb_ctrl;
> > +       u8      usbss_rev;
> >  };
> >
> >  /**
> > + * musb_dsps_phy_control - phy on/off
> > + * @glue: struct dsps_glue *
> > + * @on: flag for phy to be switched on or off
> > + *
> > + * This is to enable the PHY using usb_ctrl register in system
> control
> > + * module space.
> > + *
> > + * XXX: This function will be removed once we have a seperate driver
> for
> > + * control module
> > + */
> > +static void musb_dsps_phy_control(struct dsps_glue *glue, u8 on)
> 
> I think this function should be added in your transceiver driver. I
> don't see glue as an appropriate place for this

We use NOP transceiver which is generic and used by many other platforms.
This function is specific to am33xx glue and so musb_dsps.c is right place.

Thanks,
Ajay
> > +{
> > +       u32 usbphycfg;
> > +
> > +       usbphycfg = __raw_readl(glue->usb_ctrl);
> > +
> > +       if (on) {
> > +               if (glue->usbss_rev == MUSB_USBSS_REV_816X) {
> > +                       usbphycfg |= TI816X_USBPHY0_NORMAL_MODE;
> > +                       usbphycfg &= ~TI816X_USBPHY_REFCLK_OSC;
> > +               } else if (glue->usbss_rev == MUSB_USBSS_REV_814X) {
> > +                       usbphycfg &= ~(USBPHY_CM_PWRDN |
> USBPHY_OTG_PWRDN
> > +                               | USBPHY_DPINPUT | USBPHY_DMINPUT);
> > +                       usbphycfg |= (USBPHY_OTGVDET_EN |
> USBPHY_OTGSESSEND_EN
> > +                               | USBPHY_DPOPBUFCTL |
> USBPHY_DMOPBUFCTL);
> > +               }
> > +       } else {
> > +               if (glue->usbss_rev == MUSB_USBSS_REV_816X)
> > +                       usbphycfg &= ~TI816X_USBPHY0_NORMAL_MODE;
> > +               else if (glue->usbss_rev == MUSB_USBSS_REV_814X)
> > +                       usbphycfg |= USBPHY_CM_PWRDN |
> USBPHY_OTG_PWRDN;
> > +       }
> > +       __raw_writel(usbphycfg, glue->usb_ctrl);
> > +}
> > +/**
> 
> Thanks
> Kishon
