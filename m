From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
 supported by the hardware
Date: Mon, 10 Oct 2011 21:52:05 +0900
Message-ID: <CAHQjnOOhtSiivWf34S8mjB9nqQfUwadLzE8zOm4jYvsgL_d+Wg@mail.gmail.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
	<1316195506-9777-2-git-send-email-ohad@wizery.com>
	<20110927100505.GH2138@amd.com>
	<CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
	<20110927131222.GL2138@amd.com>
	<CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
	<20110927181438.GM2138@amd.com>
	<CAK=WgbbNs5fWHDEputZ=jzU5YN0sn0tf6AETkcsoq_Jbvc2XgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbbNs5fWHDEputZ=jzU5YN0sn0tf6AETkcsoq_Jbvc2XgQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "Roedel, Joerg" <Joerg.Roedel@amd.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stepan Moskovchenko <stepanm@codeaurora.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 3, 2011 at 12:58 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> =A0int iommu_map(struct iommu_domain *domain, unsigned long iova,
> - =A0 =A0 =A0 =A0 =A0 =A0 phys_addr_t paddr, int gfp_order, int prot)
> + =A0 =A0 =A0 =A0 =A0 =A0 phys_addr_t paddr, size_t size, int prot)
> =A0{
> - =A0 =A0 =A0 size_t size;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* both the virtual address and the physical one, as =
well as
> + =A0 =A0 =A0 =A0* the size of the mapping, must be aligned (at least=
) to the
> + =A0 =A0 =A0 =A0* size of the smallest page supported by the hardwar=
e
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!IS_ALIGNED(iova | paddr | size, iommu_min_pagesz))=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("unaligned: iova 0x%lx pa 0x%lx =
size 0x%lx min_pagesz "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "0x%x\n", iova, (unsign=
ed long)paddr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)size, io=
mmu_min_pagesz);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 size =A0 =A0 =A0 =A0 =3D 0x1000UL << gfp_order;
> + =A0 =A0 =A0 pr_debug("map: iova 0x%lx pa 0x%lx size 0x%lx\n", iova,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsign=
ed long)paddr, (unsigned long)size);
>
> - =A0 =A0 =A0 BUG_ON(!IS_ALIGNED(iova | paddr, size));
> + =A0 =A0 =A0 while (size) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long pgsize, addr_merge =3D io=
va | paddr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int pgsize_idx;
>
> - =A0 =A0 =A0 return iommu_ops->map(domain, iova, paddr, gfp_order, p=
rot);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Max page size that still fits into '=
size' */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgsize_idx =3D __fls(size);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to consider alignment requireme=
nts ? */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (likely(addr_merge)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Max page size allowe=
d by both iova and paddr */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int align_pgsi=
ze_idx =3D __ffs(addr_merge);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgsize_idx =3D min(pgsi=
ze_idx, align_pgsize_idx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* build a mask of acceptable page size=
s */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgsize =3D (1UL << (pgsize_idx + 1)) - =
1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* throw away page sizes not supported =
by the hardware */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgsize &=3D iommu_pgsize_bitmap;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* pick the biggest page */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgsize_idx =3D __fls(pgsize);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgsize =3D 1UL << pgsize_idx;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* convert index to page order */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgsize_idx -=3D PAGE_SHIFT;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("mapping: iova 0x%lx pa 0x%lx =
order %u\n", iova,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (unsigned long)paddr, pgsize_idx);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D iommu_ops->map(domain, iova, pa=
ddr, pgsize_idx, prot);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iova +=3D pgsize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 paddr +=3D pgsize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size -=3D pgsize;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> =A0}
> =A0EXPORT_SYMBOL_GPL(iommu_map);

Do not we need to unmap all intermediate mappings if iommu_map() is fai=
led?

I think iommu_map() must map the entire given area if it successes.
Otherwise, it should map nothing.

I think it can be simply done with calling iommu_unmap()
with Joerg's previous suggestion about iommu_unmap().

Regards,
KyongHo.
