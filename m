From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: Reclaim address space on omaps, Tony on vacation in July
Date: Fri, 26 Jun 2009 13:15:28 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B53AB55D@dbde02.ent.ti.com>
References: <20090626062539.GX7352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60950 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531AbZFZHpv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jun 2009 03:45:51 -0400
In-Reply-To: <20090626062539.GX7352@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Friday, June 26, 2009 11:56 AM
> To: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.arm.linux.org.uk
> Subject: RFC: Reclaim address space on omaps, Tony on vacation in July
> 
> Hi all,
> 
> Last week I posted some more omap io.h clean-up patches to 
> the linux-omap
> list [1], and started looking at what it would take to 
> reclaim lost address
> space on top of the io.h clean-up patches.
> 
> Looks like we should be able to reclaim about 454MB of the 640MB
> of the lost IO address space by doing the following:
> 
> 1. Start converting drivers using omap_read/write to use ioremap +
>    __raw_read/write
> 
> 2. Remove OMAP2_IO_ADDRESS macro, and replace it with with 
> finer grained
>    OMAP_L3_ADDRESS, OMAP_L4_ADDRESS, OMAP_SDRC_ADDRESS and so 
> on macros

> 3. Remap the the IO addresses in smaller sections in io.h so 
> the virtual
>    address for the blocks stays the same, and is counted down from the
>    ARM reserved DMA address.
> 
> After these steps, omap io.h would look like this:
> 
> #define ARM_RESERVED_FUTURE_DMA	0xff000000 /* 
> Documentation/arm/memory.txt */
> #define OMAP23_L4_PHYS		0x48000000
> #define OMAP24_L3_PHYS		0x68000000
> #define OMAP4_L3_PHYS		0x44000000
> #define OMAP4_L4_PHYS		0x4a000000
> 
> /* These virtual addresses are the same for all omaps */
> #define OMAP_L3_SIZE		SZ_1M
> #define OMAP_L3_VIRT		(ARM_RESERVED_FUTURE_DMA - OMAP_L3_SIZE)
> #define OMAP_L4_SIZE		(SZ_16M + SZ_1M)
> #define OMAP_L4_VIRT		(OMAP_L3_VIRT - OMAP_L4_SIZE)
> #define OMAP_SDRC_SIZE		SZ_1M
> #define OMAP_SDRC_BASE		(OMAP_L4_VIRT - OMAP_SDRC_SIZE)
> ...
> 
> 
> #define OMAP_L3_ADDRESS(pa)	(((pa) & ~0xff000000) + OMAP_L3_VIRT)
> #define OMAP_L4_ADDRESS(pa)	(((pa) & ~0xff000000) + OMAP_L4_VIRT)
> #define OMAP_SDRC_ADDRESS(pa)	(((pa) & ~0xff000000) + OMAP_SDRC_VIRT)
We surely need this going forward since there is also demand to fit higher 
RAMS(256MB,512MB,1GB)in the system. 

Just to confirm, any further patches on this topic should be on top of this:
Tony Lindgren (3):
      OMAP: Remove ifdefs for io.h
      OMAP: Rename OMAP_MPUIO_BASE to OMAP1_MPUIO_BASE
      OMAP: Remove OMAP_IO_ADDRESS, use OMAP1_IO_ADDRESS and OMAP2_IO_ADDRESS instead

Is that correct Tony ?

Regards,
Santosh
 