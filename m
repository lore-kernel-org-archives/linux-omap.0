From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod_data: fix missing OMAP_INTC_START in
 irq data
Date: Thu, 26 Dec 2013 04:20:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312260417180.15949@utopia.booyaka.com>
References: <1387839191-57886-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41792 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab3LZEUQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Dec 2013 23:20:16 -0500
In-Reply-To: <1387839191-57886-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 23 Dec 2013, Suman Anna wrote:

> Commit 7d7e1eb (ARM: OMAP2+: Prepare for irqs.h removal) and commit
> ec2c082 (ARM: OMAP2+: Remove hardcoded IRQs and enable SPARSE_IRQ)
> updated the way interrupts for OMAP2/3 devices are defined in the
> HWMOD data structures to being an index plus a fixed offset (defined
> by OMAP_INTC_START).
> 
> Couple of irqs in the OMAP2/3 hwmod data were misconfigured completely
> as they were missing this OMAP_INTC_START relative offset. Add this
> offset back to fix the incorrect irq data for the following modules:
> 	OMAP2 - GPMC, RNG
> 	OMAP3 - GPMC, ISP MMU & IVA MMU
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> This patch is applicable to only current 3.13 and past kernels (from
> 3.7 onwards), it is not needed for 3.14 as this IRQ data has already
> been cleaned up in Tony's omap-for-v3.14/omap3-board-removal branch.

Please don't forget to Cc the linux-arm-kernel mailing list.  I've done it 
for you this time.

Also, for fixes patches, please start adding "Fixes:" lines, and Cc: lines 
for the original patch authors.  For example, I've added these to the 
patch:

    Fixes: 7d7e1eba7e92 ("ARM: OMAP2+: Prepare for irqs.h removal")
    Fixes: ec2c0825ca31 ("ARM: OMAP2+: Remove hardcoded IRQs and enable SPARSE_IRQ")
    Cc: Tony Lindgren <tony@atomide.com>

But it would be much better if you could do this.

Queued.


- Paul
