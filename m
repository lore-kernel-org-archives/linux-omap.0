From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v4 0/7] iommu: split mapping to page sizes as supported by
 the hardware
Date: Tue, 8 Nov 2011 14:57:02 +0200
Message-ID: <CAK=Wgbb5K+rqPNdM2sC8z+9d4-hdcPwV-vXk6gcAYWaO+dVx3w@mail.gmail.com>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318850846-16066-1-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, Joerg Roedel <Joerg.Roedel@amd.com>
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, Stepan Moskovchenko <stepanm@codeaurora.org>, KyongHo Cho <pullip.cho@samsung.com>
List-Id: linux-omap@vger.kernel.org

Joerg, gentle reminder. thanks.

On Mon, Oct 17, 2011 at 1:27 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> v3->v4:
> - simplify splitter logic (Joerg)
> - declare supported page-sizes in the iommu_ops, without extending io=
mmu_register (Joerg)
> - iommu_unmap should now return bytes too (Joerg)
> - don't cache min_pgsize anymore (Joerg)
> - handle cases when ->unmap() actually unmaps more than requested (Jo=
erg)
> - unroll iommu_unmap completely in case it fails (KyongHo)
> - use size_t for size parameters (KyongHo)
> - add a patch to remove the bytes->order->bytes conversion we had
> - rabase to master branch of the iommu tree (Joerg)
>
> v2->v3:
> - s/KB/KiB/ (David W)
>
> v1->v2:
> - split to patches (by keeping the old code around until all drivers =
are converted) (Joerg)
>
> Tested with OMAP3 (omap3isp) and OMAP4 (rpmsg/remoteproc).
> Compile tested with X86_64.
>
> Ohad Ben-Cohen (7):
> =A0iommu/core: stop converting bytes to page order back and forth
> =A0iommu/core: split mapping to page sizes as supported by the hardwa=
re
> =A0iommu/omap: announce supported page sizes
> =A0iommu/msm: announce supported page sizes
> =A0iommu/amd: announce supported page sizes
> =A0iommu/intel: announce supported page sizes
> =A0iommu/core: remove the temporary pgsize settings
>
> =A0drivers/iommu/amd_iommu.c =A0 | =A0 32 +++++++++---
> =A0drivers/iommu/intel-iommu.c | =A0 30 ++++++++---
> =A0drivers/iommu/iommu.c =A0 =A0 =A0 | =A0119 +++++++++++++++++++++++=
+++++++++++++++----
> =A0drivers/iommu/msm_iommu.c =A0 | =A0 25 ++++-----
> =A0drivers/iommu/omap-iommu.c =A0| =A0 18 +++---
> =A0drivers/iommu/omap-iovmm.c =A0| =A0 17 ++----
> =A0include/linux/iommu.h =A0 =A0 =A0 | =A0 26 +++++++--
> =A0virt/kvm/iommu.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08 ++--
> =A08 files changed, 205 insertions(+), 70 deletions(-)
>
> --
> 1.7.4.1
>
>
