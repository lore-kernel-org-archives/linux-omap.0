From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH v2 3/3] omap: iovmm: don't check 'da' to set
 IOVMF_DA_FIXED flag
Date: Tue, 8 Mar 2011 14:42:04 -0600
Message-ID: <AANLkTindXXOsx8ibp0tmVx9HGfQ4eeQoO0kLj=C67w6+@mail.gmail.com>
References: <1299615316-17512-1-git-send-email-dacohen@gmail.com>
	<1299615316-17512-4-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36055 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755597Ab1CHUmJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 15:42:09 -0500
In-Reply-To: <1299615316-17512-4-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com, sakari.ailus@maxwell.research.nokia.com

On Tue, Mar 8, 2011 at 2:15 PM, David Cohen <dacohen@gmail.com> wrote:
> Currently IOVMM driver sets IOVMF_DA_FIXED/IOVMF_DA_ANON flags accord=
ing
> to input 'da' address when mapping memory:
> da =3D=3D 0: IOVMF_DA_ANON
> da !=3D 0: IOVMF_DA_FIXED
>
> It prevents IOMMU to map first page with fixed 'da'. To avoid such
> issue, IOVMM will not automatically set IOVMF_DA_FIXED. It should now
> come from the user throught 'flags' parameter when mapping memory.
> As IOVMF_DA_ANON and IOVMF_DA_FIXED are mutually exclusive, IOVMF_DA_=
ANON
> can be removed. The driver will now check internally if IOVMF_DA_FIXE=
D
> is set or not.

Looks good to me.

Regards,
=46ernando.

>
> Signed-off-by: David Cohen <dacohen@gmail.com>
> ---
> =A0arch/arm/plat-omap/include/plat/iovmm.h | =A0 =A02 --
> =A0arch/arm/plat-omap/iovmm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 14 +++=
++---------
> =A02 files changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/iovmm.h b/arch/arm/plat-=
omap/include/plat/iovmm.h
> index bdc7ce5..32a2f6c 100644
> --- a/arch/arm/plat-omap/include/plat/iovmm.h
> +++ b/arch/arm/plat-omap/include/plat/iovmm.h
> @@ -71,8 +71,6 @@ struct iovm_struct {
> =A0#define IOVMF_LINEAR_MASK =A0 =A0 =A0(3 << (2 + IOVMF_SW_SHIFT))
>
> =A0#define IOVMF_DA_FIXED =A0 =A0 =A0 =A0 (1 << (4 + IOVMF_SW_SHIFT))
> -#define IOVMF_DA_ANON =A0 =A0 =A0 =A0 =A0(2 << (4 + IOVMF_SW_SHIFT))
> -#define IOVMF_DA_MASK =A0 =A0 =A0 =A0 =A0(3 << (4 + IOVMF_SW_SHIFT))
>
>
> =A0extern struct iovm_struct *find_iovm_area(struct iommu *obj, u32 d=
a);
> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> index e5f8341..894489c 100644
> --- a/arch/arm/plat-omap/iovmm.c
> +++ b/arch/arm/plat-omap/iovmm.c
> @@ -279,7 +279,7 @@ static struct iovm_struct *alloc_iovm_area(struct=
 iommu *obj, u32 da,
> =A0 =A0 =A0 =A0start =3D da;
> =A0 =A0 =A0 =A0alignment =3D PAGE_SIZE;
>
> - =A0 =A0 =A0 if (flags & IOVMF_DA_ANON) {
> + =A0 =A0 =A0 if (~flags & IOVMF_DA_FIXED) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Don't map address 0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (obj->da_start)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0start =3D obj->da_star=
t;
> @@ -307,7 +307,7 @@ static struct iovm_struct *alloc_iovm_area(struct=
 iommu *obj, u32 da,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tmp->da_start > start && (tmp->da_=
start - start) >=3D bytes)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto found;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tmp->da_end >=3D start && flags & I=
OVMF_DA_ANON)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tmp->da_end >=3D start && ~flags & =
IOVMF_DA_FIXED)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0start =3D roundup(tmp-=
>da_end + 1, alignment);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prev_end =3D tmp->da_end;
> @@ -654,7 +654,6 @@ u32 iommu_vmap(struct iommu *obj, u32 da, const s=
truct sg_table *sgt,
> =A0 =A0 =A0 =A0flags &=3D IOVMF_HW_MASK;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_DISCONT;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_MMIO;
> - =A0 =A0 =A0 flags |=3D (da ? IOVMF_DA_FIXED : IOVMF_DA_ANON);
>
> =A0 =A0 =A0 =A0da =3D __iommu_vmap(obj, da, sgt, va, bytes, flags);
> =A0 =A0 =A0 =A0if (IS_ERR_VALUE(da))
> @@ -694,7 +693,7 @@ EXPORT_SYMBOL_GPL(iommu_vunmap);
> =A0* @flags: =A0 =A0 iovma and page property
> =A0*
> =A0* Allocate @bytes linearly and creates 1-n-1 mapping and returns
> - * @da again, which might be adjusted if 'IOVMF_DA_ANON' is set.
> + * @da again, which might be adjusted if 'IOVMF_DA_FIXED' is not set=
=2E
> =A0*/
> =A0u32 iommu_vmalloc(struct iommu *obj, u32 da, size_t bytes, u32 fla=
gs)
> =A0{
> @@ -713,7 +712,6 @@ u32 iommu_vmalloc(struct iommu *obj, u32 da, size=
_t bytes, u32 flags)
> =A0 =A0 =A0 =A0flags &=3D IOVMF_HW_MASK;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_DISCONT;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_ALLOC;
> - =A0 =A0 =A0 flags |=3D (da ? IOVMF_DA_FIXED : IOVMF_DA_ANON);
>
> =A0 =A0 =A0 =A0sgt =3D sgtable_alloc(bytes, flags, da, 0);
> =A0 =A0 =A0 =A0if (IS_ERR(sgt)) {
> @@ -784,7 +782,7 @@ static u32 __iommu_kmap(struct iommu *obj, u32 da=
, u32 pa, void *va,
> =A0* @flags: =A0 =A0 iovma and page property
> =A0*
> =A0* Creates 1-1-1 mapping and returns @da again, which can be
> - * adjusted if 'IOVMF_DA_ANON' is set.
> + * adjusted if 'IOVMF_DA_FIXED' is not set.
> =A0*/
> =A0u32 iommu_kmap(struct iommu *obj, u32 da, u32 pa, size_t bytes,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 flags)
> @@ -803,7 +801,6 @@ u32 iommu_kmap(struct iommu *obj, u32 da, u32 pa,=
 size_t bytes,
> =A0 =A0 =A0 =A0flags &=3D IOVMF_HW_MASK;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_LINEAR;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_MMIO;
> - =A0 =A0 =A0 flags |=3D (da ? IOVMF_DA_FIXED : IOVMF_DA_ANON);
>
> =A0 =A0 =A0 =A0da =3D __iommu_kmap(obj, da, pa, va, bytes, flags);
> =A0 =A0 =A0 =A0if (IS_ERR_VALUE(da))
> @@ -842,7 +839,7 @@ EXPORT_SYMBOL_GPL(iommu_kunmap);
> =A0* @flags: =A0 =A0 iovma and page property
> =A0*
> =A0* Allocate @bytes linearly and creates 1-1-1 mapping and returns
> - * @da again, which might be adjusted if 'IOVMF_DA_ANON' is set.
> + * @da again, which might be adjusted if 'IOVMF_DA_FIXED' is not set=
=2E
> =A0*/
> =A0u32 iommu_kmalloc(struct iommu *obj, u32 da, size_t bytes, u32 fla=
gs)
> =A0{
> @@ -862,7 +859,6 @@ u32 iommu_kmalloc(struct iommu *obj, u32 da, size=
_t bytes, u32 flags)
> =A0 =A0 =A0 =A0flags &=3D IOVMF_HW_MASK;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_LINEAR;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_ALLOC;
> - =A0 =A0 =A0 flags |=3D (da ? IOVMF_DA_FIXED : IOVMF_DA_ANON);
>
> =A0 =A0 =A0 =A0da =3D __iommu_kmap(obj, da, pa, va, bytes, flags);
> =A0 =A0 =A0 =A0if (IS_ERR_VALUE(da))
> --
> 1.7.0.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
