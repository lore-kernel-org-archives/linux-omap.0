From: "McFarland, Brian" <Brian.McFarland@harman.com>
Subject: A case for ZONE_DMA32 (or similar) on LPAE?
Date: Mon, 23 Oct 2017 18:07:51 +0000
Message-ID: <4c9a447c06cf47cdb5b07d3774ea7e5d@HICGWSMB03.ad.harman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Using the TI's 6AM.1.3 release for DRA7x I have an oom-killer problem that only occurs with LPAE enabled.

That is to say - I have a baseline system runs without oom-killer on a non-LPAE kernel, but recently enabled LPAE to allow access to 4GB of RAM (my baseline HW 2G). When doing so, I see oom-killer issues early and often.

I believe I've narrowed down the problem to  an issue with the SGX/PowerVR driver, pvrsrvkm (open source-ish but built out-of-tree).  When LPAE is disabled, the driver allocates using GFP_HIGHMEM because all memory is "32-bit safe", making it accessible to the SGX core. 

When LPAE is enabled, instead the driver uses GFP_DMA32, which on arch's where the zone does not exists - falls back to ZONE_NORMAL or ZONE_DMA, which are constricted to the first approx 768MB.  

So you enable LPAE to access more RAM and in effect limit the amount of RAM accessible by this driver from 2GB total down to just 768MB.  There is another 1.3GB that gets lumped into highmem that *could* be used, but there's no zone for that and as far as I can tell, no other plan in the kernel to allocate memory with the constraint of being outside lowmem but still 32-bit addressable.

To test the theory that this the root cause of my problem, I forced the driver to use GFP_HIGHMEM even on LPAE then used devicetree fixups in u-boot to limit memory kernel is made aware of to 2GB, forcing it to be 32-bit accessible.  With this configuration I am unable to reproduce the oom-killer issue at all.

TI has a patch that sets dma_zone_size to SZ_2G in the machine_desc, but that doesn't appear to do anything useful.  On LPAE we only have 2 zones with non-zero memory size: ZONE_DMA and ZONE_HIGHMEM.  ZONE_DMA's size is set in a round-about way to arm_lowmem_limit. ZONE_NORMAL is set to size 0.

This all leads me to believe I need another zone.  A zone that spans from arm_lowmem_limit to the end of 32-bit space, which in the case of dra7x is nominally about 1.3GB.

This appears to be the general idea behind ZONE_DMA32 but the zone has comes in & out of multiple arch's and I cannot find any clear information on the exact intention of said zone.  It used to be on arm64 but was since removed. As far as I can tell, no one ever used it on arm32+LPAE.

Is this "hole" in the mm design for ARM+LPAE? Or just a strange edge case no one else cares about?  Any suggestions would be greatly appreciated.

Source for the driver in question is available here:

	https://git.ti.com/android-sdk/device-ti-proprietary-open/blobs/master/jacinto6/sgx_src/eurasia_km/services4/srvkm/env/linux/mm.c

Selected excerpts:

/* Decide whether or not DevMem allocs need __GFP_DMA32 */
#ifndef SGX_FEATURE_36BIT_MMU
#       ifdef CONFIG_ZONE_DMA
#               if defined CONFIG_X86_PAE || defined CONFIG_ARM_LPAE || defined CONFIG_64BIT
#                       define PVR_USE_DMA32_FOR_DEVMEM_ALLOCS
#               endif
#       endif
#endif

...

#if defined(PVR_USE_DMA32_FOR_DEVMEM_ALLOCS)
        gfp_mask |= __GFP_DMA32;
#else
        gfp_mask |= __GFP_HIGHMEM;
#endif

        /* Allocate virtually contiguous pages */
    pvRet = __vmalloc(uiBytes, gfp_mask, PGProtFlags);

...


#if defined(PVR_USE_DMA32_FOR_DEVMEM_ALLOCS)
        gfp_mask |= __GFP_DMA32;
#else
        gfp_mask |= __GFP_HIGHMEM;
#endif

        psPage = alloc_pages(gfp_mask, 0);
