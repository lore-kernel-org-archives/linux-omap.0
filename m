From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 0/2] OMAP3 IOMMU fixes
Date: Mon, 30 May 2011 16:16:03 +0300 (EEST)
Message-ID: <20110530.161603.33358104447681739.Hiroshi.DOYU@nokia.com>
References: <1306759629-17232-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:39045 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753490Ab1E3NQH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 09:16:07 -0400
In-Reply-To: <1306759629-17232-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: laurent.pinchart@ideasonboard.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, teemu.tuominen@cybercom.com

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 0/2] OMAP3 IOMMU fixes
Date: Mon, 30 May 2011 14:47:07 +0200

> Hi everybody,
> 
> Here are two OMAP3 IOMMU fixes required to support big and/or unaligned memory
> buffers.
> 
> Laurent Pinchart (2):
>   omap3: iovmm: Work around sg_alloc_table size limitation in IOMMU
>   omap3: iovmm: Support non page-aligned buffers in iommu_vmap

Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

> 
>  arch/arm/plat-omap/iovmm.c |   46 ++++++++++++++++++++++++++++++++++---------
>  1 files changed, 36 insertions(+), 10 deletions(-)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
