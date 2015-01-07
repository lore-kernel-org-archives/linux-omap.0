From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Wed, 7 Jan 2015 22:25:04 +0100
Message-ID: <20150107212504.GB18417@amd>
References: <20150105230228.GO4081@atomide.com>
 <20150106080025.GA6752@amd>
 <20150106165903.GF4025@atomide.com>
 <20150107095703.GA15925@amd>
 <54AD5447.2070601@ti.com>
 <20150107164005.GD4081@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55503 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275AbbAGVZH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2015 16:25:07 -0500
Content-Disposition: inline
In-Reply-To: <20150107164005.GD4081@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>

On Wed 2015-01-07 08:40:06, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [150107 07:47]:
> > On 01/07/2015 03:57 AM, Pavel Machek wrote:
> > > On Tue 2015-01-06 08:59:03, Tony Lindgren wrote:
> > >> * Pavel Machek <pavel@ucw.cz> [150106 00:03]:
> > >>> On Mon 2015-01-05 15:02:29, Tony Lindgren wrote:
> > >>>> Revert "ARM: dts: Disable smc91x on n900 until bootloader
> > >>>> dependency is removed". We've now fixed the issues that
> > >>>> caused problems with uninitialized hardware depending on
> > >>>> the bootloader version. Mostly things got fixed with
> > >>>> the following commits:
> > >>>>
> > >>>> 9a894953a97b ("ARM: dts: Fix bootloader version dependencies by muxing n900 smc91x pins")
> > >>>> 7d2911c43815 ("net: smc91x: Fix gpios for device tree based booting")
> > >>>>
> > >>>> Note that this only affects the early development boards
> > >>>> with Ethernet that we still have in a few automated boot
> > >>>> test systems.
> > >>>>
> > >>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >>>
> > >>> Normally, the early development boards should have separate dts file
> > >>> (then include common parts), no?
> > >>
> > >> In this case it won't matter. The GPMC hardware is there, the probe
> > >> just fails if no smsc91x is found.
> > >>  
> > >>> Could you at least add a note to the dts file what is it? Because I
> > >>> always thought it is a bug.
> > >>
> > >> Sure, updated patch below. Can somebody please test boot it on
> > >> a production n900 too to make sure it no longer causes issues?
> > > 
> > > Actually... how do you manage your n900 to boot? Does it also boot
> > > from 0xffff?
> > > 
> > > I believe I'm hitting dtb size limit (again), and 3.19-rc3 does not boot
> > > unless I somehow make dtb smaller... like the patch below.
> > > 
> > > ---
> > > 
> > > make dtb smaller so that it boots.
> > 
> > I am using chained boot (NOLO->u-boot->kernel (zImage +dtb
> > concatenated) on a real n900
> > 
> > I have the same issue as well. using omap2plus_defconfig.
> > I was able to bisect next tags as follows: next-20141128 worked,
> > next-20141201 stopped booting and the change was new dts addition,
> > removing the dts addition helped next-20141201 boot as well.
> > 
> > Current state:
> > 
> > https://github.com/nmenon/kernel-test-logs/blob/next-20150107/omap2plus_defconfig/n900.txt#L447
> > 
> > https://github.com/nmenon/kernel-test-logs/blob/v3.19-rc3/omap2plus_defconfig/n900.txt#L448
> > 
> > 
> > I had complained originally here:
> > http://marc.info/?t=141946203100001&r=1&w=2 Apologies on not following
> > up on the thread, got distracted.
> 
> Hmm strange a plain omap2plus_defconfig kernel boots just fine here.
> Also boots fine with appended DTB and 0xFFFF using something like:

I tried omap2plus_defconfig + my smaller DTB, and I stare at blank
screen where kernel messages should be (no serial cable here, sorry).

I reverted my "smaller DTB" changes, and now I'm staring at nokia
logo, followed by backlight off.

Strange.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
