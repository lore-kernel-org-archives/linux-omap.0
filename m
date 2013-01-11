From: Nishanth Menon <nm@ti.com>
Subject: 3.8-rc3: DMA?: WARNING: at mm/percpu-vm.c:318
 pcpu_alloc+0x93c/0xa20()
Date: Fri, 11 Jan 2013 16:01:52 -0600
Message-ID: <20130111220152.GA31180@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57431 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754804Ab3AKWBw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Jan 2013 17:01:52 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id r0BM1qef012863
	for <linux-omap@vger.kernel.org>; Fri, 11 Jan 2013 16:01:52 -0600
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id r0BM1qXc025318
	for <linux-omap@vger.kernel.org>; Fri, 11 Jan 2013 16:01:52 -0600
Received: from localhost (kahuna.am.dhcp.ti.com [128.247.75.12])	by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id r0BM1qtD010064	for
 <linux-omap@vger.kernel.org>; Fri, 11 Jan 2013 16:01:52 -0600
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
Not sure if anyone has seen it elsewhere,
build with omap2plus_defconfig, on PandaBoard ES (4460):
http://pastebin.com/vFJ35B7H
[    0.334259] OMAP DMA hardware revision 0.0
[    0.337127]  arm-pmu: alias fck already exists
[    0.374176] bio: create slab <bio-0> at 0
[    0.410095] ------------[ cut here ]------------
[    0.410125] WARNING: at mm/percpu-vm.c:318 pcpu_alloc+0x93c/0xa20()
[    0.410125] Modules linked in:
[    0.410156] [<c001acc4>] (unwind_backtrace+0x0/0xf0) from [<c0041388>] (warn_slowpath_common+0x4c/0x64)
[    0.410186] [<c0041388>] (warn_slowpath_common+0x4c/0x64) from [<c00413bc>] (warn_slowpath_null+0x1c/0x24)
[    0.410217] [<c00413bc>] (warn_slowpath_null+0x1c/0x24) from [<c00e75f0>] (pcpu_alloc+0x93c/0xa20)
[    0.410247] [<c00e75f0>] (pcpu_alloc+0x93c/0xa20) from [<c02e3730>] (dma_async_device_register+0x22c/0x4d0)
[    0.410247] [<c02e3730>] (dma_async_device_register+0x22c/0x4d0) from [<c02e4480>] (omap_dma_probe+0x118/0x1a8)
[    0.410278] [<c02e4480>] (omap_dma_probe+0x118/0x1a8) from [<c031886c>] (platform_drv_probe+0x18/0x1c)
[    0.410308] [<c031886c>] (platform_drv_probe+0x18/0x1c) from [<c031762c>] (driver_probe_device+0x78/0x210)
[    0.410339] [<c031762c>] (driver_probe_device+0x78/0x210) from [<c0315eb0>] (bus_for_each_drv+0x5c/0x88)
[    0.410339] [<c0315eb0>] (bus_for_each_drv+0x5c/0x88) from [<c0317580>] (device_attach+0x78/0x90)
[    0.410369] [<c0317580>] (device_attach+0x78/0x90) from [<c0316bd4>] (bus_probe_device+0x88/0xac)
[    0.410400] [<c0316bd4>] (bus_probe_device+0x88/0xac) from [<c0315478>] (device_add+0x4b0/0x584)
[    0.410400] [<c0315478>] (device_add+0x4b0/0x584) from [<c0318cbc>] (platform_device_add+0x114/0x204)
[    0.410430] [<c0318cbc>] (platform_device_add+0x114/0x204) from [<c0319248>] (platform_device_register_full+0xc0/0xe4)
[    0.410430] [<c0319248>] (platform_device_register_full+0xc0/0xe4) from [<c02e4d5c>] (omap_dma_init+0x24/0x50)
[    0.410461] [<c02e4d5c>] (omap_dma_init+0x24/0x50) from [<c00086a4>] (do_one_initcall+0x34/0x178)
[    0.410491] [<c00086a4>] (do_one_initcall+0x34/0x178) from [<c04c5c4c>] (kernel_init+0x100/0x2a0)
[    0.410522] [<c04c5c4c>] (kernel_init+0x100/0x2a0) from [<c00131f0>] (ret_from_fork+0x14/0x24)
[    0.410736] ---[ end trace 7bf9bef6496b19f5 ]---
[    0.427185] omap-dma-engine omap-dma-engine: OMAP DMA engine driver

-- 
Regards,
Nishanth Menon
