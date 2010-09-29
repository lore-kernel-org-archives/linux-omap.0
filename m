From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/14] ARM: mmu: Setup MT_MEMORY and
	MT_MEMORY_NONCACHED L1 entries
Date: Wed, 29 Sep 2010 16:02:42 +0100
Message-ID: <20100929150242.GA21646@n2100.arm.linux.org.uk>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com> <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com> <tnxzkv0hac6.fsf@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37476 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002Ab0I2PDJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 11:03:09 -0400
Content-Disposition: inline
In-Reply-To: <tnxzkv0hac6.fsf@e102109-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Sep 29, 2010 at 03:51:21PM +0100, Catalin Marinas wrote:
> Hi Santosh,
> 
> Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> > This patch populates the L1 entries for MT_MEMORY and MT_MEMORY_NONCACHED
> > types so that at boot-up, we can map memories outside system memory
> > at page level granularity
> >
> > Previously the mapping was limiting to section level, which creates
> > unnecessary addiotional mapping for which physical memory may not
> > present. On the newer ARM with speculation, this is dangerous and can
> > result in untraceable aborts.
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Reviewed-by: Russell King <linux@arm.linux.org.uk>
> > ---
> >  arch/arm/mm/mmu.c |   17 +++++++++++++++--
> >  1 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index 6e1c4f6..3e986a6 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -246,6 +246,9 @@ static struct mem_type mem_types[] = {
> >  		.domain    = DOMAIN_USER,
> >  	},
> >  	[MT_MEMORY] = {
> > +		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
> > +				L_PTE_USER | L_PTE_EXEC,
> > +		.prot_l1   = PMD_TYPE_TABLE,
> 
> Just a quick question - does this need to have L_PTE_USER? Is it
> read-only or it needs L_PTE_WRITE as well?

Eek.  It should not have L_PTE_USER or else it will be accessible to
userspace.
