From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONACHED
	L1 entries
Date: Sun, 8 Aug 2010 12:34:04 +0100
Message-ID: <20100808113403.GA23623@n2100.arm.linux.org.uk>
References: <1281262672-27626-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44675 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441Ab0HHLeQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Aug 2010 07:34:16 -0400
Content-Disposition: inline
In-Reply-To: <1281262672-27626-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Aug 08, 2010 at 03:47:52PM +0530, Santosh Shilimkar wrote:
> @@ -475,6 +486,9 @@ static void __init build_mem_type_table(void)
>  	mem_types[MT_LOW_VECTORS].prot_l1 |= ecc_mask;
>  	mem_types[MT_HIGH_VECTORS].prot_l1 |= ecc_mask;
>  	mem_types[MT_MEMORY].prot_sect |= ecc_mask | cp->pmd;
> +	mem_types[MT_MEMORY].prot_pte |= kern_pgprot;
> +	mem_types[MT_MEMORY_NONCACHED].prot_sect |= ecc_mask | cp->pmd;
> +	mem_types[MT_MEMORY_NONCACHED].prot_pte |= kern_pgprot;

This is wrong - it will result in the non-cached memory mapped in as
sections having the same cache settings as MT_MEMORY - in other
words, probably write back.
