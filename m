From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 2/2] RX-51: ARM errata 430973 workaround
Date: Tue, 24 Sep 2013 02:15:45 +0200
Message-ID: <20130924001545.GA31569@amd.pavel.ucw.cz>
References: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
 <1373461145-9812-3-git-send-email-pali.rohar@gmail.com>
 <20130917232417.GK9994@atomide.com>
 <201309181033.24965@pali>
 <20130918171816.GT9994@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130918171816.GT9994@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

Hi!

> > Tony, if you did not have time for review this patch months ago 
> > or you found it only today - no problem, I understand it. But 
> > what I need to know is what will happen with board-rx51-* files 
> > (and when?) You can see that DT does not have definitions of all 
> > n900 hw parts (plus it is not in last 3.11 kernel!) which means 
> > that DT is not usable for me and other n900 people. This also 
> > means that I cannot rewrite my patches for DT and test if they 
> > working.
> 
> I usually stop looking at new code around -rc4 and concentrate
> on fixes until -rc1 or so. So there can be easily one month
> delays on reviewing stuff depending on where we are with the
> current merge window or -rc cycle, sorry if that's annoying.
> 
> The .dts files will be separate from the kernel soonish, so
> that's not be a show stopper. Just like all the board specific
> .config files are separate from the kernel already. Too bad our
> .dts changes did not get merged for v3.12 because of conflicts
> with other branches, but hey, they should be independent from the
> kernel anyways.

Well... I'd say it is still time to merge them. "New hardware support"
is ok after -rc1.

> The board files will be going away as soon as things are working
> with DT. We've been pretty much only applying fixes to them for
> quite some time now. For the timeline, the earliest we'll be able
> to remove the board-*.c files and platform data is for v3.13

And it would be good to merge n900 dts support for 3.12. Adding 
device tree at the same release as removing board support files in
same release leaves zero room for testing, and practically guarantees
regressions.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
