From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Reg pinmux driver for OMAP based SoC- AM335X
Date: Wed, 1 Feb 2012 10:04:55 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317BB650@DBDE01.ent.ti.com>
References: <20120125000407.GU22818@atomide.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178CB82433@HQMAIL01.nvidia.com>
 <20120127020832.GJ29812@atomide.com>
 <20120127065752.GB32740@S2101-09.ap.freescale.net>
 <20120127170545.GH13504@atomide.com>
 <20120130015607.GA10470@S2101-09.ap.freescale.net>
 <20120130172042.GE9339@atomide.com>
 <20120131013215.GB24681@S2101-09.ap.freescale.net>
 <20120131022906.GH9339@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93176CAC6@DBDE01.ent.ti.com>
 <20120131170511.GI9339@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53334 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286Ab2BAKFF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 05:05:05 -0500
In-Reply-To: <20120131170511.GI9339@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>

On Tue, Jan 31, 2012 at 22:35:11, Tony Lindgren wrote:
> Hi,
> 
> * Mohammed, Afzal <afzal@ti.com> [120131 06:04]:
> > Hi Tony,
> > 
> > I am working on implementing pincontrol driver for AM335X SoC (OMAP34XX family).
> > 
> > Is there any specific plan you have in mind w.r.t incorporating
> > pincontrol driver for OMAP family of SoC's. There was an initial patch
> > for OMAP4 pin control driver, but it seems you were in favour of a
> > DT based approach. As per my understanding after going through few threads
> > (lot more remaining) is that pincontrol driver can be either a DT based
> > or non-DT based (either way we are going out of platform folders), and
> > it seems you prefer a DT based approach (have seen mentioning about
> > pinmux-simple.c).
> 
> With at least omaps, there are few good reasons to go for a common
> DT only driver:
> 
> 1. We already have about 6k lines of mux data and seem to be
>    adding several thousands of lines of mux data each year.
> 
> 2. The driver does not need this data, it just needs to know how
>    to operate certain kind of mux registers. The data is mostly
>    handy for developers for debugging, and that can be done via
>    debugfs and userspace tools.
>  
> > Tegra pincontrol driver posted recently, seems to use DT to distinguish only
> > the SoC type, with all the pincontrol information for SoC present in Kernel.
> > 
> > I would be thankful if you can give me some pointers on how to proceed for
> > AM335X pincontrol driver and/or any work in progress for OMAP pincontrol driver.
> 
> The plan is to deprecate the existing arch/arm/*omap*/*mux* code,
> and cut it down to minimum. And then add DT only mux support that should
> work for at least omap2+. That should work for am335x too.
> 
> There's currently some discussion going on regarding the pinmux device
> tree binding and how dynamic mux states should be handled. But I'd
> assume we'll have basic support available very soon.
> 
> The driver I'm working leaves all the data out of kernel, and the driver
> just knows how to handle a pinmux register instances. 

Tony,

Is this hosted or accessible somewhere? Just for reference...

Thanks,
Vaibhav

> Then debugging
> tools can be done in userspace via debugfs to display more detailed
> SoC specific information.
> 
> So it might be worth waiting just a little bit longer. If you have
> resources to spend on the pinmuxing, then creating some userspace tool
> to display SoC specific information would be nice :) For the userspace
> tool, we can use the data in arch/arm/mach-omap2/mux*2*.[ch].
> 
> Regards,
> 
> Tony
> 

