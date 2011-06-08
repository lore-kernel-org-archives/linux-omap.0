From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] omap: iovmm: s/sg_dma_len(sg)/sg->length/
Date: Wed, 8 Jun 2011 18:03:23 +0200
Message-ID: <201106081803.24729.laurent.pinchart@ideasonboard.com>
References: <1307515436-20805-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:53312 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756396Ab1FHQDd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jun 2011 12:03:33 -0400
In-Reply-To: <1307515436-20805-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>

Hi Ohad,

Thanks for the patch.

On Wednesday 08 June 2011 08:43:55 Ohad Ben-Cohen wrote:
> iovmm is erroneously using sg_dma_len with unmapped (DMA API-wise)
> SG entries, and will break if CONFIG_NEED_SG_DMA_LENGTH is enabled.
> 
> Fix that by using sg->length instead.
> 
> Reported-by: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
