From: Paul Walmsley <paul@pwsan.com>
Subject: Re: BUG: spinlock bad magic on CPU#0 on BeagleBone
Date: Wed, 19 Dec 2012 16:53:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212191650430.16873@utopia.booyaka.com>
References: <B5906170F1614E41A8A28DE3B8D121433EC9A69C@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46194 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab2LSQxW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 11:53:22 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC9A69C@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 19 Dec 2012, Bedia, Vaibhav wrote:

> Current mainline on Beaglebone using the omap2plus_defconfig + 3 build fixes
> is triggering a BUG()

...

> [    0.109688] Security Framework initialized
> [    0.109889] Mount-cache hash table entries: 512
> [    0.112674] BUG: spinlock bad magic on CPU#0, swapper/0/0
> [    0.112724]  lock: atomic64_lock+0x240/0x400, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> [    0.112782] [<c001af64>] (unwind_backtrace+0x0/0xf0) from [<c02c2010>] (do_raw_spin_lock+0x158/0x198)
> [    0.112813] [<c02c2010>] (do_raw_spin_lock+0x158/0x198) from [<c04d89ec>] (_raw_spin_lock_irqsave+0x4c/0x58)
> [    0.112844] [<c04d89ec>] (_raw_spin_lock_irqsave+0x4c/0x58) from [<c02cabf0>] (atomic64_add_return+0x30/0x5c)
> [    0.112886] [<c02cabf0>] (atomic64_add_return+0x30/0x5c) from [<c0124564>] (alloc_mnt_ns.clone.14+0x44/0xac)
> [    0.112914] [<c0124564>] (alloc_mnt_ns.clone.14+0x44/0xac) from [<c0124f4c>] (create_mnt_ns+0xc/0x54)
> [    0.112951] [<c0124f4c>] (create_mnt_ns+0xc/0x54) from [<c06f31a4>] (mnt_init+0x120/0x1d4)
> [    0.112978] [<c06f31a4>] (mnt_init+0x120/0x1d4) from [<c06f2d50>] (vfs_caches_init+0xe0/0x10c)
> [    0.113005] [<c06f2d50>] (vfs_caches_init+0xe0/0x10c) from [<c06d4798>] (start_kernel+0x29c/0x300)
> [    0.113029] [<c06d4798>] (start_kernel+0x29c/0x300) from [<80008078>] (0x80008078)
> [    0.118290] CPU: Testing write buffer coherency: ok
> [    0.118968] CPU0: thread -1, cpu 0, socket -1, mpidr 0
> [    0.119053] Setting up static identity map for 0x804de2c8 - 0x804de338
> [    0.120698] Brought up 1 CPUs

This is probably a memory corruption bug, there's probably some code 
executing early that's writing outside its own data and trashing some 
previously-allocated memory.


- Paul
