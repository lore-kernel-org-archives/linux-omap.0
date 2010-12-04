From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] musb: am35x: fix compile error due to control apis
Date: Sat, 4 Dec 2010 19:27:21 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BCE39F00@dbde02.ent.ti.com>
References: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com>
 <4CF943B5.2000303@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48572 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755008Ab0LDN5b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Dec 2010 08:57:31 -0500
In-Reply-To: <4CF943B5.2000303@ru.mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>

> > diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-
> musb.c
> > index 7260558..1f32fdb 100644
> > --- a/arch/arm/mach-omap2/usb-musb.c
> > +++ b/arch/arm/mach-omap2/usb-musb.c
> > @@ -33,6 +33,82 @@
> >
> >  #ifdef CONFIG_USB_MUSB_SOC
> >
> > +static void am35x_musb_phy_power(u8 on)
> > +{
> > +	unsigned long timeout = jiffies + msecs_to_jiffies(100);
> > +	u32 devconf2;
> > +
> > +	if (on) {
> > +		/*
> > +		 * Start the on-chip PHY and its PLL.
> > +		 */
> > +		devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
> > +
> > +		devconf2 &= ~(CONF2_RESET | CONF2_PHYPWRDN | CONF2_OTGPWRDN);
> > +		devconf2 |= CONF2_PHY_PLLON;
> > +
> > +		omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
> > +
> > +		printk(KERN_INFO "Waiting for PHY clock good...\n");
> 
>     pr_info().

This file already uses printk() so used it for uniformity.
> 
> > +		while (!(omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2)
> > +				& CONF2_PHYCLKGD)) {
> > +			cpu_relax();
> > +
> > +			if (time_after(jiffies, timeout)) {
> > +				printk(KERN_ERR "musb PHY clock good timed
> out\n");
> 
>     pr_err().
> 
> > diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-
> omap/include/plat/usb.h
> > index 59c7fe7..4299097 100644
> > --- a/arch/arm/plat-omap/include/plat/usb.h
> > +++ b/arch/arm/plat-omap/include/plat/usb.h
> > @@ -69,6 +69,9 @@ struct omap_musb_board_data {
> >  	u8	mode;
> >  	u16	power;
> >  	unsigned extvbus:1;
> > +	void	(*set_phy_power) (u8 on);
> > +	void	(*clear_irq) (void);
> > +	void	(*set_mode) (u8 mode);
> 
>     Should be no spaces between ) and (. scripts/checkpatch.pl used to
> complain
> about such things, now it's silent though...
Yes, I tried with ./scripts/checkpatch and didn't get any error/warning.

> 
> > @@ -364,37 +324,21 @@ eoi:
> >
> >  int musb_platform_set_mode(struct musb *musb, u8 musb_mode)
> >  {
> > -	u32 devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
> > +	struct device *dev = musb->controller;
> > +	struct musb_hdrc_platform_data *plat = dev->platform_data;
> > +	struct omap_musb_board_data *data = plat->board_data;
> >
> > -	devconf2 &= ~CONF2_OTGMODE;
> > -	switch (musb_mode) {
> > -#ifdef	CONFIG_USB_MUSB_HDRC_HCD
> > -	case MUSB_HOST:		/* Force VBUS valid, ID = 0 */
> > -		devconf2 |= CONF2_FORCE_HOST;
> > -		break;
> > -#endif
> > -#ifdef	CONFIG_USB_GADGET_MUSB_HDRC
> > -	case MUSB_PERIPHERAL:	/* Force VBUS valid, ID = 1 */
> > -		devconf2 |= CONF2_FORCE_DEVICE;
> > -		break;
> > -#endif
> > -#ifdef	CONFIG_USB_MUSB_OTG
> > -	case MUSB_OTG:		/* Don't override the VBUS/ID comparators */
> > -		devconf2 |= CONF2_NO_OVERRIDE;
> > -		break;
> > -#endif
> > -	default:
> > -		DBG(2, "Trying to set unsupported mode %u\n", musb_mode);
> > -	}
> > +	if (data->set_mode)
> > +		data->set_mode(musb_mode);
> 
>     You should return -EIO if data->set_mode is NULL.
Ok fine...

Ajay
> 
> WBR, Sergei

