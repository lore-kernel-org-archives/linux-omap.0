From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/2] Putting TPS6235x into the power regulator framework
Date: Thu, 4 Dec 2008 13:41:40 +0200
Message-ID: <20081204114140.GQ10209@gandalf.research.nokia.com>
References: <20081204111909.GN10209@gandalf.research.nokia.com> <19F8576C6E063C45BE387C64729E739403E90E7238@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53849 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbYLDLmt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 06:42:49 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E90E7238@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Dec 04, 2008 at 05:05:26PM +0530, ext Pillai, Manikandan wrote:
> Hi,
> 
> Pls find comments inlined.
> 
> regards
> 
> 
> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> Sent: Thursday, December 04, 2008 4:49 PM
> To: ext y@india.ti.com
> Cc: linux-omap@vger.kernel.org; Pillai, Manikandan
> Subject: Re: [PATCH 2/2] Putting TPS6235x into the power regulator framework
> 
> On Thu, Dec 04, 2008 at 03:55:06PM +0530, ext y@india.ti.com wrote:
> > From: Manikandan Pillai <mani.pillai@ti.com>
> >
> > Resending this patch with comments fixed :
> > This patch moves the TPS6235x drivers from the drivers/i2c to drivers/
> > regulator to put the TPS6235x drivers under the power regulator framework
> >
> > suffix core_pwr and mpu_pwr has been removed
> > I2C bus speeds replaced with numbers again
> > Camel case has been removed
> > TPS moved into regulator framework and drivers/i2c/chips left untouched.
> >
> > Not fixed comments:
> > Not clear on how to implement runtime check for PR785 and would require some
> > inputs on implementing the same.
> 
> This patch should be broken into smaller pieces.
> [Pillai, Manikandan] OK
> 
> The tps driver should come separated, drivers/regulator/core.c should go
> to the maintainer in a separate patch, i2c-omap.c adding the i2c4
> support, should be in a separate patch and Ccing Ben Dooks and Jean
> Delvare.
> [Pillai, Manikandan] In core.c, I am just moving the definition of a struct to
> the header file.

yes and you should let the maintainer of that driver know about it and
see if he agrees with that. Otherwise we'll be adding an omap fork of an
upstream driver.

> heh, i thought bus4 wasn't sw controllable :-s
> 
> [Pillai, Manikandan] Bus 4 can be used to write from master. It cannot be used to read.

good to know ;-)

> this is not the correct place for it as only one board has this driver.
> Move it to the proper board-file.
> 
> [Pillai, Manikandan] I will move it to board-omap3evm.c

good.

> supply should be Vdd, or Vbus or something more useful, not the chip's
> name.
> [Pillai, Manikandan] Shall make it vdd1 and vdd2 and map it exactly as in
> OMAP spec.

Most likely yeah, then it's also easy to search in the docs for
references ;-)

-- 
balbi
