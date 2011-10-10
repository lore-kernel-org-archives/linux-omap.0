From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
	supported by the hardware
Date: Mon, 10 Oct 2011 17:36:09 +0200
Message-ID: <20111010153609.GB2138@amd.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAK=WgbZ7Wyax1yfS1jSXw9OdwMtxxidwLO8PTsNUXX9CWzmVrw@mail.gmail.com>
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Hiroshi Doyu <hdoyu@nvidia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stepan Moskovchenko <stepanm@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

On Mon, Oct 10, 2011 at 09:59:22AM -0400, Ohad Ben-Cohen wrote:
> > Also, the bus_set_iommu interface is now in the -next branch. Would be
> > good if you rebase the patches to that interface.
> 
> Sure. It's a little tricky though: which branch do I base this on ?
> Are you ok with me basing this on your 'next' branch ? My current
> stack depends at least on three branches of yours, so that would be
> helpful for me (and less merging conflicts for you I guess :).

The master branch is best to base your patches on for generic work. For
more specific things like omap-only changes you can use the topic
branches.

> > I think we need some care here and check pgsize for 0. A BUG_ON should
> > do.
> 
> I can add it if you prefer, but I don't think it can really happen:
> basically, it means that we chose a too small and unsupported page
> bit, which can't happen as long as we check for IS_ALIGNED(iova |
> paddr | size, iommu_min_pagesz) in the beginning of iommu_map.

It can happen when there is a bug somewhere :) So a BUG_ON will yell
then and makes debugging easier. An alternative is to use a WARN_ON and
let the map-call fail in this case.

> Ok, let's discuss the semantics of ->unmap().
> 
> There isn't a clear documentation of that API (we should probably add
> some kernel docs after we nail it down now), but judging from the
> existing users (mainly kvm) and drivers, it seems that iommu_map() and
> iommu_unmap() aren't symmetric: users rely on unmap() to return the
> actual size that was unmapped. IOMMU drivers, in turn, should check
> which page is mapped on 'iova', unmap it, and return its size.

Right, currently the map/unmap calls are not symetric. But I think they
should be to get a clean semantic. Without this requirement and multiple
page-sizes in use the iommu-code may has to unmap more address space then
requested. The user doesn't know what will be unmapped so it has to make
sure that no DMA is happening while unmap runs.

When we require the calls to be symetric we can give a guarantee that
only the requested region is unmapped and allow DMA to the untouched
part of the address-space while unmap() is running.

So when the call-places to not follow this restriction we should convert
them mid-term.

> This way iommu_unmap() becomes very simple: it just iterates through
> the region, relying on iommu_ops->unmap() to return the sizes that
> were actually unmapped (very similar to how amd's iommu_unmap_page
> works today). This also means that iommu_ops->unmap() doesn't really
> need a size/order argument and we can remove it (after all drivers
> fully migrate..).

Yes, somthing like that. Probably the iommu_ops->unmap function should
be turned into a unmap_page function call which only takes an iova and
no size parameter. The iommu-driver unmaps the page pointing to that
iova and returns the size of the page unmapped. This still allows the
simple implementation for the unmap-call.

This change is no requirement for this patch-set, but if we agree on it
this patch-set should keep that direction in mind.

> The other approach which you suggest means symmetric iommu_map() and
> iommu_unmap(). It means adding a 'paddr' parameter to iommu_unmap(),
> which is easy, but maybe more concerning is the limitation that it
> incurs: users will now have to call iommu_unmap() exactly as they
> called iommu_map() beforehand. Note sure how well this will fly with
> the existing users (kvm ?) and whether we really want to enforce this
> (it doesn't mean drivers need to deal with page-size complexity. they
> are required to unmap a single page at a time, and iommu_unmap() will
> do the work for them).

It will work with KVM, that is no problem. We don't need to really
enforce the calls to be symetric. But we can define that we only give
the guarantee about what will be unmapped when the calls are symetric.
For example:

	iommu_map(  0, 0x100000);
	iommu_unmap(0, 0x100000); /* Guarantee that it will only unmap
				     the range 0-0x100000 */

whereas:

	iommu_map(  0, 0x100000);
	iommu_unmap(0,   0x1000); /* Guarantees that 0-0x1000 is
				     unmapped, but other undefined parts
				     of the address space may be
				     unmapped too, up to the whole
				     address space */

The alternative is that we implement page-splitting in the iommu_unmap
function. But that introduces complexity I am not sure we really need.
KVM for example just unmaps the whole address-space on destruction. For
the generic dma_ops this is also not required because the dma_map*
functions already have the requirement to be symetric.

> 
> Another discussion:
> 
> I think we better change iommu_ops->map() to directly take a 'size'
> (in bytes) instead of an 'order' (of pages). Most (all?) drivers just
> immediately do 'size = 0x1000UL << gfp_order', so this whole size ->
> order -> size back and forth seems redundant.

Yes, this get_order thing should be changes to size long-term.

Regards,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
