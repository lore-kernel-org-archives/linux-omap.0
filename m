From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 01/14] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONCACHED L1 entries
Date: Wed, 29 Sep 2010 15:51:21 +0100
Message-ID: <tnxzkv0hac6.fsf@e102109-lin.cambridge.arm.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:58208 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750943Ab0I2Ovf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Sep 2010 10:51:35 -0400
In-Reply-To: <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Fri, 17 Sep 2010 15:17:45 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> This patch populates the L1 entries for MT_MEMORY and MT_MEMORY_NONCACHED
> types so that at boot-up, we can map memories outside system memory
> at page level granularity
>
> Previously the mapping was limiting to section level, which creates
> unnecessary addiotional mapping for which physical memory may not
> present. On the newer ARM with speculation, this is dangerous and can
> result in untraceable aborts.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Russell King <linux@arm.linux.org.uk>
> ---
>  arch/arm/mm/mmu.c |   17 +++++++++++++++--
>  1 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 6e1c4f6..3e986a6 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -246,6 +246,9 @@ static struct mem_type mem_types[] = {
>  		.domain    = DOMAIN_USER,
>  	},
>  	[MT_MEMORY] = {
> +		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
> +				L_PTE_USER | L_PTE_EXEC,
> +		.prot_l1   = PMD_TYPE_TABLE,

Just a quick question - does this need to have L_PTE_USER? Is it
read-only or it needs L_PTE_WRITE as well?

Thanks.

-- 
Catalin
