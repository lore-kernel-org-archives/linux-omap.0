From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Thu, 7 Jun 2012 16:05:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206071404470.14977@utopia.booyaka.com>
References: <20120607060901.25532.68354.stgit@dusk> <20120607061308.25532.19767.stgit@dusk> <20120607073112.GX12766@atomide.com> <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com> <20120607075158.GZ12766@atomide.com> <alpine.DEB.2.00.1206070406050.6684@utopia.booyaka.com>
 <20120607105228.GC12766@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45532 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933041Ab2FGWFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 18:05:33 -0400
In-Reply-To: <20120607105228.GC12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

On Thu, 7 Jun 2012, Tony Lindgren wrote:

> Until we have something generic in place to deal with stuff like unused driver
> reset and idle, how about we set up the driver specific reset parts as inline
> functions in the driver header?

You're referring to the driver integration header files in 
arch/arm/plat-omap/include/ and arch/arm/mach-omap2/, right?  That would 
avoid the need for "sideways" includes from drivers/.

> That way the hwmod code can include those functions using the driver register
> defines. Something like:
> 
> static inline int xyz_driver_reset(void __iomem *base, int flags)
> {
> 	...
> }
> 
> Then instead of having a separate platform init file for each driver,
> we could just have a list of reset functions:
> 
> static int hwmod_xyz_driver_reset(void __iomem *base, int flags)

This should probably be passed a struct omap_hwmod * instead of base so 
it can call the existing hwmod bus related reset functions like 
omap_hwmod_softreset().  Or were you thinking about open-coding those into 
this reset function?

Just as an aside, this function will probably need to be marked 
__maybe_unused, so the compiler doesn't warn when other files include this 
header, but don't call the function.

> {
> 	int res;
> 
> 	/* do bus related reset here */
> 	...
>
> 	/* call the driver reset */
> 	res = xyz_driver_reset(base, flags)
> 
> 
> 	/* do more bus related reset here */
> 	...
> }

That's fine with me.  It doesn't matter to me where that code lives as 
long as it makes technical sense.

I'm hoping that in the near future that we can get rid of these 
hwmod_xyz_driver_reset() functions.  Instead it should be possible to have 
the hwmod reset code call functions like xyz_driver_reset_pre_wait() and 
xyz_driver_reset_post_ocpreset() via optional function pointers at 
different points in the reset process.  That should allow us to remove the 
omap_hwmod function calls from the I2C, MSDI, etc. reset functions, and 
also remove some needlessly duplicated code.


- Paul
