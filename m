From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 1/3 v3] AM35x: Add musb support
Date: Tue, 1 Jun 2010 16:38:15 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E6D2AD1@dbde02.ent.ti.com>
References: <1274769522-28212-1-git-send-email-ajay.gupta@ti.com>
 <4BFFCE8C.40909@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35606 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab0FALIS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 07:08:18 -0400
In-Reply-To: <4BFFCE8C.40909@ru.mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
[..]
> > +	 * We have to override VBUS/ID signals when MUSB is configured into
> the
> > +	 * host-only mode -- ID pin will float if no cable is connected, so
> the
> > +	 * controller won't be able to drive VBUS thinking that it's a B-
> device.
> > +	 * Otherwise, we want to use the OTG mode and enable VBUS
> comparators.
> > +	 */
> > +	devconf2 &= ~CONF2_OTGMODE;
> > +#ifdef	CONFIG_USB_MUSB_HOST
> > +	devconf2 |=  CONF2_FORCE_HOST;
> 
>     Well, this is only necessary if the board doesn't have pulldown on
> the USB ID signal. On DA830 EVM, rev. of the board A had it, and it got
> removed on the later revisions (presumably it conflicted with OTG
> function?), so this override became necessary. So, make sure this is
> indeed necessary on your board as using the overrides isn't generally
> desirable (they all also override VBUS sensing in addition to ID pin).

Yes, it's not needed for AM3517EVM

-Ajay
> 
> > +#else
> > +	devconf2 |=  CONF2_SESENDEN | CONF2_VBDTCTEN;
> > +#endif
> > +
> > +	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
> > +
> > +	usb_musb_init(&musb_board_data);
> > +}
> > +
> >  static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst
> = {
> >  	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
> >  #if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
> 
> WBR, Sergei
