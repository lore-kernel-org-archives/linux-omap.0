From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: v4.17-rc1: regressions on N900, N950
Date: Thu, 24 May 2018 01:02:55 +0300
Message-ID: <20180523220254.GD2299@darkstar.musicnaut.iki.fi>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
 <20180521213952.GA11596@amd>
 <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
 <20180522205824.GA24927@amd>
 <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Dave Airlie <airlied@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Thorsten Leemhuis <regressions@leemhuis.info>, Tony Lindgren <tony@atomide.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Wed, May 23, 2018 at 12:56:38AM +0300, Aaro Koskinen wrote:
> On Tue, May 22, 2018 at 10:58:26PM +0200, Pavel Machek wrote:
> > On Tue 2018-05-22 22:41:39, Aaro Koskinen wrote:
> > > My device worked with v4.17-rc1 (haven't found time to test newer kernels),
> > > but if you say the probe order is random then we must find some proper way
> > > to express the dependency.
> > 
> > I started bisect, but.. that will probably not be useful.
> > 
> > If your device works ok in v4.17-rc1, it probably works in newer -rcs,
> > too.
> 
> Actually, my statement may be bogus... Now I tried again with -rc1
> (and also -rc6) and it fails... But v4.16 works.

I tried to investigate this today again, and I think the issue is omapdrm.

At commit 78230c46ec0a91dd4256c9e54934b3c7095a7ee3 ("Merge tag 'omapdrm-4.17'
of git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux into drm-next")
the boot hangs on omapdrm init:

[    3.725891] input: TSC2005 touchscreen as /devices/platform/68000000.ocp/48098000.spi/spi_master/spi0/spi0.0/input/input3
[    3.746368] omap_hsmmc 4809c000.mmc: Got CD GPIO
[    3.826721] omapdrm omapdrm.0: DMM not available, disable DMM support
[    3.834106] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.841064] [drm] No driver support for vblank timestamp query.
(THE DEVICE HANGS HERE)

Then I reverted the merge with "git revert
78230c46ec0a91dd4256c9e54934b3c7095a7ee3 -m 1":

Now the device boots fine with working display.

Then I tried bisection: b65bd40311565a58b12f400e95e8aa0a1e3a8878 good
and 78230c46ec0a91dd4256c9e54934b3c7095a7ee3 bad.

But turns out that omapdrm tree is unbisectable, as I get build failures such
as (commit 28d79f3e56b2c1d5ff0fd363da3229be0962cc85):

/home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/dss.c:1473:52: error: undefined identifier 'dss_debug_dump_clocks'
/home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/dss.c:1472:51: warning: callwith no type!
In file included from /home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/core.c:28:0:
/home/aaro/git/devel/linux/drivers/gpu/drm/omapdrm/dss/dss.h:395:25: error: conflicting types for 'port'
     struct device_node *port,
                         ^~~~

etc. WTF?

So I gave up for today.

A.
