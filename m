From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Wed, 23 Mar 2016 15:37:11 +0100
Message-ID: <20160323143711.GA5459@amd>
References: <20160126172527.GY3500@atomide.com>
 <20160130200244.GA30429@amd>
 <20160130201452.GC30429@amd>
 <20160130221509.GA28644@amd>
 <20160201181316.GM19432@atomide.com>
 <20160201211736.GA11283@amd>
 <20160201221111.GP19432@atomide.com>
 <20160207212316.GA6147@amd>
 <20160209172403.GK19432@atomide.com>
 <20160211010818.GQ19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160211010818.GQ19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On Wed 2016-02-10 17:08:18, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [160209 09:26]:
> > * Pavel Machek <pavel@ucw.cz> [160207 13:24]:
> > 
> > > ffdffebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200042
> > > 0000000d 48004a28 (fa004a28) cm_idlest3_core
> > 
> > Bit 21 in cm_idlest1_core is for MCSPI4 so WLAN. Does that go
> > down if do sleep 5; cat /sys/kernel/debug/pm_debug/count ?
> > 
> > If not, the're PM runtime missing or broken somewhere.
> 
> Just tested n900 wlan here and it's working for me with Emil's
> patch from the "" thread and the PM runtime regression fix for
> hsmmc I posted earlier today. Looks like n900 is hitting off
> mode just fine with wlan0 configured.

Emil's patch, would that be:

commit fb724ed5c6175a2407b256d506c9e703c6bb62d4
Author: Emil Goode <emil.fsw@goode.io>
Date:   Wed Feb 10 02:22:16 2016 +0100

    wlcore: Fix regression in wlcore_set_partition()

    The commit 3719c17e1816 ("wlcore/wl18xx: fw logger over sdio")
    introduced a
        regression causing the wlcore to time out and go into
    recovery. Reverting the
        changes regarding write of the last partition size brings the
    module back to
        it's functional state.

    Fixes: 3719c17e1816 ("wlcore/wl18xx: fw logger over sdio")

?

Hsmmc regression, that's

Date: Wed, 10 Feb 2016 15:02:44 -0800
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Subject: [PATCH 1/7] mmc: omap_hsmmc: Fix PM regression with deferred probe for pm_runtime_reinit

? Aha, but the patch this regression fixes does not seem to be in 4.4,
so I should be fine unless I go to 4.5.

> It does not wake up to pings from outside from off mode though
> until the system wakes up.

Ok, I guess I'm trying to get it to sleep, first, then we can talk
about wakeup ;-).

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
