From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH] omap:iommu-added cache flushing operation for L2 cache
Date: Wed, 2 Mar 2011 13:58:58 +0200
Message-ID: <AANLkTi=ULWw2CsZgcYpkXrA+qQe3ufDhW5es0dwe66ph@mail.gmail.com>
References: <1299008793-27428-1-git-send-email-fernando.lugo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1299008793-27428-1-git-send-email-fernando.lugo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fernando Guzman Lugo <fernando.lugo@ti.com>
Cc: hiroshi.doyu@nokia.com, tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ramesh Gupta <grgupta@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Mar 1, 2011 at 9:46 PM, Fernando Guzman Lugo
<fernando.lugo@ti.com> wrote:
> From: Ramesh Gupta <grgupta@ti.com>

No patch body description at all?
Can we get at least something here?

Regards,

David

>
> Signed-off-by: Ramesh Gupta <grgupta@ti.com>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
> =C2=A0arch/arm/plat-omap/iommu.c | =C2=A0 22 ++++++++--------------
> =C2=A01 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index e3eb038..aeb2c33 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -471,22 +471,15 @@ EXPORT_SYMBOL_GPL(foreach_iommu_device);
> =C2=A0*/
> =C2=A0static void flush_iopgd_range(u32 *first, u32 *last)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 /* FIXME: L2 cache should be taken care of if =
it exists */
> - =C2=A0 =C2=A0 =C2=A0 do {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 asm("mcr =C2=A0 =C2=
=A0 =C2=A0 =C2=A0p15, 0, %0, c7, c10, 1 @ flush_pgd"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : : =
"r" (first));
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 first +=3D L1_CACH=
E_BYTES / sizeof(*first);
> - =C2=A0 =C2=A0 =C2=A0 } while (first <=3D last);
> + =C2=A0 =C2=A0 =C2=A0 dmac_flush_range(first, last);
> + =C2=A0 =C2=A0 =C2=A0 outer_flush_range(virt_to_phys(first), virt_to=
_phys(last));
> =C2=A0}
>
> +
> =C2=A0static void flush_iopte_range(u32 *first, u32 *last)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 /* FIXME: L2 cache should be taken care of if =
it exists */
> - =C2=A0 =C2=A0 =C2=A0 do {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 asm("mcr =C2=A0 =C2=
=A0 =C2=A0 =C2=A0p15, 0, %0, c7, c10, 1 @ flush_pte"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : : =
"r" (first));
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 first +=3D L1_CACH=
E_BYTES / sizeof(*first);
> - =C2=A0 =C2=A0 =C2=A0 } while (first <=3D last);
> + =C2=A0 =C2=A0 =C2=A0 dmac_flush_range(first, last);
> + =C2=A0 =C2=A0 =C2=A0 outer_flush_range(virt_to_phys(first), virt_to=
_phys(last));
> =C2=A0}
>
> =C2=A0static void iopte_free(u32 *iopte)
> @@ -750,7 +743,7 @@ size_t iopgtable_clear_entry(struct iommu *obj, u=
32 da)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(iopgtable_clear_entry);
>
> -static void iopgtable_clear_entry_all(struct iommu *obj)
> +void iopgtable_clear_entry_all(struct iommu *obj)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
>
> @@ -777,7 +770,7 @@ static void iopgtable_clear_entry_all(struct iomm=
u *obj)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&obj->page_table_lock);
> =C2=A0}
> -
> +EXPORT_SYMBOL_GPL(iopgtable_clear_entry_all);
> =C2=A0/*
> =C2=A0* =C2=A0 =C2=A0 Device IOMMU generic operations
> =C2=A0*/
> @@ -1068,6 +1061,7 @@ static void iopte_cachep_ctor(void *iopte)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0clean_dcache_area(iopte, IOPTE_TABLE_SIZE)=
;
> =C2=A0}
>
> +
> =C2=A0static int __init omap_iommu_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct kmem_cache *p;
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
