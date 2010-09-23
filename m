From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: SYS_OFF_MODE signaling and CORE domain Transition to OFF Mode
Date: Thu, 23 Sep 2010 11:05:39 -0700
Message-ID: <87sk10z66k.fsf@deeprootsystems.com>
References: <AANLkTinmYY-tVqD77SMeE-YVZWuY-=yscaBNDSOYM=Ub@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61347 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab0IWSFm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 14:05:42 -0400
Received: by pwj6 with SMTP id 6so357346pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Sep 2010 11:05:42 -0700 (PDT)
In-Reply-To: <AANLkTinmYY-tVqD77SMeE-YVZWuY-=yscaBNDSOYM=Ub@mail.gmail.com>
	(Laine Walker-Avina's message of "Wed, 22 Sep 2010 15:18:30 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laine Walker-Avina <lwalkera@pasco.com>
Cc: linux-omap@vger.kernel.org

Laine Walker-Avina <lwalkera@pasco.com> writes:

> I'm having some troubles putting my OMAP3503(the one without the DSP
> or SGX modules) board to sleep. I'm using the current master on the
> l-o git repository.

Looks like you're wanting to use off-mode.  There are many drivers that
do not yet support off mode, as they need to do context save/restore in 
their suspend/resume paths in order to support off mode.

In particular, MMC in l-o master does not yet have this support, so you
should not expect MMC to work after an off mode transition.

This is why off-mode is disabled by default, it has to be manually
enabled by: echo 1 > /debug/pm_debug/enable_off_mode.

Do things work as expected if you leave off-mode disabled?

> This is the output from dmesg and the count file after suspending
> twice. The first time it wakes immediately after going down, and the
> second time stays asleep but says that the core domain didn't enter
> OFF mode. 

This is not easy to debug with the current kernel dump.

The way I suggest debugging this is by first getting to a minimal kernel
that can suspend/resume as you expect.  Then you add in the drivers to
see which one is causing the problem, or keeping the system away.

Clearly the MMC driver has some problems in it's suspend/resume hooks
with unbalanced regulator enable/disables, so for starters, I'd suggest
disabling MMC.  I'd also suggest disabling musb, but basically the best
way is to disable everything except a minimal kernel, and then work back
up to the config you want.

You might try using my PM branch (link below) which comes with a minimal
kernel config for this purpose: omap3_pm_defconfig.

> In either case, the SYS_OFF_MODE signal never asserts. I added some
> debug code into map_sram_idle() to capture CM_CORE_IDLEST1 and 3 right
> before it jumps to the final sleep code in SRAM.

For looking at the idlest regs, you might want to try the patch from my
pm-debug branch (included in my pm branch) which takes a snapshot of all
the PM registers just before SRAM idle and right after resume.  You can
then see the registers using debugfs.  This is documented on the OMAP PM
wiki:

      http://elinux.org/OMAP_Power_Management

Hope that helps a little,

Kevin
