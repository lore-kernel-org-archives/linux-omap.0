From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 1/9] ehci: fix ehci pin mux init
Date: Thu, 6 Aug 2009 19:15:21 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940432AF3F8D@dbde02.ent.ti.com>
References: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com>
 <20090806124044.GN2358@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41728 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210AbZHFNpf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 09:45:35 -0400
In-Reply-To: <20090806124044.GN2358@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "david-b@pacbell.net" <david-b@pacbell.net>

> > +		omap_cfg_reg(W5_3430_USB3HS_TLL_DATA3);
> > +		omap_cfg_reg(AB12_3430_USB3HS_TLL_DATA4);
> > +		omap_cfg_reg(AB13_3430_USB3HS_TLL_DATA5);
> > +		omap_cfg_reg(AA13_3430_USB3HS_TLL_DATA6);
> > +		omap_cfg_reg(AA12_3430_USB3HS_TLL_DATA7);
> > +	}
> >
> >  	return;
> >  }
> 
> Hmm, is this safe to do? Or does it remember on the number of data lines
> that the transceiver uses? If so, maybe something like the recent mmc
> muxing could be done where the number of pins is passed from > > platform_data.

This is actually done in "PATCH[6/9] ehci: portwise configurations" where number of ports is being passed from platform files and muxing is done only for required lines.

> 
> This is assuming that the data lines do not have alternative pins.. In
> that case  only the common pins can be muxed and the rest would have to be > muxed in the board-*.c files.

These are common pins for HS USB ports 1/2/3 but muxing board specific pins such as PHY RESET is getting done in board-*.c files only.

> 
> Regards,
> 
> Tony
> 
> 
> > @@ -172,7 +171,7 @@ void __init usb_ehci_init(enum ehci_hcd_omap_mode
> phy_mode,
> >
> >  	/* Setup Pin IO MUX for EHCI */
> >  	if (cpu_is_omap34xx())
> > -		setup_ehci_io_mux();
> > +		setup_ehci_io_mux(phy_mode);
> >
> >  	if (platform_device_register(&ehci_device) < 0) {
> >  		printk(KERN_ERR "Unable to register HS-USB (EHCI) device\n");
> > --
> > 1.6.2.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

