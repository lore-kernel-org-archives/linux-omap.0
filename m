From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] Flip on multiplatform support for omap2plus for
 v3.9
Date: Thu, 20 Dec 2012 07:55:18 -0800
Message-ID: <20121220155518.GX4989@atomide.com>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41640 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751119Ab2LTPzV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Dec 2012 10:55:21 -0500
Content-Disposition: inline
In-Reply-To: <20121219192354.22098.33408.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>

* Tony Lindgren <tony@atomide.com> [121219 11:28]:
> Hi all,
> 
> These patches enable multiplatform support for omap2plus.
> 
> To build and boot it against the current mainline kernel
> you need the following:
> 
> [PATCH 1/2] ARM: l2x0: Only set .set_debug on PL310 r3p0 and earlier
> [PATCH 2/2] ARM: disable errata work-arounds which access secure registers
> [GIT PULL 1/2] omap fixes for v3.8 merge window
> [GIT PULL 2/2] omap cleanup for v3.8 merge window
> [GIT PULL] two trivial omap build error fixes for v3.8 merge window
> cpts: Fix build error caused by include of plat/clock.h

Few notes on booting this as at least Lokesh already hit the mkimage
issue like I did earlier.

To boot this you also need to run mkimage manually on the zImage:

$ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 \
	-n "Linux" -d zImage-omap2plus uImage-omap2plus

And to boot the vexpress on qemu something like this should do:

$ qemu-system-arm -machine vexpress-a9 -m 1024 -net nic -net user -serial stdio \
	-append "console=ttyAMA0,115200n8 rw root=/dev/mmcblk0p2 rootwait" \
	-kernel zImage-omap2plus -initrd initrd.img -sd rootfs.img

I had to build the Linaro qemu to get it to boot, for some reason the
version of qemu in debian unstable did not boot vexpress for me.

Regards,

Tony
