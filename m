From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 00/11] Prepare for OMAP2+ movement to Common Clk
Date: Wed, 27 Jun 2012 22:25:53 +0200
Message-ID: <2172351.1193SiRd5m@avalon>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <2606265.VPQJMxIymh@avalon> <alpine.DEB.2.00.1206271344200.27496@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:46376 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab2F0UZu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 16:25:50 -0400
In-Reply-To: <alpine.DEB.2.00.1206271344200.27496@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sakari Ailus <sakari.ailus@iki.fi>, khilman@ti.com

Hi Paul,

On Wednesday 27 June 2012 13:59:21 Paul Walmsley wrote:
> + Kevin
> 
> On Wed, 27 Jun 2012, Laurent Pinchart wrote:
> > OK, I think I've found the information. I'll give this a try.
> 
> That sounds great.

I'll repeat here what I've stated in my other mail, as Kevin is CC'ed.

I haven't had much luck, pm_runtime_get_sync() doesn't seem to enable the ISP 
clocks. I'd like to trace what happens (or rather doesn't happen), but I'm not 
familiar with runtime PM internals. What's the call stack from 
pm_runtime_get_sync() to the arch code that's supposed to enable clocks ?

> > What is still not clear to me is how runtime PM and system PM interact.
> > For instance the OMAP3 ISP driver disables its clocks in the system PM
> > suspend handler, and restarts them in the system PM resume handler. How do
> > I port that to runtime PM, can I just call pm_runtime_put() and
> > pm_runtime_get_sync() in the system PM handlers ?
> 
> I've lost track of what the official guidance on this is.

That's what has always bothered me with runtime PM, I've never been able to 
find clear official guidelines (possibly because there are none).

(Along with the fact that, for the OMAP3 ISP, I still don't see what benefits 
the runtime PM complexity will bring)

> But we have plenty of drivers that do this. A few examples are
> drivers/mmc/host/omap_hsmmc.c, drivers/spi/spi-omap2-mcspi.c, and the DSS
> drivers.
> 
> IMHO, if possible, for the driver's system suspend call, the best thing to
> do is to check to see if the driver is currently doing something. If it is, 
then ask it to stop. Then wait until it does. When it stops, that other part
> of the driver is ideally what should do the pm_runtime_put*().

I don't think I can do that. The omap3-isp driver implements a PM prepare 
operation that stops all device activity, and a PM suspend operation that 
turns off the clocks. The reason for that split is that the sensor (which has 
its own device, its own driver and its own PM operations) needs to be 
suspended after the ISP is stopped, but before the clocks are turned off.

My suspend handler thus needs to stop the clocks without performing any other 
operation. Calling pm_runtime_put() there is an option, I'll try it. It seems 
to be legal, as the hsmmc driver uses pm_runtime_put_sync() in its suspend 
handler. Is the _sync required there BTW ? Won't system suspend turn the 
clocks off anyway ? Or would there be a problem at resume time ?

> It's been a long time since I've looked, but I'd be surprised if we had
> many drivers that operated like that...

-- 
Regards,

Laurent Pinchart

