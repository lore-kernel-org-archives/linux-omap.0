From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Fri, 16 May 2014 09:07:17 -0700
Message-ID: <20140516160717.GD22031@atomide.com>
References: <5370E0C9.8050201@ti.com>
 <20140512155132.GH31772@atomide.com>
 <5371F923.80000@ti.com>
 <CABxcv==_LCw1kPYm17g=h8VfSN2V_qsgXjTnsy-JOetawSv4pA@mail.gmail.com>
 <20140513152518.GA16837@atomide.com>
 <53730AFB.2090800@ti.com>
 <20140514160216.GD18463@atomide.com>
 <537487AE.3060906@ti.com>
 <20140515182133.GC23659@atomide.com>
 <5375A8A8.7080306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53994 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757707AbaEPQHY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 12:07:24 -0400
Content-Disposition: inline
In-Reply-To: <5375A8A8.7080306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140515 22:57]:
> On 15/05/14 21:21, Tony Lindgren wrote:
> 
> >> But you're right, having "sharp,ls037v7dw01-omap-dss" in the .dts is an
> >> alternative for the compatible-string conversion we do now. I guess it's
> >> a matter of taste, but I rather hide it inside the kernel, in an
> >> internal omapdss file, than pollute the .dts files with those compatible
> >> strings.
> > 
> > Well it avoid you parsing through all the nodes during booting
> > and leaves out the function to do remapping. And removes the need
> > for maintaining a custom display mapping table. I'd say that's a
> > pretty good list of advantages right there :)
> 
> Yep... I don't know. Maybe I'm being too careful about doing wrong
> things with .dts. I just like it more if any hacks are in kernel code,
> which I can remove without anyone noticing.
> 
> Anyway, we already have board.dts files using the non-omapified
> compatible strings in the mainline, so if I would now add the omapified
> compatible strings to .dts files, those old board.dts files would break.
> 
> So I guess the choice has already been made.

I really think you should remove this misuse of device tree code ASAP.
It's better to fix it up now than carry the hack for next two years
and keep on adding to it.

Regards,

Tony
