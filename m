From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/6] OMAP: iommu: hwmod, reset handling and runtime
 PM
Date: Tue, 16 Oct 2012 10:22:59 -0700
Message-ID: <20121016172258.GT15569@atomide.com>
References: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:37060 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755187Ab2JPRXI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 13:23:08 -0400
Content-Disposition: inline
In-Reply-To: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Joerg Roedel <joerg.roedel@amd.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org

* Omar Ramirez Luna <omar.luna@linaro.org> [121011 18:07]:
> These patches are needed for remoteproc to work on OMAP4.
> 
> Introduced iommu hwmod support for OMAP3 (iva, isp) and
> OMAP4 (ipu, dsp), along with the corresponding runtime PM
> and routines to deassert reset lines, enable/disable clocks
> and configure sysc registers.
> 
> Although IOMMU hwmod patches were already submitted in the past,
> this series adds few more changes, like:
> - New reset handling.
> - Save and restore context code rework.
> - Device tree bindings for OMAP3 and OMAP4.
> 
> For this series I just dropped the patches already included in
> mainline.

These will need to be rebased on omap-for-v3.8/cleanup-headers-iommu
when I have that pushed out as that removes plat/*iommu*.h files.

Regards,

Tony
 
> Previous work can be found at:
> [v2]
>   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg75701.html
> [v1]
>   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70447.html
> 
> [old iteration without reset, save/restore and device tree]
>   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg60133.html
> 
> Omar Ramirez Luna (6):
>   ARM: OMAP3/4: iommu: migrate to hwmod framework
>   ARM: OMAP3/4: iommu: adapt to runtime pm
>   ARM: OMAP: iommu: pm runtime save and restore context
>   ARM: OMAP: iommu: optimize save and restore routines
>   ARM: OMAP: iommu: add device tree support
>   arm/dts: OMAP3/4: Add iommu nodes
> 
>  .../devicetree/bindings/arm/omap/iommu.txt         |   10 ++
>  arch/arm/boot/dts/omap3.dtsi                       |   12 +-
>  arch/arm/boot/dts/omap4.dtsi                       |   17 +-
>  arch/arm/mach-omap2/devices.c                      |    2 +-
>  arch/arm/mach-omap2/iommu2.c                       |   74 ++------
>  arch/arm/mach-omap2/omap-iommu.c                   |  176 +++++---------------
>  arch/arm/plat-omap/include/plat/iommu.h            |   20 ++-
>  arch/arm/plat-omap/include/plat/iommu2.h           |    4 -
>  drivers/iommu/omap-iommu.c                         |  163 ++++++++++++++----
>  9 files changed, 245 insertions(+), 233 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/iommu.txt
> 
> -- 
> 1.7.9.5
> 
