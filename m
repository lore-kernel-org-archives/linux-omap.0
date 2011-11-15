From: Joerg Roedel <Joerg.Roedel@amd.com>
Subject: Re: [PATCH v4-rebased 0/7] iommu: split mapping to page sizes as
 supported by the hardware
Date: Tue, 15 Nov 2011 16:49:54 +0100
Message-ID: <20111115154954.GD5627@amd.com>
References: <1320917551-11328-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:59645
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756434Ab1KOPuK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Nov 2011 10:50:10 -0500
Content-Disposition: inline
In-Reply-To: <1320917551-11328-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, Stepan Moskovchenko <stepanm@codeaurora.org>, KyongHo Cho <pullip.cho@samsung.com>

On Thu, Nov 10, 2011 at 11:32:24AM +0200, Ohad Ben-Cohen wrote:
> Ohad Ben-Cohen (7):
>   iommu/core: stop converting bytes to page order back and forth
>   iommu/core: split mapping to page sizes as supported by the hardware
>   iommu/omap: announce supported page sizes
>   iommu/msm: announce supported page sizes
>   iommu/amd: announce supported page sizes
>   iommu/intel: announce supported page sizes
>   iommu/core: remove the temporary pgsize settings
> 
>  drivers/iommu/amd_iommu.c   |   32 +++++++++---
>  drivers/iommu/intel-iommu.c |   30 ++++++++---
>  drivers/iommu/iommu.c       |  119 ++++++++++++++++++++++++++++++++++++++----
>  drivers/iommu/msm_iommu.c   |   25 ++++-----
>  drivers/iommu/omap-iommu.c  |   18 +++---
>  drivers/iommu/omap-iovmm.c  |   17 ++----
>  include/linux/iommu.h       |   26 +++++++--
>  virt/kvm/iommu.c            |    8 ++--
>  8 files changed, 205 insertions(+), 70 deletions(-)

Applied, thanks.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

