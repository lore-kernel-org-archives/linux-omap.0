From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] OMAP2/3: update default defconfig, towards smaller
	kernel
Date: Mon, 1 Feb 2010 14:37:51 -0600
Message-ID: <20100201203751.GA6194@lixom.net>
References: <1264811216-25989-1-git-send-email-khilman@deeprootsystems.com> <20100201194926.GA5819@lixom.net> <87k4uwg12p.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:55100 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754821Ab0BAUe6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Feb 2010 15:34:58 -0500
Content-Disposition: inline
In-Reply-To: <87k4uwg12p.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Mon, Feb 01, 2010 at 12:20:30PM -0800, Kevin Hilman wrote:
> Olof Johansson <olof@lixom.net> writes:
> 
> > On Fri, Jan 29, 2010 at 04:26:56PM -0800, Kevin Hilman wrote:
> >> Update omap3_defconfig to work towards a minimal kernel by building
> >> most things as modules.  Some drivers that cannot currently be built
> >> as modules and need to be fixed:
> >
> > Why? I introduced the omap3_defconfig with the intent of making it as
> > inclusive as possible, to catch build errors and build a common binary
> > for many platforms. 
> 
> That's my goal too, as I regularly test the same kernel (in my case
> PM-enabled) on multiple OMAP3 boards.  The only additional goal I have
> is to the kernel as small as possible and build most things as
> modules.

The size of the kernel doesn't bother me as much, I would much rather have
a single image of a few hundred KB more, than having the hassle of getting
the modules over onto each target board for each build.

> I don't change what gets included in the build, I only moved some
> things from being built in to be built as modules.  Doing 'make
> [uz]Image modules' will still catch all the build errors and build a
> common binary.

With the below exception of root filesystems that you mentioned, I think
I can agree to some extent :). Your original email read to me as if you
wanted to require ramdisks to even mount root filesystems, which I think
is taking it too far.

[See rest of reply]

> > It's the only OMAP defconfig that Stephen Rothwell
> > builds as part of a linux-next cycle, and it will as such need to catch
> > build errors when others break ARM/OMAP.
> 
> If linux-next is not also building modules for OMAP, we need to
> request that it does.  It does so for other platforms.

Ah, maybe it doesn't if the regular kernel target fails, and I just
looked at some of the last... 9 failed builds.  Which sort of makes me
wonder if anyone cares about it in the first place. I don't poll the
kisskb status page myself; I'll follow up with Stephen and see if he
can add linux-omap to the cc list on build notifications (if he has one).

> >> - MMC: platform code uses MMC core regulator functions directly
> >> - ASoC: drivers call omap_ctrl_[read|write] directly
> >> 
> >> In addition some additional changes:
> >> 
> >> - use new SLUB allocator instead of SLAB (increased debugability)
> >> - compile with PREEMPT enabled by default
> >> - disable OABI_COMPAT.  We should not pretend to support this IMHO
> >> - disable CPUfreq: not yet supported in mainline
> >> - disable PM_DEBUG_VERBOSE
> >> - enable fb/DSS2 as modules
> >> - disable Kprobes
> >> 
> >> zImage size comparison
> >> before: 3160272
> >> after:  2610108
> >> 
> >> Some ideas for reducing this further:
> >> - fix MMC and ASoC, then build those as modules
> >> - disable all the kernel debug features
> >> - convert MTD and all flash fs to modules
> >> 
> >> Then, we should have platform specific initramfs configs so rootfs
> >> from flash, MMC, etc. could be done using modules in initramfs.
> >
> > I'm all for allowing an "allmodconfig" kernel to be booted, and it's good
> > to clear up some of these dependencies. But I'd prefer if it wasn't done
> > under omap3_defconfig. :)
> 
> Why not?
>
> Building a monolithic kernel for multiple boards leads to lots of
> wasted memory and slower boot time.

Anyone who (highly) values memory consumption and boot times should be
doing their own custom defconfig in the first place, or running with
the board-specific one.

> At a minimum, I'd at least like to get to "build everything except
> possible root filesystems as modules" kernel.

I would prefer "build the majority of the drivers needed on most
supported platforms statically", and the keep the one-off or oddball
drivers as modules.


-Olof

