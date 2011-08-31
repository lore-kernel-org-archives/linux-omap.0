From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in iommu_vmap
Date: Wed, 31 Aug 2011 13:52:08 +0300
Message-ID: <CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35670 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab1HaKw3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Aug 2011 06:52:29 -0400
Received: by wwf5 with SMTP id 5so608842wwf.1
        for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 03:52:28 -0700 (PDT)
In-Reply-To: <1314646569-16738-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org

On Mon, Aug 29, 2011 at 10:36 PM, Ohad Ben-Cohen <ohad@wizery.com> wrot=
e:
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> omap_iovmm requires page-aligned buffers, and that sometimes causes
> omap3isp failures (i.e. whenever the buffer passed from userspace is =
not
> page-aligned).
>
> Remove this limitation by rounding the address of the first page entr=
y
> down, and adding the offset back to the device address.

I'm having second thoughts about this.

Obviously it works for omap3isp and its users because the buffer gets
mapped and everyone is happy.

But I'm not sure this is a valid IOMMU interface that the kernel
should have, because effectively we're now mapping physical memory
which nobody asked us to, and which might contain sensitive stuff we
don't want to give the device (e.g. a remote processor which might be
running rogue code) access to.

Thoughts ?

>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> [ohad@wizery.com: slightly edited the commit log]
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
> A fix by Laurent that was waiting until omap's iommu lands in drivers=
/.
>
> Generally we're not extending omap-iovmm anymore, but this fixes a re=
al
> breakage for omap3isp users, so there's no point in delaying it until
> the generic DMA API is ready and we've migrated.
>
> Thanks Laurent!
>
> =A0drivers/iommu/omap-iovmm.c | =A0 32 ++++++++++++++++++++++++------=
--
> =A01 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
> index 5e7f97d..d28a256 100644
> --- a/drivers/iommu/omap-iovmm.c
> +++ b/drivers/iommu/omap-iovmm.c
> @@ -27,6 +27,15 @@
>
> =A0static struct kmem_cache *iovm_area_cachep;
>
> +/* return the offset of the first scatterlist entry in a sg table */
> +static unsigned int sgtable_offset(const struct sg_table *sgt)
> +{
> + =A0 =A0 =A0 if (!sgt || !sgt->nents)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 return sgt->sgl->offset;
> +}
> +
> =A0/* return total bytes of sg buffers */
> =A0static size_t sgtable_len(const struct sg_table *sgt)
> =A0{
> @@ -39,11 +48,17 @@ static size_t sgtable_len(const struct sg_table *=
sgt)
> =A0 =A0 =A0 =A0for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t bytes;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes =3D sg->length;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes =3D sg->length + sg->offset;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!iopgsz_ok(bytes)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: sg[%d] not =
iommu pagesize(%x)\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__=
, i, bytes);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: sg[%d] not =
iommu pagesize(%u %u)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__=
, i, bytes, sg->offset);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i && sg->offset) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: sg[%d] offs=
et not allowed in internal "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "entries\n", __func__, i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> @@ -164,8 +179,8 @@ static void *vmap_sg(const struct sg_table *sgt)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 pa;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int err;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pa =3D sg_phys(sg);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes =3D sg->length;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pa =3D sg_phys(sg) - sg->offset;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes =3D sg->length + sg->offset;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BUG_ON(bytes !=3D PAGE_SIZE);
>
> @@ -405,8 +420,8 @@ static int map_iovm_area(struct iommu_domain *dom=
ain, struct iovm_struct *new,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 pa;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t bytes;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pa =3D sg_phys(sg);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes =3D sg->length;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pa =3D sg_phys(sg) - sg->offset;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes =3D sg->length + sg->offset;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flags &=3D ~IOVMF_PGSZ_MASK;
>
> @@ -600,7 +615,7 @@ u32 omap_iommu_vmap(struct iommu_domain *domain, =
struct omap_iommu *obj, u32 da,
> =A0 =A0 =A0 =A0if (IS_ERR_VALUE(da))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vunmap_sg(va);
>
> - =A0 =A0 =A0 return da;
> + =A0 =A0 =A0 return da + sgtable_offset(sgt);
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_iommu_vmap);
>
> @@ -620,6 +635,7 @@ omap_iommu_vunmap(struct iommu_domain *domain, st=
ruct omap_iommu *obj, u32 da)
> =A0 =A0 =A0 =A0 * 'sgt' is allocated before 'omap_iommu_vmalloc()' is=
 called.
> =A0 =A0 =A0 =A0 * Just returns 'sgt' to the caller to free
> =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 da &=3D PAGE_MASK;
> =A0 =A0 =A0 =A0sgt =3D unmap_vm_area(domain, obj, da, vunmap_sg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0IOVMF_DISCONT | IOVMF_MMIO);
> =A0 =A0 =A0 =A0if (!sgt)
> --
> 1.7.4.1
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
