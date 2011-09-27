From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 0/6] iommu: split mapping to page sizes as supported by
 the hardware
Date: Tue, 27 Sep 2011 11:56:13 +0300
Message-ID: <CAK=WgbYkG7s+aLW2icm0iHbiX1YRSZ1JSr=jPDv=3Dd+Fg1wgg@mail.gmail.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316195506-9777-1-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, Joerg Roedel <Joerg.Roedel@amd.com>
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>
List-Id: linux-omap@vger.kernel.org

ping

On Fri, Sep 16, 2011 at 8:51 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> v2->v3:
>
> - s/KB/KiB/ (David W)
>
> v1->v2:
>
> - split to patches (by keeping the old code around until all drivers =
are converted) (Joerg)
>
>
> Ohad Ben-Cohen (6):
> =A0iommu/core: split mapping to page sizes as supported by the hardwa=
re
> =A0iommu/omap: announce supported page sizes
> =A0iommu/msm: announce supported page sizes
> =A0iommu/amd: announce supported page sizes
> =A0iommu/intel: announce supported page sizes
> =A0iommu/core: remove the temporary register_iommu_pgsize API
>
> =A0drivers/iommu/amd_iommu.c =A0 | =A0 20 ++++++-
> =A0drivers/iommu/intel-iommu.c | =A0 20 ++++++-
> =A0drivers/iommu/iommu.c =A0 =A0 =A0 | =A0130 +++++++++++++++++++++++=
++++++++++++++++----
> =A0drivers/iommu/msm_iommu.c =A0 | =A0 =A08 ++-
> =A0drivers/iommu/omap-iommu.c =A0| =A0 =A06 ++-
> =A0drivers/iommu/omap-iovmm.c =A0| =A0 12 +---
> =A0include/linux/iommu.h =A0 =A0 =A0 | =A0 =A07 +-
> =A0virt/kvm/iommu.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +-
> =A08 files changed, 177 insertions(+), 30 deletions(-)
>
> --
> 1.7.4.1
>
>
