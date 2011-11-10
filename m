From: Kai Huang <mail.kai.huang@gmail.com>
Subject: Re: [PATCH v4 2/7] iommu/core: split mapping to page sizes as
 supported by the hardware
Date: Thu, 10 Nov 2011 14:17:24 +0800
Message-ID: <CANqQZNH1YRSgYRVxceicQ3szD=t7zeJjhJKEQ30PeKsxtj5V+A@mail.gmail.com>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com>
	<1318850846-16066-3-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1318850846-16066-3-git-send-email-ohad@wizery.com>
Sender: kvm-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, Stepan Moskovchenko <stepanm@codeaurora.org>, KyongHo Cho <pullip.cho@samsung.com>, kvm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

>
> -int iommu_unmap(struct iommu_domain *domain, unsigned long iova, int=
 gfp_order)
> +size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, =
size_t size)
> =A0{
> - =A0 =A0 =A0 size_t size, unmapped;
> + =A0 =A0 =A0 size_t unmapped_page, unmapped =3D 0;
> + =A0 =A0 =A0 unsigned int min_pagesz;
>
> =A0 =A0 =A0 =A0if (unlikely(domain->ops->unmap =3D=3D NULL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> - =A0 =A0 =A0 size =A0 =A0 =A0 =A0 =3D PAGE_SIZE << gfp_order;
> -
> - =A0 =A0 =A0 BUG_ON(!IS_ALIGNED(iova, size));
> -
> - =A0 =A0 =A0 unmapped =3D domain->ops->unmap(domain, iova, size);
> -
> - =A0 =A0 =A0 return get_order(unmapped);
> + =A0 =A0 =A0 /* find out the minimum page size supported */
> + =A0 =A0 =A0 min_pagesz =3D 1 << __ffs(domain->ops->pgsize_bitmap);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* The virtual address, as well as the size of the ma=
pping, must be
> + =A0 =A0 =A0 =A0* aligned (at least) to the size of the smallest pag=
e supported
> + =A0 =A0 =A0 =A0* by the hardware
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!IS_ALIGNED(iova | size, min_pagesz)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("unaligned: iova 0x%lx size 0x%l=
x min_pagesz 0x%x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 iova, (unsigned long)size, min_pagesz);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pr_debug("unmap this: iova 0x%lx size 0x%lx\n", iova,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)size);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Keep iterating until we either unmap 'size' bytes =
(or more)
> + =A0 =A0 =A0 =A0* or we hit an area that isn't mapped.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 while (unmapped < size) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t left =3D size - unmapped;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unmapped_page =3D domain->ops->unmap(do=
main, iova, left);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!unmapped_page)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("unmapped: iova 0x%lx size %lx=
\n", iova,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (unsigned long)unmapped_page);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iova +=3D unmapped_page;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unmapped +=3D unmapped_page;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return unmapped;
> =A0}
> =A0EXPORT_SYMBOL_GPL(iommu_unmap);
>

Seems the unmap function don't take phys as parameter, does this mean
domain->ops->unmap will walk through the page table to find out the
actual page size?

And another question: have we considered the IOTLB flush operation? I
think we need to implement similar logic when flush the DVMA range.
Intel VT-d's manual says software needs to specify the appropriate
mask value to flush large pages, but it does not say we need to
exactly match the page size as it is mapped. I guess it's not
necessary for Intel IOMMU, but other vendor's IOMMU may have such
limitation (or some other limitations). In my understanding current
implementation does not provide page size information for particular
DVMA ranges that has been mapped, and it's not flexible to implement
IOTLB flush code (ex, we may need to walk through page table to find
out actual page size). Maybe we can also add iommu_ops->flush_iotlb ?

-cody
