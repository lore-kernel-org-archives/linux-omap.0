From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH] OMAP:iommu - pgd and pte entries weren't getting flushed out
Date: Wed, 2 Mar 2011 14:42:36 +0200
Message-ID: <AANLkTince7L2uRog-nCJa14GH6ieKw2hEfEfWNZeGgNj@mail.gmail.com>
References: <1299008793-27428-1-git-send-email-fernando.lugo@ti.com>
	<1299008793-27428-2-git-send-email-fernando.lugo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46127 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269Ab1CBMmh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 07:42:37 -0500
In-Reply-To: <1299008793-27428-2-git-send-email-fernando.lugo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fernando Guzman Lugo <fernando.lugo@ti.com>
Cc: hiroshi.doyu@nokia.com, tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Hari Kanigeri <h-kanigeri2@ti.com>

Hi,

On Tue, Mar 1, 2011 at 9:46 PM, Fernando Guzman Lugo
<fernando.lugo@ti.com> wrote:
> From: Hari Kanigeri <h-kanigeri2@ti.com>
>
> pgd and pte entries weren't getting flushed out leading to MMU faults=
=2E

May I ask you to add to the patch body description why it's wrong and
why your solution is necessary?

Br,

David

>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
> =C2=A0arch/arm/plat-omap/iommu.c | =C2=A0 12 ++++++------
> =C2=A01 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index aeb2c33..e9473ff 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -508,7 +508,7 @@ static u32 *iopte_alloc(struct iommu *obj, u32 *i=
opgd, u32 da)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return ERR_PTR(-ENOMEM);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*iopgd =3D vir=
t_to_phys(iopte) | IOPGD_TABLE;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flush_iopgd_range(=
iopgd, iopgd);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flush_iopgd_range(=
iopgd, iopgd + 1);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_vdbg(obj->=
dev, "%s: a new pte:%p\n", __func__, iopte);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> @@ -537,7 +537,7 @@ static int iopgd_alloc_section(struct iommu *obj,=
 u32 da, u32 pa, u32 prot)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*iopgd =3D (pa & IOSECTION_MASK) | prot | =
IOPGD_SECTION;
> - =C2=A0 =C2=A0 =C2=A0 flush_iopgd_range(iopgd, iopgd);
> + =C2=A0 =C2=A0 =C2=A0 flush_iopgd_range(iopgd, iopgd + 1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> @@ -554,7 +554,7 @@ static int iopgd_alloc_super(struct iommu *obj, u=
32 da, u32 pa, u32 prot)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < 16; i++)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(iopgd + i) =3D=
 (pa & IOSUPER_MASK) | prot | IOPGD_SUPER;
> - =C2=A0 =C2=A0 =C2=A0 flush_iopgd_range(iopgd, iopgd + 15);
> + =C2=A0 =C2=A0 =C2=A0 flush_iopgd_range(iopgd, iopgd + 16);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> @@ -567,7 +567,7 @@ static int iopte_alloc_page(struct iommu *obj, u3=
2 da, u32 pa, u32 prot)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR=
(iopte);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*iopte =3D (pa & IOPAGE_MASK) | prot | IOP=
TE_SMALL;
> - =C2=A0 =C2=A0 =C2=A0 flush_iopte_range(iopte, iopte);
> + =C2=A0 =C2=A0 =C2=A0 flush_iopte_range(iopte, iopte + 1);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_vdbg(obj->dev, "%s: da:%08x pa:%08x pt=
e:%p *pte:%08x\n",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, da,=
 pa, iopte, *iopte);
> @@ -592,7 +592,7 @@ static int iopte_alloc_large(struct iommu *obj, u=
32 da, u32 pa, u32 prot)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < 16; i++)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(iopte + i) =3D=
 (pa & IOLARGE_MASK) | prot | IOPTE_LARGE;
> - =C2=A0 =C2=A0 =C2=A0 flush_iopte_range(iopte, iopte + 15);
> + =C2=A0 =C2=A0 =C2=A0 flush_iopte_range(iopte, iopte + 16);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> @@ -763,7 +763,7 @@ void iopgtable_clear_entry_all(struct iommu *obj)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0iopte_free(iopte_offset(iopgd, 0));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*iopgd =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flush_iopgd_range(=
iopgd, iopgd);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flush_iopgd_range(=
iopgd, iopgd + 1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0flush_iotlb_all(obj);
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
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
