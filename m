From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: DSS2 broken with 36-rc1
Date: Mon, 23 Aug 2010 11:51:46 +0300
Message-ID: <4C7236A2.7080701@compulab.co.il>
References: <1281962906.1888.25.camel@chotu>	 <4C72192A.9050801@compulab.co.il>	 <1282547709.2202.1.camel@tubuntu.research.nokia.com>	 <4C722115.50401@compulab.co.il> <1282548930.2202.16.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:53509 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202Ab0HWIw3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 04:52:29 -0400
In-Reply-To: <1282548930.2202.16.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>

Tomi Valkeinen wrote:
> On Mon, 2010-08-23 at 09:19 +0200, ext Mike Rapoport wrote:
>> Tomi Valkeinen wrote:
>>> I tested 36-rc1 briefly with OMAP 3430SDP board. I wonder why that
>>> works, but not N900...
>> May it be that 3430SDP uses SRAM for the framebuffer? Or reserves framebuffer 
>> memory from the RAM that is not managed by the kernel, e.g with something like
>> mem=<RAM size - fb size> vram=<fb size>,0x8...... ?
> 
> No, SRAM cannot be used on OMAP3s, as SRAM is too small to hold a
> framebuffer. And no, I don't think it's reserving it from RAM not
> managed by the kernel.

The N900 only sets omap_vram_sdram_{start,size} in rx51_video_mem_init.
I think that it should also call omap_vram_reserve_sdram_memblock():

diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 5a1005b..fdfe844 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -101,6 +101,7 @@ void __init rx51_video_mem_init(void)
          */
         omap_vram_set_sdram_vram(PAGE_ALIGN(864 * 480 * 4) +
                         2 * PAGE_ALIGN(1280 * 720 * 4 * 2), 0);
+       omap_vram_reserve_sdram_memblock();
  }

  #else


> What is actually failing there? Looking at Ameya's original post, the
> problem is in allocating the framebuffer. Your patch is doing something
> _after_ the allocation has failed, so I don't see Ameya's problem having
> anything to do with ioremap.

You are right, I've misread the Ameya's original post. I'm fixing another problem:

OMAPFB: omapfb_init
OMAPFB: omapfb_probe
OMAPFB: create 3 framebuffers
OMAPFB: fb_infos allocated
OMAPFB: allocating 614400 bytes for fb 0
VRAM: alloc mem type 0 size 614400
VRAM: checking region 8f000000 4096
VRAM: found 8f000000, end 90000000
------------[ cut here ]------------
WARNING: at arch/arm/mm/ioremap.c:207 __arm_ioremap_pfn_caller+0x48/0x18c()

Modules linked in:
[<c004e458>] (unwind_backtrace+0x0/0xec) from [<c007dfe8>] (warn_slowpath_common+0x4c/0x64)
[<c007dfe8>] (warn_slowpath_common+0x4c/0x64) from [<c007e018>] (warn_slowpath_null+0x18/0x1c)
[<c007e018>] (warn_slowpath_null+0x18/0x1c) from [<c00500c8>] (__arm_ioremap_pfn_caller+0x48/0x18c)
[<c00500c8>] (__arm_ioremap_pfn_caller+0x48/0x18c) from [<c0050270>] (__arm_ioremap_caller+0x54/0x58)
[<c0050270>] (__arm_ioremap_caller+0x54/0x58) from [<c02561e0>] (omapfb_alloc_fbmem+0xf0/0x19c)
[<c02561e0>] (omapfb_alloc_fbmem+0xf0/0x19c) from [<c0257584>] (omapfb_allocate_all_fbs+0x2b8/0x34c)
[<c0257584>] (omapfb_allocate_all_fbs+0x2b8/0x34c) from [<c0257a80>] (omapfb_probe+0x468/0x8dc)
[<c0257a80>] (omapfb_probe+0x468/0x8dc) from [<c028330c>] (platform_drv_probe+0x18/0x1c)
[<c028330c>] (platform_drv_probe+0x18/0x1c) from [<c0282344>] (driver_probe_device+0xc8/0x184)
[<c0282344>] (driver_probe_device+0xc8/0x184) from [<c0282468>] (__driver_attach+0x68/0x8c)
[<c0282468>] (__driver_attach+0x68/0x8c) from [<c0281afc>] (bus_for_each_dev+0x44/0x74)
[<c0281afc>] (bus_for_each_dev+0x44/0x74) from [<c0281438>] (bus_add_driver+0x100/0x288)
[<c0281438>] (bus_add_driver+0x100/0x288) from [<c028275c>] (driver_register+0xa8/0x134)
[<c028275c>] (driver_register+0xa8/0x134) from [<c0022b34>] (omapfb_init+0x24/0x4c)
[<c0022b34>] (omapfb_init+0x24/0x4c) from [<c00483ac>] (do_one_initcall+0xbc/0x194)
[<c00483ac>] (do_one_initcall+0xbc/0x194) from [<c0008574>] (kernel_init+0x94/0x14c)
[<c0008574>] (kernel_init+0x94/0x14c) from [<c0049930>] (kernel_thread_exit+0x0/0x8)
---[ end trace 1b75b31a2719ed1f ]---
omapfb omapfb: failed to ioremap framebuffer
VRAM: free mem paddr 8f000000 size 614400
omapfb omapfb: failed to allocate fbmem
OMAPFB: free_resources
OMAPFB: free all fbmem
omapfb omapfb: failed to setup omapfb
omapfb: probe of omapfb failed with error -12

> Ameya, you could try turning on the debugs in
> drivers/video/omap2/vram.c, and checking what it says. Or see what is in
> debugfs/vram file
> 
>  Tomi
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sincerely yours,
Mike.

