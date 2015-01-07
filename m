From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Wed, 7 Jan 2015 21:00:12 +0100
Message-ID: <20150107200012.GA6548@amd>
References: <20150105230228.GO4081@atomide.com>
 <20150106080025.GA6752@amd>
 <20150106165903.GF4025@atomide.com>
 <20150107095703.GA15925@amd>
 <54AD5447.2070601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45403 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbbAGUAP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2015 15:00:15 -0500
Content-Disposition: inline
In-Reply-To: <54AD5447.2070601@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>

Hi!

> >> Sure, updated patch below. Can somebody please test boot it on
> >> a production n900 too to make sure it no longer causes issues?
> > 
> > Actually... how do you manage your n900 to boot? Does it also boot
> > from 0xffff?
> > 
> > I believe I'm hitting dtb size limit (again), and 3.19-rc3 does not boot
> > unless I somehow make dtb smaller... like the patch below.
> > 
> > ---
> > 
> > make dtb smaller so that it boots.
> 
> I am using chained boot (NOLO->u-boot->kernel (zImage +dtb
> concatenated) on a real n900
> 
> I have the same issue as well. using omap2plus_defconfig.
> I was able to bisect next tags as follows: next-20141128 worked,
> next-20141201 stopped booting and the change was new dts addition,
> removing the dts addition helped next-20141201 boot as well.
> 
> Current state:
> 
> https://github.com/nmenon/kernel-test-logs/blob/next-20150107/omap2plus_defconfig/n900.txt#L447
> 
> https://github.com/nmenon/kernel-test-logs/blob/v3.19-rc3/omap2plus_defconfig/n900.txt#L448
> 
> 
> I had complained originally here:
> http://marc.info/?t=141946203100001&r=1&w=2 Apologies on not following
> up on the thread, got distracted.

Actually, I noticed this some time ago, and there's some additional
discussion at

Subject: Re: dtb size limit? was Re: Tiny dts change breaks boot on n900
Message-ID: <20141110150915.GH31454@atomide.com>

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
