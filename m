From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
	supported by the hardware
Date: Tue, 11 Oct 2011 23:59:53 +0900
Message-ID: <CAHQjnOPcetkp-XX0x4HQsR+iYN1SaCAhuBEE2nVTdhssFpUmJQ@mail.gmail.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
	<1316195506-9777-2-git-send-email-ohad@wizery.com>
	<20110927100505.GH2138@amd.com>
	<CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
	<20110927131222.GL2138@amd.com>
	<CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
	<20110927181438.GM2138@amd.com>
	<CAK=WgbbNs5fWHDEputZ=jzU5YN0sn0tf6AETkcsoq_Jbvc2XgQ@mail.gmail.com>
	<20111010094738.GW2138@amd.com>
	<CAK=WgbZ7Wyax1yfS1jSXw9OdwMtxxidwLO8PTsNUXX9CWzmVrw@mail.gmail.com>
	<20111010153609.GB2138@amd.com>
	<CAK=WgbbnuO67X46sqS87q2vw2TWq3Ekvw5p1PmXvXinQXMyowg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK=WgbbnuO67X46sqS87q2vw2TWq3Ekvw5p1PmXvXinQXMyowg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Roedel, Joerg" <Joerg.Roedel@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Hiroshi Doyu <hdoyu@nvidia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stepan Moskovchenko <stepanm@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 11, 2011 at 7:49 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> =A0int iommu_map(struct iommu_domain *domain, unsigned long iova,
> - =A0 =A0 =A0 =A0 =A0 =A0 phys_addr_t paddr, int gfp_order, int prot)
> + =A0 =A0 =A0 =A0 =A0 =A0 phys_addr_t paddr, int size, int prot)
> =A0{
Even though it is not realistic that size becomes larger than 1 <<
((sizeof(int) * 8) - 1),
I think the type of size should be size_t.

> - =A0 =A0 =A0 size_t size;
> + =A0 =A0 =A0 unsigned long orig_iova =3D iova;
> + =A0 =A0 =A0 int ret =3D 0, orig_size =3D size;
>
> =A0 =A0 =A0 =A0if (unlikely(domain->ops->map =3D=3D NULL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> - =A0 =A0 =A0 size =A0 =A0 =A0 =A0 =3D PAGE_SIZE << gfp_order;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* both the virtual address and the physical one, as well=
 as
> + =A0 =A0 =A0 =A0* the size of the mapping, must be aligned (at least) to=
 the
> + =A0 =A0 =A0 =A0* size of the smallest page supported by the hardware
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!IS_ALIGNED(iova | paddr | size, domain->ops->min_pages=
z)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("unaligned: iova 0x%lx pa 0x%lx size=
 0x%x min_pagesz "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "0x%x\n", iova, (unsigned l=
ong)paddr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size, domain->ops->min_page=
sz);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pr_debug("map: iova 0x%lx pa 0x%lx size 0x%x\n", iova,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned l=
ong)paddr, size);
> +
> + =A0 =A0 =A0 while (size) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long pgsize, addr_merge =3D iova |=
 paddr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int pgsize_idx;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Max page size that still fits into 'size=
' */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgsize_idx =3D __fls(size);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to consider alignment requirements =
? */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (likely(addr_merge)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Max page size allowed by=
 both iova and paddr */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int align_pgsize_i=
dx =3D __ffs(addr_merge);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgsize_idx =3D min(pgsize_i=
dx, align_pgsize_idx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* build a mask of acceptable page sizes */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgsize =3D (1UL << (pgsize_idx + 1)) - 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* throw away page sizes not supported by t=
he hardware */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgsize &=3D domain->ops->pgsize_bitmap;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* make sure we're still sane */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(!pgsize);
>
> - =A0 =A0 =A0 BUG_ON(!IS_ALIGNED(iova | paddr, size));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* pick the biggest page */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgsize_idx =3D __fls(pgsize);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgsize =3D 1UL << pgsize_idx;
>
> - =A0 =A0 =A0 return domain->ops->map(domain, iova, paddr, gfp_order, pro=
t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* convert index to page order */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgsize_idx -=3D PAGE_SHIFT;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("mapping: iova 0x%lx pa 0x%lx orde=
r %u\n", iova,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (unsigned long)paddr, pgsize_idx);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D domain->ops->map(domain, iova, padd=
r, pgsize_idx, prot);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iova +=3D pgsize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 paddr +=3D pgsize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size -=3D pgsize;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* unroll mapping in case something went wrong */
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iommu_unmap(domain, orig_iova, orig_size);
> +
domain->ops->map() might return error because a mapping already exists
in the range from iova until iova + size.
Thus, it should be
iommu_unmap(domain, orig_iova, orig_size - size)

Regards,

KyongHo
