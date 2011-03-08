From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH 3/3] omap: iovmm: don't check 'da' to set
 IOVMF_DA_FIXED/IOVMF_DA_ANON flags
Date: Tue, 8 Mar 2011 11:59:43 -0600
Message-ID: <AANLkTikvUah8LPXCeV4Opi09DJ4ZoHAc2xUVTcDhNK=Q@mail.gmail.com>
References: <1299588365-2749-1-git-send-email-dacohen@gmail.com>
	<1299588365-2749-4-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1299588365-2749-4-git-send-email-dacohen@gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com, sakari.ailus@maxwell.research.nokia.com
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 8, 2011 at 6:46 AM, David Cohen <dacohen@gmail.com> wrote:
> Currently IOVMM driver sets IOVMF_DA_FIXED/IOVMF_DA_ANON flags accord=
ing
> to input 'da' address when mapping memory:
> da =3D=3D 0: IOVMF_DA_ANON
> da !=3D 0: IOVMF_DA_FIXED
>
> It prevents IOMMU to map first page with fixed 'da'. To avoid such
> issue, IOVMM will not automatically set IOVMF_DA_FIXED. It should now
> come from the user. IOVMF_DA_ANON will be automatically set if
> IOVMF_DA_FIXED isn't set.
>
> Signed-off-by: David Cohen <dacohen@gmail.com>
> ---
> =A0arch/arm/plat-omap/iovmm.c | =A0 12 ++++++++----
> =A01 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> index 11c9b76..dde9cb0 100644
> --- a/arch/arm/plat-omap/iovmm.c
> +++ b/arch/arm/plat-omap/iovmm.c
> @@ -654,7 +654,8 @@ u32 iommu_vmap(struct iommu *obj, u32 da, const s=
truct sg_table *sgt,
> =A0 =A0 =A0 =A0flags &=3D IOVMF_HW_MASK;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_DISCONT;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_MMIO;
> - =A0 =A0 =A0 flags |=3D (da ? IOVMF_DA_FIXED : IOVMF_DA_ANON);
> + =A0 =A0 =A0 if (~flags & IOVMF_DA_FIXED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IOVMF_DA_ANON;

could we use only one? both are mutual exclusive, what happen if flag
is IOVMF_DA_FIXED | IOVMF_DA_ANON? so, I suggest to get rid of
IOVMF_DA_ANON.

Regards,
=46ernando.

>
> =A0 =A0 =A0 =A0da =3D __iommu_vmap(obj, da, sgt, va, bytes, flags);
> =A0 =A0 =A0 =A0if (IS_ERR_VALUE(da))
> @@ -713,7 +714,8 @@ u32 iommu_vmalloc(struct iommu *obj, u32 da, size=
_t bytes, u32 flags)
> =A0 =A0 =A0 =A0flags &=3D IOVMF_HW_MASK;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_DISCONT;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_ALLOC;
> - =A0 =A0 =A0 flags |=3D (da ? IOVMF_DA_FIXED : IOVMF_DA_ANON);
> + =A0 =A0 =A0 if (~flags & IOVMF_DA_FIXED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IOVMF_DA_ANON;
>
> =A0 =A0 =A0 =A0sgt =3D sgtable_alloc(bytes, flags, da, 0);
> =A0 =A0 =A0 =A0if (IS_ERR(sgt)) {
> @@ -803,7 +805,8 @@ u32 iommu_kmap(struct iommu *obj, u32 da, u32 pa,=
 size_t bytes,
> =A0 =A0 =A0 =A0flags &=3D IOVMF_HW_MASK;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_LINEAR;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_MMIO;
> - =A0 =A0 =A0 flags |=3D (da ? IOVMF_DA_FIXED : IOVMF_DA_ANON);
> + =A0 =A0 =A0 if (~flags & IOVMF_DA_FIXED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IOVMF_DA_ANON;
>
> =A0 =A0 =A0 =A0da =3D __iommu_kmap(obj, da, pa, va, bytes, flags);
> =A0 =A0 =A0 =A0if (IS_ERR_VALUE(da))
> @@ -862,7 +865,8 @@ u32 iommu_kmalloc(struct iommu *obj, u32 da, size=
_t bytes, u32 flags)
> =A0 =A0 =A0 =A0flags &=3D IOVMF_HW_MASK;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_LINEAR;
> =A0 =A0 =A0 =A0flags |=3D IOVMF_ALLOC;
> - =A0 =A0 =A0 flags |=3D (da ? IOVMF_DA_FIXED : IOVMF_DA_ANON);
> + =A0 =A0 =A0 if (~flags & IOVMF_DA_FIXED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IOVMF_DA_ANON;
>
> =A0 =A0 =A0 =A0da =3D __iommu_kmap(obj, da, pa, va, bytes, flags);
> =A0 =A0 =A0 =A0if (IS_ERR_VALUE(da))
> --
> 1.7.0.4
>
>
