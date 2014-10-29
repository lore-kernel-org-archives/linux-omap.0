From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Wed, 29 Oct 2014 12:39:16 -0700
Message-ID: <20141029193915.GB2542@atomide.com>
References: <20141027200008.GR2560@atomide.com>
 <20141027230138.GB7805@drone.musicnaut.iki.fi>
 <20141028221243.GU2542@atomide.com>
 <5450EEE7.8070801@ti.com>
 <20141029185957.GA3723@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41290 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbaJ2Tkq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2014 15:40:46 -0400
Content-Disposition: inline
In-Reply-To: <20141029185957.GA3723@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>
Cc: Nishanth Menon <nm@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Sebastian Reichel <sre@ring0.de> [141029 12:01]:
> Hi,
> 
> On Wed, Oct 29, 2014 at 08:43:03AM -0500, Nishanth Menon wrote:
> > On 10/28/2014 05:12 PM, Tony Lindgren wrote:
> > > * Aaro Koskinen <aaro.koskinen@iki.fi> [141027 16:03]:
> > >> Hi,
> > >>
> > >> On Mon, Oct 27, 2014 at 01:00:09PM -0700, Tony Lindgren wrote:
> > >>> +
> > >>> +	if (!of_have_populated_dt())
> > >>> +		pr_warn("WARNING: legacy booting deprecated, please update to boot with .dts\n");
> > >>> +
> > >>
> > >> Maybe use WARN so that the warning is more verbose and kernel gets tainted?
> > > 
> > > Well I was hoping to avoid annoying people with the trace.
> > > But can do that if people prefer that, what do others think?
> > > 
> > 
> > WARN is better and eye catchy. Also, could we add information on when
> > the support will be removed since we call it deprecated?

Well quoting the hostage situation from a Mr. Show episode
"Now Who Wants Ice Cream?" the answer to that would be:

OK, you want me to guess? A hundred million days, or maybe ten more
minutes, somewhere in there, I just can't say, don't know.
 
> I also think, that more eye catchy is better.

OK, updated patch below. I'd like to add this to the current
-rc cycle unless people have objections to that.
 
> Apart from that I wonder if we should drop support on a
> board-by-board basis and then drop omap3 support completly once all
> boards have been dropped.

Yes. I'll post few patches from my old board removal branch at
omap-for-v3.14/omap3-board-removal shortly.

Regards,

Tony

8< -----------------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 27 Oct 2014 13:05:54 -0700
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode

We're moving omaps to use device tree based booting and already have
omap2, omap4, omap5, am335x and am437x booting in device tree only
mode.

Only omap3 still has legacy booting still around and we really want
to make that device tree only. So let's add a warning about deprecated
legacy booting so we get people to upgrade their boards to use device
tree based booting and find out about any remaining issues.

Note that for most boards we already have the .dts file and those can
be booted with without changing the bootloader using the appended
DTB mode.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -917,6 +917,10 @@ static int __init omap_device_late_idle(struct device *dev, void *data)
 static int __init omap_device_late_init(void)
 {
 	bus_for_each_dev(&platform_bus_type, NULL, NULL, omap_device_late_idle);
+
+	WARN(!of_have_populated_dt(),
+		"legacy booting deprecated, please update to boot with .dts\n");
+
 	return 0;
 }
 omap_late_initcall_sync(omap_device_late_init);
