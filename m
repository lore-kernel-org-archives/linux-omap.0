From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/7] omap: iommu migration, relocation and cleanups
Date: Thu, 25 Aug 2011 19:03:48 +0300
Message-ID: <20110825160348.GZ4996@atomide.com>
References: <1314205694-28935-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:12814 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751086Ab1HYQDy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Aug 2011 12:03:54 -0400
Content-Disposition: inline
In-Reply-To: <1314205694-28935-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org

* Ohad Ben-Cohen <ohad@wizery.com> [110824 19:36]:
> 1. Migrate OMAP's iommu driver to the generic IOMMU API, and move it
> to the dedicated iommu folder.
> 
> 2. Fix omap3isp appropriately so it doesn't break.
> 
> 3. Adapt OMAP's iovmm appropriately as well, because omap3isp still relies
> on it. The plan is eventually to remove iovmm and replace it with the
> upcoming IOMMU-based generic DMA-API. Move iovmm to the iommu folder too;
> it belongs there more than it belongs in the OMAP folders.
> 
> 4. Start cleaning up OMAP's iommu components towards the end goal, where
>     1) omap-iommu no longer exports public API (and instead provides its
>        entire functionality via the generic IOMMU API).
>     2) omap-iovmm is removed.
> 
> Tested on OMAP3 (with omap3isp) and OMAP4 (with rpmsg/remoteproc).

Glad to see this, thanks for doing this! For all the patches:

Acked-by: Tony Lindgren <tony@atomide.com>
