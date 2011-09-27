From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
 supported by the hardware
Date: Tue, 27 Sep 2011 20:14:38 +0200
Message-ID: <20110927181438.GM2138@amd.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
 <1316195506-9777-2-git-send-email-ohad@wizery.com>
 <20110927100505.GH2138@amd.com>
 <CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
 <20110927131222.GL2138@amd.com>
 <CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stepan Moskovchenko <stepanm@codeaurora.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 27, 2011 at 09:28:37AM -0400, Ohad Ben-Cohen wrote:
> So you're suggesting to re-implement find_next_bit() using ffs()/fls()
> and shifting ?

No. I suggest a simpler and shorter algorithm using the bit helpers.
Something like that:

        min_idx = __ffs(iommu_page_sizes);

        while (size) {
                /* Max alignment allowed by current physical address */
                phys_idx = __ffs(phys);

                /* Max alignment allowed by current size */
                size_idx = __fls(size);

                /* special case: iova == 0 */
                if (likely(phys))
                        idx = min(phys_idx, size_idx);
                else
                        idx = size_idx;

                BUG_ON(idx < min_idx);

                psize = 1UL << idx;

                /* search next smaller page-size supported */
                while (psize && !(iommu_page_sizes & psize))
                        psize >>= 1;

                BUG_ON(psize == 0);

		iommu_ops->map(domain, iova, phys, get_order(psize), prot);

                iova += psize;
		phys += psize;
                size -= psize;
        }

It is only C-style pseudo-code, of course. These __ffs and __fls lines
all translate to a single instruction later. The find_next_bit()
function has a lot more overhead because it needs to take account of
real bitmaps (arrays of ulong). But this complexity is not required
here.

And yes, overhead is important when we implement the generic dma-ops
on-top of the iommu-api because this will make the iommu_map function a
fast-path. So we really care about overhead here.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
