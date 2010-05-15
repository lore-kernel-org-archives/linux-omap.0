From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 2/3 v2] musb: add musb support for AM35x
Date: Sat, 15 May 2010 07:24:20 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E5350D2@dbde02.ent.ti.com>
References: <1273838737-6995-1-git-send-email-ajay.gupta@ti.com>
	 <1273838737-6995-2-git-send-email-ajay.gupta@ti.com>
 <AANLkTim_Ii_2qNt30ZXbseT-dWPB7kJCq72sTXRhG686@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59185 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab0EOBy2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 21:54:28 -0400
In-Reply-To: <AANLkTim_Ii_2qNt30ZXbseT-dWPB7kJCq72sTXRhG686@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@gmail.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
> Ajay Kumar Gupta <ajay.gupta@ti.com> wrote:
> > AM35x is based on OMAP35x but has an updated musb interface which
> > uses CPPI4.1 DMA engine.
> >
> > Current patch supports only PIO mode transfers.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > ---
> > Changes from v1: (Based on Sergei's comment)
> > =A0 =A0 =A0 =A0- Moved PHY clock and OTGMODE settings to board file=
s
> > =A0 =A0 =A0 =A0- Added clk_disable/put in exit path
> > =A0 =A0 =A0 =A0- Removed unwanted code related to vbus
> > =A0 =A0 =A0 =A0- Removed unhandled interrupt check
> > =A0 =A0 =A0 =A0- Added timeout in phy_on()
> > I had to use MACH_OMAP3517EVM as there is no ARCH_xxx config specif=
ic to
> > AM3517 platforms other than ARCH_OMAP3.
> >
> > =A0drivers/usb/musb/Kconfig =A0| =A0 =A04 +-
> > =A0drivers/usb/musb/Makefile | =A0 =A04 +
> > =A0drivers/usb/musb/am3517.c | =A0517
[..]
> > +
> > +static inline void phy_on(void)
> > +{
> > + =A0 =A0 =A0 unsigned long timeout =3D jiffies + msecs_to_jiffies(=
100);
> > + =A0 =A0 =A0 u32 devconf2;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Start the on-chip PHY and its PLL.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 devconf2 =3D omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2)=
;
> > +
> > + =A0 =A0 =A0 devconf2 &=3D ~(CONF2_RESET | CONF2_PHYPWRDN | CONF2_=
OTGPWRDN |
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONF2_PHY_GPIOMODE);
> > + =A0 =A0 =A0 devconf2 |=3D CONF2_PHY_PLLON | CONF2_DATPOL;
> > +
> > + =A0 =A0 =A0 omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
> > +
> > + =A0 =A0 =A0 DBG(1, "Waiting for PHY clock good...\n");
> > + =A0 =A0 =A0 while (!(omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & CONF2_PHYCLKGD)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG(1, "musb PHY cloc=
k good timed out\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> A 'break' would have been more appropriate.

Why?
'break' would bring in additional instruction and finally it would
return as the loop is already at the bottom of the function.

>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > +}
> > +
[..]
> > +int musb_platform_set_mode(struct musb *musb, u8 musb_mode)
> > +{
> > + =A0 =A0 =A0 u32 devconf2 =3D omap_ctrl_readl(AM35XX_CONTROL_DEVCO=
NF2);
> > +
> > + =A0 =A0 =A0 devconf2 &=3D ~CONF2_OTGMODE;
> > + =A0 =A0 =A0 switch (musb_mode) {
> > +#ifdef CONFIG_USB_MUSB_HDRC_HCD
> > + =A0 =A0 =A0 case MUSB_HOST: =A0 =A0 =A0 =A0 /* Force VBUS valid, =
ID =3D 0 */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devconf2 |=3D CONF2_FORCE_HOST;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > +#endif
> > +#ifdef CONFIG_USB_GADGET_MUSB_HDRC
> > + =A0 =A0 =A0 case MUSB_PERIPHERAL: =A0 /* Force VBUS valid, ID =3D=
 1 */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devconf2 |=3D CONF2_FORCE_DEVICE;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > +#endif
> > +#ifdef CONFIG_USB_MUSB_OTG
> > + =A0 =A0 =A0 case MUSB_OTG: =A0 =A0 =A0 =A0 =A0/* Don't override t=
he VBUS/ID
> comparators */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devconf2 |=3D CONF2_NO_OVERRIDE;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > +#endif
> > + =A0 =A0 =A0 default:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG(2, "Trying to set unsupported mod=
e %u\n",
> musb_mode);
> > + =A0 =A0 =A0 }
> Either the switch case or the compile time flag is redundant.
No. both has to be there.

'musb_mode' is an entry from user via sysfs for changing the
operating mode and if some modes are not even configured in
kernel then we should not switch the mode and also warn the
user for this.

Ajay
>=20
> > +
> > + =A0 =A0 =A0 omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
> > + =A0 =A0 =A0 return 0;
[..]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
