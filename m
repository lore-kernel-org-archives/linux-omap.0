From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] arm: Flush TLB entries in setup_mm_for_reboot()
Date: Sat, 19 Dec 2009 09:06:07 +0000
Message-ID: <20091219090607.GB28047@n2100.arm.linux.org.uk>
References: <20091219034151.26198.26570.stgit@localhost> <20091219034619.26198.58992.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49303 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbZLSJGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Dec 2009 04:06:18 -0500
Content-Disposition: inline
In-Reply-To: <20091219034619.26198.58992.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Dec 18, 2009 at 07:46:19PM -0800, Tony Lindgren wrote:
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 8c7fbd1..a2802ea 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1068,4 +1068,7 @@ void setup_mm_for_reboot(char mode)
>  		pmd[1] = __pmd(pmdval + (1 << (PGDIR_SHIFT - 1)));
>  		flush_pmd_entry(pmd);
>  	}
> +
> +	local_flush_tlb_all();
> +	flush_cache_all();

The cache flush is unnecessary.  The caches should be off at this point.
