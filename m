From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
 supported by the hardware
Date: Tue, 27 Sep 2011 15:26:29 +0300
Message-ID: <CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
 <1316195506-9777-2-git-send-email-ohad@wizery.com> <20110927100505.GH2138@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20110927100505.GH2138@amd.com>
Sender: kvm-owner@vger.kernel.org
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stepan Moskovchenko <stepanm@codeaurora.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 27, 2011 at 1:05 PM, Roedel, Joerg <Joerg.Roedel@amd.com> w=
rote:
> On Fri, Sep 16, 2011 at 01:51:41PM -0400, Ohad Ben-Cohen wrote:
>> =A0int iommu_map(struct iommu_domain *domain, unsigned long iova,
>> - =A0 =A0 =A0 =A0 =A0 =A0 phys_addr_t paddr, int gfp_order, int prot=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 phys_addr_t paddr, size_t size, int prot)
>> =A0{
>> - =A0 =A0 =A0 size_t size;
>> + =A0 =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* both the virtual address and the physical one, as=
 well as
>> + =A0 =A0 =A0 =A0* the size of the mapping, must be aligned (at leas=
t) to the
>> + =A0 =A0 =A0 =A0* size of the smallest page supported by the hardwa=
re
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (!IS_ALIGNED(iova | paddr | size, iommu_min_pagesz)=
) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("unaligned: iova 0x%lx pa 0x%lx=
 size 0x%lx min_pagesz "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "0x%x\n", iova, (unsig=
ned long)paddr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)size, i=
ommu_min_pagesz);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 pr_debug("map: iova 0x%lx pa 0x%lx size 0x%lx\n", iova=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsig=
ned long)paddr, (unsigned long)size);
>> +
>> + =A0 =A0 =A0 while (size) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long pgsize =3D iommu_min_pag=
esz;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long idx =3D iommu_min_page_i=
dx;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long addr_merge =3D iova | pa=
ddr;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int order;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* find the max page size with which i=
ova, paddr are aligned */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (;;) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long try_pgsi=
ze;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx =3D find_next_bit(=
iommu_pgsize_bitmap,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 iommu_nr_page_bits, idx + 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* no more pages to ch=
eck ? */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (idx >=3D iommu_nr_=
page_bits)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_pgsize =3D 1 << id=
x;
>>
>> - =A0 =A0 =A0 size =A0 =A0 =A0 =A0 =3D 0x1000UL << gfp_order;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* page too big ? addr=
esses not aligned ? */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (size < try_pgsize =
||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 !IS_ALIGNED(addr_merge, try_pgsize))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> - =A0 =A0 =A0 BUG_ON(!IS_ALIGNED(iova | paddr, size));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgsize =3D try_pgsize;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> With an unsigned long you can use plain and fast bit_ops instead of t=
he
> full bitmap functions.

Not sure I follow; the only bit operation I'm using while mapping is
find_next_bit() (which is a bitops.h method).

What other faster variant are you referring to ?

Thanks,
Ohad.
