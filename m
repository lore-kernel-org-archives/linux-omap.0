From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/2] OMAP3 IOMMU fixes
Date: Wed, 8 Jun 2011 12:48:01 +0200
Message-ID: <201106081248.01793.laurent.pinchart@ideasonboard.com>
References: <1306759629-17232-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:56777 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413Ab1FHKsD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jun 2011 06:48:03 -0400
In-Reply-To: <1306759629-17232-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, teemu.tuominen@cybercom.com

Hi Tony,

On Monday 30 May 2011 14:47:07 Laurent Pinchart wrote:
> Hi everybody,
> 
> Here are two OMAP3 IOMMU fixes required to support big and/or unaligned
> memory buffers.
> 
> Laurent Pinchart (2):
>   omap3: iovmm: Work around sg_alloc_table size limitation in IOMMU
>   omap3: iovmm: Support non page-aligned buffers in iommu_vmap

As per Russell comments, the first patch needs more work (or at least more 
discussions). Could you apply the second patch already ?

-- 
Regards,

Laurent Pinchart
