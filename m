From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 13 Jan 2012 07:29:14 +0200
Message-ID: <1326432554.1700.6.camel@lappyti>
References: <WC20120109124643.880164@terrafix.co.uk>
	 <1326386551.1896.41.camel@deskari>  <87obu8sfx3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:35001 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750759Ab2AMF3V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 00:29:21 -0500
Received: by lagp5 with SMTP id p5so100038lag.35
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 21:29:18 -0800 (PST)
In-Reply-To: <87obu8sfx3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On Thu, 2012-01-12 at 14:40 -0800, Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> 
> > On Mon, 2012-01-09 at 12:46 +0000, Joe Woodward wrote:
> >> I'm running on a Gumstix Overo (OMAP3530) with an 24-bit LCD panel connected via the DPI interface (using the generic panel driver).
> >> 
> >> Entering standby used to work just fine on 3.0, but on 3.2 I get the following:
> >
> > I've been debugging this, but I'm at loss. I added some debug prints,
> > which I show below, and I also pushed them to
> > "git://gitorious.org/linux-omap-dss2/linux.git pm-test-prints" if
> > somebody wants to see exactly what they print.
> >
> > Kevin, perhaps you have an idea what could be wrong here. Long version
> > below, short version: doing system suspend breaks omapdss, if omapdss
> > uses pm_runtime_put, but works with pm_runtime_put_sync.
> 
> Is the pm_runtime_put() done after system suspend has started?  
> 
> After system suspend has begun, the workqueue used for async callbacks
> is frozen, so any runtime PM calls that you want to work during
> suspend/resume must use the _sync versions.

pm_runtime_put() is called inside omapdss driver's .suspend callback. So
I guess that means the system suspend has started. However, the logs
show that the runtime_suspend callback _is_ being called before the
system suspend is finished, so the workqueue can't be frozen...

 Tomi


