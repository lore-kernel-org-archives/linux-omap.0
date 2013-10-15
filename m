From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 3/6] omap hwmod changes for v3.13 merge window
Date: Mon, 14 Oct 2013 21:11:30 -0700
Message-ID: <20131015041130.GB25997@quad.lixom.net>
References: <5258a9a6.4a17e00a.5fb3.ffff9bf3SMTPIN_ADDED_MISSING@mx.google.com>
 <87a9ib4gmb.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:52199 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab3JOELz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Oct 2013 00:11:55 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so8289817pdj.4
        for <linux-omap@vger.kernel.org>; Mon, 14 Oct 2013 21:11:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87a9ib4gmb.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Oct 14, 2013 at 03:44:44PM -0700, Kevin Hilman wrote:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:
> >
> >   Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/hwmod-signed
> >
> > for you to fetch changes up to 254f57a92987b6cde6004f58d6b847813dfb9e0e:
> >
> >   ARM: OMAP5: hwmod: add missing ocp2scp hwmod data (2013-10-11 15:37:05 -0700)
> >
> > ----------------------------------------------------------------
> > omap hwmod related changes via Paul Walmsley <paul@pwsan.com>:
> >
> > Some OMAP hwmod changes for 3.13.  Significant changes here include:
> >
> > - support for moving some of the hwmod flags to DT data
> >
> > - support for the SSI, hardware spinlock, USB host/TLL, and RNG IP
> >   blocks for various OMAPs
> >
> > - a fix that again decouples hwmod data changes from unrelated DT data
> >   patchsets
> >
> > Basic test logs are available at:
> >
> > http://www.pwsan.com/omap/testlogs/prcm_fixes_v3.13/20131009094936/
> >
> > ----------------------------------------------------------------
> 
> Pulled into next/soc,
> 
> Thanks,
> 
> Kevin

Hm, looks like my BBB hit this on v3.12-rc4-493-g1a9df23, which is pushed to
to-build but not for-next yet. I'm guessing this might be what Kevin pinged me
about on IRC today but I was out and unavailable most of the day.

[    0.169527] ------------[ cut here ]------------
[    0.169585] WARNING: CPU: 0 PID: 1 at ../../arch/arm/mach-omap2/omap_hwmod.c:2438 _init+0x338/0x37c()
[    0.169602] omap_hwmod: spinlock: doesn't have mpu register target base
[    0.169616] Modules linked in:
[    0.169647] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12.0-rc4-00493-g1a9df23 #1
[    0.169701] [<c001ba40>] (unwind_backtrace+0x0/0xec) from [<c0017b80>] (show_stack+0x10/0x14)
[    0.169735] [<c0017b80>] (show_stack+0x10/0x14) from [<c051ad90>] (dump_stack+0x7c/0x94)
[    0.169768] [<c051ad90>] (dump_stack+0x7c/0x94) from [<c0045be0>] (warn_slowpath_common+0x6c/0x90)
[    0.169796] [<c0045be0>] (warn_slowpath_common+0x6c/0x90) from [<c0045c34>] (warn_slowpath_fmt+0x30/0x40)
[    0.169825] [<c0045c34>] (warn_slowpath_fmt+0x30/0x40) from [<c076e868>] (_init+0x338/0x37c)
[    0.169855] [<c076e868>] (_init+0x338/0x37c) from [<c076ed80>] (__omap_hwmod_setup_all+0x40/0x8c)
[    0.169886] [<c076ed80>] (__omap_hwmod_setup_all+0x40/0x8c) from [<c0008848>] (do_one_initcall+0xe8/0x14c)
[    0.169924] [<c0008848>] (do_one_initcall+0xe8/0x14c) from [<c0762b84>] (kernel_init_freeable+0x104/0x1c4)
[    0.169963] [<c0762b84>] (kernel_init_freeable+0x104/0x1c4) from [<c0514c90>] (kernel_init+0x8/0x150)
[    0.170002] [<c0514c90>] (kernel_init+0x8/0x150) from [<c0013bc8>] (ret_from_fork+0x14/0x2c)
[    0.170221] ---[ end trace 1b75b31a2719ed1c ]---


-Olof
