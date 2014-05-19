From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Mon, 19 May 2014 09:04:48 -0700
Message-ID: <20140519160447.GB4849@atomide.com>
References: <20140513152518.GA16837@atomide.com>
 <53730AFB.2090800@ti.com>
 <20140514160216.GD18463@atomide.com>
 <537487AE.3060906@ti.com>
 <20140515182133.GC23659@atomide.com>
 <5375A8A8.7080306@ti.com>
 <20140516160717.GD22031@atomide.com>
 <20140516174158.GA11733@earth.universe>
 <20140516180154.GG22031@atomide.com>
 <5379CD24.6040508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64634 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbaESQE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 12:04:59 -0400
Content-Disposition: inline
In-Reply-To: <5379CD24.6040508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140519 02:22]:
> On 16/05/14 21:01, Tony Lindgren wrote:
> 
> >> IMHO appending -omap-dss to a random device is an even bigger hack,
> >> since its adding lots of bloat to the API. Let's assume there is
> >> another OS using DT for ARM, but has no proper API for SPI
> >> controllers and it introduces your hack to SPI devices. That would
> >> mean each SPI device has -omap-spi appended (or -exynos-spi,
> >> -foo-spi, ...). At least I would blame them for creating a huge
> >> unmaintainable mess.
> > 
> > I think you're misunderstanding. I do not want the naming to
> > be Linux specific. The naming should naturally be as hardware
> > specific as possible. In this case something like:
> > 
> > compatible = "sharp,ls037v7dw01-dss", "sharp,ls037v7dw01";
> > 
> > Or we should probably use:
> > 
> > compatible = "sharp,ls037v7dw01-dpi", "sharp,ls037v7dw01";
> > 
> > As dpi here reflects the hardware it's connected to. The dss
> > is probably a Linux name.
> 
> Well, "dss" or "omapdss" is as much a hardware term as "dpi". And "dpi"
> wouldn't really be a good extension, as what we want is an omapdss
> driver specific compatible string. So I think "-omapdss" is the best
> extension if that method is used.
> 
> But I don't think that's really the point. The point is that the panel's
> compatible string should be "sharp,ls037v7dw01", nothing else.
> 
> All the variations of "sharp,ls037v7dw01-dss" are not correct, and are
> only made for Linux SW reasons. So I would say they are Linux specific
> SW names, even if the words themselves are also HW terms.

If you really want to use only "sharp,ls037v7dw01" as the compatible
string, then you can still do that and bail out from the undesired
drivers by using of_machine_is_compatible check.

In many cases however we do have multiple compatible strings that
describe how the device is wired. See drivers/tty/serial/of_serial.c
for example. It has "ns16550" but then it also has additional
"nvidia,tegra20-uart", "nxp,lpc3220-uart" and "ibm,qpace-nwp-serial".
 
> > Not use what you're after with the SPI example though, but sounds
> > like that's something different.
> 
> I think Sebastien's example is just like the issue here.

Hmm is there some existing example in the kernel like that?

Regards,

Tony
