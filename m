From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: Reg pinmux driver for OMAP based SoC- AM335X
Date: Wed, 1 Feb 2012 11:00:05 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93176D1F3@DBDE01.ent.ti.com>
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
Received: from comal.ext.ti.com ([198.47.26.152]:46802 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845Ab2BALAM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 06:00:12 -0500
In-Reply-To: <20120131170511.GI9339@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>

Hi Tony,

On Tue, Jan 31, 2012 at 22:35:11, Tony Lindgren wrote:
> The plan is to deprecate the existing arch/arm/*omap*/*mux* code,
> and cut it down to minimum. And then add DT only mux support that should
> work for at least omap2+. That should work for am335x too.
> 
> There's currently some discussion going on regarding the pinmux device
> tree binding and how dynamic mux states should be handled. But I'd
> assume we'll have basic support available very soon.
> 
> The driver I'm working leaves all the data out of kernel, and the driver
> just knows how to handle a pinmux register instances. Then debugging
> tools can be done in userspace via debugfs to display more detailed
> SoC specific information.
> 
> So it might be worth waiting just a little bit longer. If you have
> resources to spend on the pinmuxing, then creating some userspace tool
> to display SoC specific information would be nice :) For the userspace
> tool, we can use the data in arch/arm/mach-omap2/mux*2*.[ch].

Thank you for the detailed reply.

I will wait for it and willing to help you in its testing.

I have been tasked on getting AM335X supported well in mainline,
and will move to other aspects of it while waiting.

Regards
Afzal
