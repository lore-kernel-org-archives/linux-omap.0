From: Tony Lindgren <tony@atomide.com>
Subject: RFC: Reclaim address space on omaps, Tony on vacation in July
Date: Fri, 26 Jun 2009 09:25:40 +0300
Message-ID: <20090626062539.GX7352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55681 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbZFZGZr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jun 2009 02:25:47 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk

Hi all,

Last week I posted some more omap io.h clean-up patches to the linux-omap
list [1], and started looking at what it would take to reclaim lost address
space on top of the io.h clean-up patches.

Looks like we should be able to reclaim about 454MB of the 640MB
of the lost IO address space by doing the following:

1. Start converting drivers using omap_read/write to use ioremap +
   __raw_read/write

2. Remove OMAP2_IO_ADDRESS macro, and replace it with with finer grained
   OMAP_L3_ADDRESS, OMAP_L4_ADDRESS, OMAP_SDRC_ADDRESS and so on macros

3. Remap the the IO addresses in smaller sections in io.h so the virtual
   address for the blocks stays the same, and is counted down from the
   ARM reserved DMA address.

After these steps, omap io.h would look like this:

#define ARM_RESERVED_FUTURE_DMA	0xff000000 /* Documentation/arm/memory.txt */
#define OMAP23_L4_PHYS		0x48000000
#define OMAP24_L3_PHYS		0x68000000
#define OMAP4_L3_PHYS		0x44000000
#define OMAP4_L4_PHYS		0x4a000000

/* These virtual addresses are the same for all omaps */
#define OMAP_L3_SIZE		SZ_1M
#define OMAP_L3_VIRT		(ARM_RESERVED_FUTURE_DMA - OMAP_L3_SIZE)
#define OMAP_L4_SIZE		(SZ_16M + SZ_1M)
#define OMAP_L4_VIRT		(OMAP_L3_VIRT - OMAP_L4_SIZE)
#define OMAP_SDRC_SIZE		SZ_1M
#define OMAP_SDRC_BASE		(OMAP_L4_VIRT - OMAP_SDRC_SIZE)
...


#define OMAP_L3_ADDRESS(pa)	(((pa) & ~0xff000000) + OMAP_L3_VIRT)
#define OMAP_L4_ADDRESS(pa)	(((pa) & ~0xff000000) + OMAP_L4_VIRT)
#define OMAP_SDRC_ADDRESS(pa)	(((pa) & ~0xff000000) + OMAP_SDRC_VIRT)
...

Anybody got better ideas? In general, while thinking about this, we
should all start working on step 1 above where possible no matter what.

Also, I will be mostly offline in July. Meanwhile, please try to make all
the patches against the mainline kernel where possible to avoid cross
dependencies. Some code of course depends on some topic branches like pm
or dss2. Or the stuff in omap-headers branch for the omap headers.

Cheers,

Tony

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg13874.html
