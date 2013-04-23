From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap dss board clean-up for v3.10 merge window
Date: Tue, 23 Apr 2013 10:14:38 -0700
Message-ID: <20130423171438.GC10155@atomide.com>
References: <20130418033936.GC10155@atomide.com>
 <20130419184518.GA30836@quad.lixom.net>
 <5174F593.20705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35113 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508Ab3DWROq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Apr 2013 13:14:46 -0400
Content-Disposition: inline
In-Reply-To: <5174F593.20705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130422 01:37]:
> On 2013-04-19 21:45, Olof Johansson wrote:
> > Hi,
> > 
> > On Wed, Apr 17, 2013 at 08:39:37PM -0700, Tony Lindgren wrote:
> >> The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:
> >>
> >>   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/dss-signed
> > 
> > 
> > Merged, but not happy about it.
> 
> Thanks.
> 
> > As mentioned on IRC, I was going to let this one be until 3.11, but it sounds
> > like it will cause regressions in DSS if we don't merge it.
> 
> Yes, that's true. The branch has been unchanged and in linux-next, so
> merging it late shouldn't cause any bigger issues. But I understand it's
> quite late, and I should've pushed the branch forward much earlier.
> Sorry about that.
> 
> > This is an indication that the work wasn't done right on the DSS rework.
> > Ideally the old configurations through platform_data should have been left in
> > for a release to give the boards a window to convert over without regressing
> > functionality. Tomi, please don't do it this way in the future since it's
> > painful for everybody to deal with.
> 
> I've been trying to keep everything working even if parts of the whole
> series go through different trees. I've been very strict on that things
> must compile, but keeping display working if only half of the series is
> merged is rather difficult at times.
> 
> For this series, I think it could've been done, but it would have
> required adding hacks, or some kind of "bool new_pdata" fields so that
> the driver understand what to do. And duplicate code to manage the
> different platform data versions.
> 
> In the near future we'll get rid of the current custom omapdss panel
> device, and use the standard platform/i2c/etc devices for the panel. The
> only way to do that while keeping everything running is to clone the
> panel drivers, one handling the old one and the other handling the new one.
> 
> All this makes me spend lots of time doing extra work, that in no way
> improves the driver. Its only for the purpose of getting arch changes
> through one tree, and driver changes through the other. And this makes
> the patches much more difficult to follow, as the related changes are in
> separate series, and there may be extra crud just to handle this separation.
> 
> So while I think it is a good habit to push the arch changes and driver
> changes separately, my question is, should that rule be followed to the
> extreme? Can I just keep all the changes in one branch if separating the
> arch and driver changes would end up with cloning files or lots of extra
> code?

Shread branches are just fine. In most cases it's possible to add new
pdata and then remove the old pdata later on with follow-up patches.
 
> Of course, I don't know what DRM maintainer thinks of merging arch
> changes through his tree, so that's also open.

No let's not go there, Linus T already complained about the conflicts
between drivers/net and arch/arm/*omap*/ code few merge windows ago.
We need to remove the driver dependencies to the arch/arm code, otherwise
the merging requires way too much work from multiple maintainers. That
does not scale well and often leads into merge errors that could have
been avoided in the first place.

Of course the real solution here is to get things moved over to DT
based booting and then we don't have any of these dependencies as the
.dts changes can get merged separately from the driver changes.

Regards,

Tony
