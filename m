From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 3/6 v2] omap: musb: ti81xx: Add phy power function
Date: Thu, 8 Sep 2011 16:23:22 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404EC6BF3C9@dbde02.ent.ti.com>
References: <1315414945-19829-1-git-send-email-ajay.gupta@ti.com>
 <1315414945-19829-4-git-send-email-ajay.gupta@ti.com>
 <4E689CCD.2050708@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E689CCD.2050708-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> On 07-09-2011 21:02, Ajay Kumar Gupta wrote:
> 
> > Adding ti81xx_musb_phy_power() which will be used by musb driver
> through
> > its function pointer in board_data.
> 
> > Signed-off-by: Ajay Kumar Gupta<ajay.gupta-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Ravi Babu<ravibabu-l0cyMroinI0@public.gmane.org>
> > ---
> >   arch/arm/mach-omap2/omap_phy_internal.c |   24
> +++++++++++++++++++++++
> >   arch/arm/plat-omap/include/plat/usb.h   |   32
> +++++++++++++++++++++++++++++++
> >   2 files changed, 56 insertions(+), 0 deletions(-)
> 
> > diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-
> omap2/omap_phy_internal.c
> > index 58775e3..352b6af 100644
> > --- a/arch/arm/mach-omap2/omap_phy_internal.c
> > +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> > @@ -260,3 +260,27 @@ void am35x_set_mode(u8 musb_mode)
> >
> >   	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
> >   }
> > +
> > +void ti81xx_musb_phy_power(u8 on)
> > +{
> > +	u32 usbphycfg = omap_ctrl_readl(USBCTRL0);
> > +
> > +	if (on) {
> > +		if (cpu_is_ti816x()) {
> > +			usbphycfg |= TI816X_USBPHY0_NORMAL_MODE;
> > +			usbphycfg &= ~TI816X_USBPHY_REFCLK_OSC;
> > +		} else if (cpu_is_ti814x()) {
> > +			usbphycfg&= ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN
> > +				| USBPHY_DPINPUT | USBPHY_DMINPUT);
> > +			usbphycfg |= (USBPHY_OTGVDET_EN |
> USBPHY_OTGSESSEND_EN
> > +				| USBPHY_DPOPBUFCTL | USBPHY_DPOPBUFCTL);
> 
>     Same #define repeated twice?

Good catch.. thanks. One of them should be USBPHY_DMOPBUFCTL, will fix in v3.

Ajay
> 
> WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
