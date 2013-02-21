From: Paolo Pisati <p.pisati@gmail.com>
Subject: omap4: 3.8: IPV6 + PREEMPT_VOLUNTARY + !DEBUG_[SPINLOCK|MUTEXES] =
 BUG()
Date: Thu, 21 Feb 2013 10:48:19 +0100
Message-ID: <20130221094819.GA4580@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:35229 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379Ab3BUJsX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 04:48:23 -0500
Received: by mail-ee0-f54.google.com with SMTP id c41so4753459eek.13
        for <linux-omap@vger.kernel.org>; Thu, 21 Feb 2013 01:48:22 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: linux-omap <linux-omap@vger.kernel.org>

I keep getting this BUG() when there's IPV6 traffic in in my lan on a panda board
with these configs:

-start from a vanilla omap config
(make ARCH=arm omap2plus_defconfig)

-enable IPV6 and PREEMPT_VOLUNTARY

-turn off

CONFIG_DEBUG_SPINLOCK
CONFIG_DEBUG_MUTEXES
CONFIG_DEBUG_LOCK_ALLOC
CONFIG_PROVE_LOCKING
CONFIG_LOCKDEP
CONFIG_TRACE_IRQFLAGS

(or apply this patch fragment:
http://people.canonical.com/~ppisati/panda_ipv6/config_lock_off.patch)

-enable some useful options (like EHCI for my usb disk, etcetc)

-finish off the build

make ARCH=arm olddefconfig
make ARCH=arm zImage

-boot the board, wait for some ipv6 traffic:

IP6 fe80::213:20ff:fefb:6364.mdns > ff02::fb.mdns: 0 PTR (QM)? _mumble._tcp.local. (36)

and enjoy:

[Thu Feb 21 10:23:07 2013] BUG: scheduling while atomic: swapper/0/0/0x40000100
[Thu Feb 21 10:23:07 2013] Modules linked in:
[Thu Feb 21 10:23:07 2013] [<c001b1c4>] (unwind_backtrace+0x0/0xf0) from [<c0503c5c>] (__schedule_bug+0x48/0x5c)
[Thu Feb 21 10:23:07 2013] [<c0503c5c>] (__schedule_bug+0x48/0x5c) from [<c0508608>] (__schedule+0x700/0x740)
[Thu Feb 21 10:23:07 2013] [<c0508608>] (__schedule+0x700/0x740) from [<c007007c>] (__cond_resched+0x24/0x34)
[Thu Feb 21 10:23:07 2013] [<c007007c>] (__cond_resched+0x24/0x34) from [<c05086dc>] (_cond_resched+0x3c/0x44)
[Thu Feb 21 10:23:07 2013] [<c05086dc>] (_cond_resched+0x3c/0x44) from [<c0021f6c>] (do_alignment+0x178/0x78c)
[Thu Feb 21 10:23:07 2013] [<c0021f6c>] (do_alignment+0x178/0x78c) from [<c00083e0>] (do_DataAbort+0x34/0x98)
[Thu Feb 21 10:23:07 2013] [<c00083e0>] (do_DataAbort+0x34/0x98) from [<c0509a60>] (__dabt_svc+0x40/0x60)
[Thu Feb 21 10:23:07 2013] Exception stack(0xc0763d70 to 0xc0763db8)
[Thu Feb 21 10:23:07 2013] 3d60:                                     e97e805e e97e806e 2c000000 11000000
[Thu Feb 21 10:23:07 2013] 3d80: ea86bb00 0000002c 00000011 e97e807e c076d2a8 e97e805e e97e806e 0000002c
[Thu Feb 21 10:23:07 2013] 3da0: 3d000000 c0763dbc c04b98fc c02a8490 00000113 ffffffff
[Thu Feb 21 10:23:07 2013] [<c0509a60>] (__dabt_svc+0x40/0x60) from [<c02a8490>] (__csum_ipv6_magic+0x8/0xc8)

here you can find a .config for a 3.8 kernel showing this problem:

http://people.canonical.com/~ppisati/panda_ipv6/config

and a precompiled zImage:

http://people.canonical.com/~ppisati/panda_ipv6/zImage

any idea how can i debug this?
-- 
bye,
p.
