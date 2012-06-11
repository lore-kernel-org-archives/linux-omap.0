From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Sun, 10 Jun 2012 23:21:11 -0700
Message-ID: <20120611062109.GR12766@atomide.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061308.25532.19767.stgit@dusk>
 <20120607073112.GX12766@atomide.com>
 <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com>
 <20120607075158.GZ12766@atomide.com>
 <alpine.DEB.2.00.1206070406050.6684@utopia.booyaka.com>
 <20120607105228.GC12766@atomide.com>
 <alpine.DEB.2.00.1206071404470.14977@utopia.booyaka.com>
 <20120608063859.GL12766@atomide.com>
 <alpine.DEB.2.00.1206081929000.23401@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51573 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147Ab2FKGVN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 02:21:13 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1206081929000.23401@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

* Paul Walmsley <paul@pwsan.com> [120608 18:35]:
> On Thu, 7 Jun 2012, Tony Lindgren wrote:
> 
> > Oh OK yeah makes sense as that's hwmod internal function. Then the driver
> > specific part should use just void __iomem *base and use readl/writel and
> > live under include/linux/platform_data/omap-usb.h.
> 
> This sounds like something that might be flame-bait, since these functions 
> aren't platform_data.

They at least should be as both platform init code and the driver will
potentially use these functions.
 
> How about putting these functions in arch/arm/plat-omap/include/plat?  
> Drivers are able to include those files easily.

We need to pretty much get rid of all those headers and make them driver
specific for the multi-zimage support. Drivers should be arch independent,
and whatever parts need to be shared between platform init code and drivers
should follow the standard platform driver stuff.

The other place would be just the standard driver include at somewhere
like include/linux/usb/omap-usb.h etc.

Regards,

Tony
