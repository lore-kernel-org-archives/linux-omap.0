From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [v3.6 3/3] iommu/tegra: smmu: Fix unsleepable memory allocation
 at alloc_pdir()
Date: Tue, 17 Jul 2012 14:25:24 +0200
Message-ID: <20120717.152524.175499431618552821.hdoyu@nvidia.com>
References: <1341228398-6878-1-git-send-email-hdoyu@nvidia.com><1341228398-6878-3-git-send-email-hdoyu@nvidia.com><20120717100901.GH4213@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120717100901.GH4213-5C7GfCeVMHo@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org" <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>, "ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org" <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Joerg,

Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org> wrote @ Tue, 17 Jul 2012 12:09:01 +0200:

> On Mon, Jul 02, 2012 at 02:26:38PM +0300, Hiroshi DOYU wrote:
> 
> > Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > Reported-by: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
> > Cc: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
> > Acked-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> 
> Applied patch 2 and 3 but not patch 1. The resulting conflicts are
> solved while merging the next branch. Also I am not happy with the way
> the as->lock is taken and released multiple times in patch 3. So I added
> another commit on-top. Please have a look at it as I can only
> compile-test that change:
> 
> From f9a4f063a88297e361fd6676986cf3e39b22de72 Mon Sep 17 00:00:00 2001
> From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
> Date: Tue, 17 Jul 2012 11:47:14 +0200
> Subject: [PATCH] iommu/tegra: Don't call alloc_pdir with as->lock
> 
> Instead of taking as->lock before calling alloc_pdir() and
> releasing it in that function to allocate memory, just take
> the lock only in the alloc_pdir function and run the loop
> without any lock held. This simplifies the complicated
> lock->unlock->alloc->lock->unlock sequence into
> alloc->lock->unlock.
> 
> Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c |   29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 68a15a0..541d210 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -553,11 +553,11 @@ static inline void put_signature(struct smmu_as *as,
>  #endif
>  
>  /*
> - * Caller must lock/unlock as
> + * Caller must not hold as->lock
>   */
> -static int alloc_pdir(struct smmu_as *as, unsigned long *flags)
> +static int alloc_pdir(struct smmu_as *as)
>  {
> -	unsigned long *pdir;
> +	unsigned long *pdir, flags;
>  	int pdn, err = 0;
>  	u32 val;
>  	struct smmu_device *smmu = as->smmu;
> @@ -565,13 +565,14 @@ static int alloc_pdir(struct smmu_as *as, unsigned long *flags)
>  	unsigned int *cnt;
>  
>  	/*
> -	 * do the allocation outside the as->lock
> +	 * do the allocation, then grab as->lock
>  	 */
> -	spin_unlock_irqrestore(&as->lock, *flags);
>  	cnt = devm_kzalloc(smmu->dev,
> -			   sizeof(cnt[0]) * SMMU_PDIR_COUNT, GFP_KERNEL);
> +			   sizeof(cnt[0]) * SMMU_PDIR_COUNT,
> +			   GFP_KERNEL);
>  	page = alloc_page(GFP_KERNEL | __GFP_DMA);
> -	spin_lock_irqsave(&as->lock, *flags);
> +
> +	spin_lock_irqsave(&as->lock, flags);
>  
>  	if (as->pdir_page) {
>  		/* We raced, free the redundant */
> @@ -603,9 +604,13 @@ static int alloc_pdir(struct smmu_as *as, unsigned long *flags)
>  	smmu_write(smmu, val, SMMU_TLB_FLUSH);
>  	FLUSH_SMMU_REGS(as->smmu);
>  
> +	spin_unlock_irqrestore(&as->lock, flags);
> +
>  	return 0;
>  
>  err_out:
> +	spin_unlock_irqrestore(&as->lock, flags);
> +
>  	devm_kfree(smmu->dev, cnt);
>  	if (page)
>  		__free_page(page);
> @@ -809,13 +814,11 @@ static int smmu_iommu_domain_init(struct iommu_domain *domain)
>  	/* Look for a free AS with lock held */
>  	for  (i = 0; i < smmu->num_as; i++) {
>  		as = &smmu->as[i];
> -		spin_lock_irqsave(&as->lock, flags);
>  		if (!as->pdir_page) {
> -			err = alloc_pdir(as, &flags);
> +			err = alloc_pdir(as);
>  			if (!err)
>  				goto found;

The above spin_lock is always necessary. "as->lock" should be held to
protect "as->pdir_page". Only when "as->pdir_page" is NULL,
"as->pdir_page" would be allocated in "alloc_pdir()". Without this
lock, the following race could happen:


Without as->lock:
A:			B:
i == 3
pdir_page == NULL
			i == 3
	     		pdir_page == NULL
pdir_page = a;
			pdir_page = b;	!!!!!! OVERWRITTEN !!!!!!



With as->lock:
A:			B:
i == 3
lock(as->lock)
pdir_page == NULL
			i == 3
			Waiting lock released....
	     		Waiting lock released....
pdir_page = a;		
unlock(as->lock)	
			lock(as->lock)
			pdir_page != NULL && continue
			unlock(as->lock)

			i == 4
			.....


This "lock, unlock, alloc, lock, check race" method was originally
introduced by Russell King a few years ago(*1). And the same mechanism
has been used in omap iommu for years(*2) at least as below:

drivers/iommu/omap-iommu.c:
.....
505          * do the allocation outside the page table lock
506          */
507         spin_unlock(&obj->page_table_lock);
508         iopte = kmem_cache_zalloc(iopte_cachep, GFP_KERNEL);
509         spin_lock(&obj->page_table_lock);
510 
511         if (!*iopgd) {
512                 if (!iopte)
513                         return ERR_PTR(-ENOMEM);
514 
515                 *iopgd = virt_to_phys(iopte) | IOPGD_TABLE;
516                 flush_iopgd_range(iopgd, iopgd);
517 
518                 dev_vdbg(obj->dev, "%s: a new pte:%p\n", __func__, iopte);
519         } else {
520                 /* We raced, free the reduniovant table */
521                 iopte_free(iopte);
522         }


Still we can do preallocation for pdir_page before this lock held, but
if we do that, we have to change the function name, "alloc_pdir()" to
something else because it doesn't allocate actually, and some other
allocations also have to be done in advance too. At this moment, I'd
rather keep the current structure with Russell's method.

*1:
http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg04007.html
*2:
http://lxr.free-electrons.com/source/drivers/iommu/omap-iommu.c#L496
