From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Fri, 8 Jun 2012 19:31:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206081929000.23401@utopia.booyaka.com>
References: <20120607060901.25532.68354.stgit@dusk> <20120607061308.25532.19767.stgit@dusk> <20120607073112.GX12766@atomide.com> <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com> <20120607075158.GZ12766@atomide.com> <alpine.DEB.2.00.1206070406050.6684@utopia.booyaka.com>
 <20120607105228.GC12766@atomide.com> <alpine.DEB.2.00.1206071404470.14977@utopia.booyaka.com> <20120608063859.GL12766@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45810 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121Ab2FIBbU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 21:31:20 -0400
In-Reply-To: <20120608063859.GL12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

On Thu, 7 Jun 2012, Tony Lindgren wrote:

> Oh OK yeah makes sense as that's hwmod internal function. Then the driver
> specific part should use just void __iomem *base and use readl/writel and
> live under include/linux/platform_data/omap-usb.h.

This sounds like something that might be flame-bait, since these functions 
aren't platform_data.

How about putting these functions in arch/arm/plat-omap/include/plat?  
Drivers are able to include those files easily.


- Paul
