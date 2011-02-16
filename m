From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP3 & USB NFS root
Date: Wed, 16 Feb 2011 12:30:41 +0200
Message-ID: <1297852241.2713.22.camel@deskari>
References: <1297691206.2951.8.camel@deskari>
	 <20110214134842.GH2549@legolas.emea.dhcp.ti.com>
	 <1297692039.2951.10.camel@deskari>
	 <20110214140216.GJ2549@legolas.emea.dhcp.ti.com>
	 <1297838666.2031.8.camel@deskari>
	 <20110216080227.GB2497@legolas.emea.dhcp.ti.com>
	 <20110216080543.GD2497@legolas.emea.dhcp.ti.com>
	 <1297849461.5431.3.camel@deskari>
	 <20110216094918.GN2497@legolas.emea.dhcp.ti.com>
	 <1297850436.2713.2.camel@deskari>
	 <20110216102653.GR2497@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46079 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab1BPKap (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 05:30:45 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1GAUiH0032761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 04:30:44 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1GAUh6E005390
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 04:30:43 -0600 (CST)
In-Reply-To: <20110216102653.GR2497@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2011-02-16 at 04:26 -0600, Balbi, Felipe wrote:
> On Wed, Feb 16, 2011 at 12:00:36PM +0200, Tomi Valkeinen wrote:
> > On Wed, 2011-02-16 at 03:49 -0600, Balbi, Felipe wrote:
> > > Hi,
> > > 
> > > On Wed, Feb 16, 2011 at 11:44:21AM +0200, Tomi Valkeinen wrote:
> > > > Perhaps I'm missing some Kconfig option.
> > > 
> > > Yes, you have a problem on your Kconfig
> > > 
> > > <snip>
> > > 
> > > > CONFIG_USB_MUSB_HDRC=y
> > > > CONFIG_USB_MUSB_TUSB6010=y
> > > > # CONFIG_USB_MUSB_OMAP2PLUS is not set
> > > > # CONFIG_USB_MUSB_AM35X is not set
> > > 
> > > Since you're running on Overo, you need to use CONFIG_USB_MUSB_OMAP2PLUS
> > > instead of CONFIG_USB_MUSB_TUSB6010. We're still working to make those
> > > work together. Lots of re-work needs to be done on the DMA part before
> > > we can make all of them work together.
> > > 
> > > Fix that and it should work.
> > 
> > Ok, thanks, now it works! I set CONFIG_USB_MUSB_OMAP2PLUS, but that
> > didn't help alone. I also had to enable host side USB, select
> > CONFIG_USB_MUSB_OTG. With plain peripheral support nothing happened.
> 
> you need the other patch I sent before. Here it is:

Right you are =). Thanks.

 Tomi


