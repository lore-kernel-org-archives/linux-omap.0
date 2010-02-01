From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2/3: update default defconfig, towards smaller kernel
Date: Mon, 01 Feb 2010 12:20:30 -0800
Message-ID: <87k4uwg12p.fsf@deeprootsystems.com>
References: <1264811216-25989-1-git-send-email-khilman@deeprootsystems.com>
	<20100201194926.GA5819@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.211.173]:60285 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049Ab0BAUUd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 15:20:33 -0500
Received: by ywh3 with SMTP id 3so1970401ywh.22
        for <linux-omap@vger.kernel.org>; Mon, 01 Feb 2010 12:20:33 -0800 (PST)
In-Reply-To: <20100201194926.GA5819@lixom.net> (Olof Johansson's message of "Mon\, 1 Feb 2010 13\:49\:26 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org

Olof Johansson <olof@lixom.net> writes:

> On Fri, Jan 29, 2010 at 04:26:56PM -0800, Kevin Hilman wrote:
>> Update omap3_defconfig to work towards a minimal kernel by building
>> most things as modules.  Some drivers that cannot currently be built
>> as modules and need to be fixed:
>
> Why? I introduced the omap3_defconfig with the intent of making it as
> inclusive as possible, to catch build errors and build a common binary
> for many platforms. 

That's my goal too, as I regularly test the same kernel (in my case
PM-enabled) on multiple OMAP3 boards.  The only additional goal I have
is to the kernel as small as possible and build most things as
modules.

I don't change what gets included in the build, I only moved some
things from being built in to be built as modules.  Doing 'make
[uz]Image modules' will still catch all the build errors and build a
common binary.

> It's the only OMAP defconfig that Stephen Rothwell
> builds as part of a linux-next cycle, and it will as such need to catch
> build errors when others break ARM/OMAP.

If linux-next is not also building modules for OMAP, we need to
request that it does.  It does so for other platforms.

>
>> - MMC: platform code uses MMC core regulator functions directly
>> - ASoC: drivers call omap_ctrl_[read|write] directly
>> 
>> In addition some additional changes:
>> 
>> - use new SLUB allocator instead of SLAB (increased debugability)
>> - compile with PREEMPT enabled by default
>> - disable OABI_COMPAT.  We should not pretend to support this IMHO
>> - disable CPUfreq: not yet supported in mainline
>> - disable PM_DEBUG_VERBOSE
>> - enable fb/DSS2 as modules
>> - disable Kprobes
>> 
>> zImage size comparison
>> before: 3160272
>> after:  2610108
>> 
>> Some ideas for reducing this further:
>> - fix MMC and ASoC, then build those as modules
>> - disable all the kernel debug features
>> - convert MTD and all flash fs to modules
>> 
>> Then, we should have platform specific initramfs configs so rootfs
>> from flash, MMC, etc. could be done using modules in initramfs.
>
> I'm all for allowing an "allmodconfig" kernel to be booted, and it's good
> to clear up some of these dependencies. But I'd prefer if it wasn't done
> under omap3_defconfig. :)

Why not?

Building a monolithic kernel for multiple boards leads to lots of
wasted memory and slower boot time.

At a minimum, I'd at least like to get to "build everything except
possible root filesystems as modules" kernel.

Kevin
