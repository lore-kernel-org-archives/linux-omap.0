From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] iommu/omap: Fix build error with !IOMMU_SUPPORT
Date: Wed, 14 Sep 2011 21:57:13 +0300
Message-ID: <CAK=WgbbCgXjOQ=xXSwnVhT9sqsYtpo6cFcRQYSEGY2ow215n=Q@mail.gmail.com>
References: <1316009259-18052-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43191 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269Ab1INS5e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 14:57:34 -0400
In-Reply-To: <1316009259-18052-1-git-send-email-joerg.roedel@amd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On Wed, Sep 14, 2011 at 5:07 PM, Joerg Roedel <joerg.roedel@amd.com> wrote:
> Without this patch it is possible to select the VIDEO_OMAP3
> driver which then selects OMAP_IOVMM. But the omap iommu
> driver is not compiled without IOMMU_SUPPORT enabled. Fix
> that by forcing OMAP_IOMMU and OMAP_IOVMM are enabled before
> VIDEO_OMAP3 can be selected.

I'm ok with this but wouldn't it be simpler if we drop IOMMU_SUPPORT
altogether (and just use a plain menu instead) ?

Users will then be presented with only a single iommu-related
question: whether they want their iommu driver built or not.

Something like this:

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d901930..7d6e5ad 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -2,16 +2,7 @@
 config IOMMU_API
        bool

-menuconfig IOMMU_SUPPORT
-       bool "IOMMU Hardware Support"
-       default y
-       ---help---
-         Say Y here if you want to compile device drivers for IO Memory
-         Management Units into the kernel. These devices usually allow to
-         remap DMA requests and/or remap interrupts from other devices on the
-         system.
-
-if IOMMU_SUPPORT
+menu "IOMMU Hardware Support"

 # MSM IOMMU support
 config MSM_IOMMU
@@ -126,4 +117,4 @@ config OMAP_IOMMU_DEBUG

          Say N unless you know you need this.

-endif # IOMMU_SUPPORT
+endmenu
