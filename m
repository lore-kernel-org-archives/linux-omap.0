From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE Fix for image autoload
Date: Thu, 12 Mar 2009 02:52:14 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF51DBC9@dlee02.ent.ti.com>
References: <7A436F7769CA33409C6B44B358BFFF0CFF51DBBC@dlee02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02A8F2BF1D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49694 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbZCLHwX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 03:52:23 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2C7qHUL013705
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 02:52:22 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2C7qHrA029557
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 02:52:17 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

> -----Original Message-----
> From: Menon, Nishanth
> Sent: Thursday, March 12, 2009 9:39 AM
> To: Gupta, Ramesh; linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Guzman Lugo, Fernando
> Subject: RE: [PATCH 1/1] DSPBRIDGE Fix for image autoload
> 
> > -----Original Message-----
> > From: Gupta, Ramesh
> > Sent: Thursday, March 12, 2009 8:01 AM
> > To: Menon, Nishanth; linux-omap@vger.kernel.org
> > Cc: Kanigeri, Hari; Guzman Lugo, Fernando
> > Subject: RE: [PATCH 1/1] DSPBRIDGE Fix for image autoload
> >
> > I have tried this on linux-omap pm branch . This can be applied on top
> of
> > my DVFS
> > Patches earlier.
> >
> Your patch does not apply clean :(
> $ wget -O ramesh.auto.patch "http://marc.info/?l=linux-
> omap&m=123683598308417&q=raw"
> $ vim ramesh.auto.patch (edited to remove the linux-omap trailer)
> $ patch -p1<./ramesh.auto.patch --dry-run
> patching file drivers/dsp/bridge/rmgr/drv_interface.c
> Hunk #1 succeeded at 400 (offset -5 lines).
> Hunk #2 succeeded at 408 (offset -5 lines).
> Hunk #3 succeeded at 450 with fuzz 1 (offset -5 lines).
> Hunk #4 succeeded at 470 (offset -5 lines).
> Hunk #5 succeeded at 655 (offset -5 lines).
> 
> Could you rebase your patch against the following:
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-
> 2.6.git
> cd linux-omap-2.6.git
> git checkout -b pm --track origin/pm
> git fetch git://gitorious.org/lk/mainline.git tidspbridge-pm:tidspbridge-
> pm
> git checkout tidspbridge-pm
> git merge pm


And the patch does not work :(

# insmod  ./bridgedriver.ko phys_mempool_base=0x87000000  phys_mempool_size=0x600000 base_img=dsp/baseimage.dof
<4>------------[ cut here ]------------
------------[ cut here ]------------
<4>WARNING: at arch/arm/plat-omap/omap-pm-srf.c:241 omap_pm_cpu_set_freq+0x20/0x44()
WARNING: at arch/arm/plat-omap/omap-pm-srf.c:241 omap_pm_cpu_set_freq+0x20/0x44()
Modules linked in:Modules linked in: bridgedriver(+) bridgedriver(+) [last unloaded: bridgedriver] [last unloaded: bridgedriver]

[<c0031e20>] [<c0031e20>] (dump_stack+0x0/0x14) (dump_stack+0x0/0x14) from [<c00562c8>] from [<c00562c8>] (warn_on_slowpath+0x4c/0x68)
(warn_on_slowpath+0x4c/0x68)
[<c005627c>] [<c005627c>] (warn_on_slowpath+0x0/0x68) (warn_on_slowpath+0x0/0x68) from [<c0043c44>] from [<c0043c44>] (omap_pm_cpu_set_freq+0x20/0x44)
(omap_pm_cpu_set_freq+0x20/0x44)
 r6:00008000 r6:00008000 r5:80008010 r5:80008010 r4:c3dc5b08 r4:c3dc5b08

[<c0043c24>] [<c0043c24>] (omap_pm_cpu_set_freq+0x0/0x44) (omap_pm_cpu_set_freq+0x0/0x44) from [<bf046544>] from [<bf046544>] (PROC_Load+0x2c8/0x40c [bridgedriver])
(PROC_Load+0x2c8/0x40c [bridgedriver])
[<bf04627c>] [<bf04627c>] (PROC_Load+0x0/0x40c [bridgedriver]) (PROC_Load+0x0/0x40c [bridgedriver]) from [<bf046ac0>] from [<bf046ac0>] (PROC_AutoStart+0x174/0x1c4 [bridgedriver)
(PROC_AutoStart+0x174/0x1c4 [bridgedriver])
[<bf04694c>] [<bf04694c>] (PROC_AutoStart+0x0/0x1c4 [bridgedriver]) (PROC_AutoStart+0x0/0x1c4 [bridgedriver]) from [<bf03add0>] from [<bf03add0>] (WCD_InitComplete2+0x58/0x8c [b)
(WCD_InitComplete2+0x58/0x8c [bridgedriver])
 r7:00000000 r7:00000000 r6:c3dc5dd4 r6:c3dc5dd4 r5:00008000 r5:00008000 r4:c3981600 r4:c3981600

[<bf03ad78>] [<bf03ad78>] (WCD_InitComplete2+0x0/0x8c [bridgedriver]) (WCD_InitComplete2+0x0/0x8c [bridgedriver]) from [<bf0487e0>] from [<bf0487e0>] (DSP_Init+0xd8/0xf0 [bridge)
(DSP_Init+0xd8/0xf0 [bridgedriver])
 r5:c3dc5c99 r5:c3dc5c99 r4:00008000 r4:00008000

[<bf048708>] [<bf048708>] (DSP_Init+0x0/0xf0 [bridgedriver]) (DSP_Init+0x0/0xf0 [bridgedriver]) from [<bf05d33c>] from [<bf05d33c>] (bridge_init+0x33c/0x3ec [bridgedriver])
(bridge_init+0x33c/0x3ec [bridgedriver])
 r6:bf05a288 r6:bf05a288 r5:bf05ab88 r5:bf05ab88 r4:bf05ab88 r4:bf05ab88

[<bf05d000>] [<bf05d000>] (bridge_init+0x0/0x3ec [bridgedriver]) (bridge_init+0x0/0x3ec [bridgedriver]) from [<c002d2d4>] from [<c002d2d4>] (do_one_initcall+0x64/0x198)
(do_one_initcall+0x64/0x198)
 r8:c002df28 r8:c002df28 r7:00000000 r7:00000000 r6:4023a000 r6:4023a000 r5:bf05a520 r5:bf05a520 r4:c03aa340 r4:c03aa340

[<c002d270>] [<c002d270>] (do_one_initcall+0x0/0x198) (do_one_initcall+0x0/0x198) from [<c0078cd4>] from [<c0078cd4>] (sys_init_module+0x98/0x188)
(sys_init_module+0x98/0x188)
[<c0078c3c>] [<c0078c3c>] (sys_init_module+0x0/0x188) (sys_init_module+0x0/0x188) from [<c002dd80>] from [<c002dd80>] (ret_fast_syscall+0x0/0x2c)
(ret_fast_syscall+0x0/0x2c)
 r7:00000080 r7:00000080 r6:00000000 r6:00000000 r5:0000000b r5:0000000b r4:00000000 r4:00000000

<4>---[ end trace 7a555f9f02586741 ]---
---[ end trace 7a555f9f02586741 ]---
<4>------------[ cut here ]------------
------------[ cut here ]------------
<4>WARNING: at arch/arm/plat-omap/omap-pm-srf.c:241 omap_pm_cpu_set_freq+0x20/0x44()
WARNING: at arch/arm/plat-omap/omap-pm-srf.c:241 omap_pm_cpu_set_freq+0x20/0x44()
Modules linked in:Modules linked in: bridgedriver(+) bridgedriver(+) [last unloaded: bridgedriver] [last unloaded: bridgedriver]

[<c0031e20>] [<c0031e20>] (dump_stack+0x0/0x14) (dump_stack+0x0/0x14) from [<c00562c8>] from [<c00562c8>] (warn_on_slowpath+0x4c/0x68)
(warn_on_slowpath+0x4c/0x68)
[<c005627c>] [<c005627c>] (warn_on_slowpath+0x0/0x68) (warn_on_slowpath+0x0/0x68) from [<c0043c44>] from [<c0043c44>] (omap_pm_cpu_set_freq+0x20/0x44)
(omap_pm_cpu_set_freq+0x20/0x44)
 r6:00008000 r6:00008000 r5:80008010 r5:80008010 r4:00008000 r4:00008000

[<c0043c24>] [<c0043c24>] (omap_pm_cpu_set_freq+0x0/0x44) (omap_pm_cpu_set_freq+0x0/0x44) from [<bf046580>] from [<bf046580>] (PROC_Load+0x304/0x40c [bridgedriver])
(PROC_Load+0x304/0x40c [bridgedriver])
[<bf04627c>] [<bf04627c>] (PROC_Load+0x0/0x40c [bridgedriver]) (PROC_Load+0x0/0x40c [bridgedriver]) from [<bf046ac0>] from [<bf046ac0>] (PROC_AutoStart+0x174/0x1c4 [bridgedriver)
(PROC_AutoStart+0x174/0x1c4 [bridgedriver])
[<bf04694c>] [<bf04694c>] (PROC_AutoStart+0x0/0x1c4 [bridgedriver]) (PROC_AutoStart+0x0/0x1c4 [bridgedriver]) from [<bf03add0>] from [<bf03add0>] (WCD_InitComplete2+0x58/0x8c [b)
(WCD_InitComplete2+0x58/0x8c [bridgedriver])
 r7:00000000 r7:00000000 r6:c3dc5dd4 r6:c3dc5dd4 r5:00008000 r5:00008000 r4:c3981600 r4:c3981600

[<bf03ad78>] [<bf03ad78>] (WCD_InitComplete2+0x0/0x8c [bridgedriver]) (WCD_InitComplete2+0x0/0x8c [bridgedriver]) from [<bf0487e0>] from [<bf0487e0>] (DSP_Init+0xd8/0xf0 [bridge)
(DSP_Init+0xd8/0xf0 [bridgedriver])
 r5:c3dc5c99 r5:c3dc5c99 r4:00008000 r4:00008000

[<bf048708>] [<bf048708>] (DSP_Init+0x0/0xf0 [bridgedriver]) (DSP_Init+0x0/0xf0 [bridgedriver]) from [<bf05d33c>] from [<bf05d33c>] (bridge_init+0x33c/0x3ec [bridgedriver])
(bridge_init+0x33c/0x3ec [bridgedriver])
 r6:bf05a288 r6:bf05a288 r5:bf05ab88 r5:bf05ab88 r4:bf05ab88 r4:bf05ab88

[<bf05d000>] [<bf05d000>] (bridge_init+0x0/0x3ec [bridgedriver]) (bridge_init+0x0/0x3ec [bridgedriver]) from [<c002d2d4>] from [<c002d2d4>] (do_one_initcall+0x64/0x198)
(do_one_initcall+0x64/0x198)
 r8:c002df28 r8:c002df28 r7:00000000 r7:00000000 r6:4023a000 r6:4023a000 r5:bf05a520 r5:bf05a520 r4:c03aa340 r4:c03aa340

[<c002d270>] [<c002d270>] (do_one_initcall+0x0/0x198) (do_one_initcall+0x0/0x198) from [<c0078cd4>] from [<c0078cd4>] (sys_init_module+0x98/0x188)
(sys_init_module+0x98/0x188)
[<c0078c3c>] [<c0078c3c>] (sys_init_module+0x0/0x188) (sys_init_module+0x0/0x188) from [<c002dd80>] from [<c002dd80>] (ret_fast_syscall+0x0/0x2c)
(ret_fast_syscall+0x0/0x2c)
 r7:00000080 r7:00000080 r6:00000000 r6:00000000 r5:0000000b r5:0000000b r4:00000000 r4:00000000

<4>---[ end trace 7a555f9f02586741 ]---
---[ end trace 7a555f9f02586741 ]---
# <4>SR1: VDD autocomp is not active
SR1: VDD autocomp is not active
<4>SR1: VDD autocomp is not active
SR1: VDD autocomp is not active

Regards,
Nishanth Menon
