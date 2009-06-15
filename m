From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] adding back some features
Date: Mon, 15 Jun 2009 01:00:02 -0700
Message-ID: <20090615080001.GC4474@atomide.com>
References: <1244844693-24126-1-git-send-email-khilman@ti.deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52498 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbZFOIAC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 04:00:02 -0400
Content-Disposition: inline
In-Reply-To: <1244844693-24126-1-git-send-email-khilman@ti.deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.deeprootsystems.com>

Hi,

* Kevin Hilman <khilman@deeprootsystems.com> [090612 15:13]:
> Here's a couple patches to add-back some feature dropped in the
> mainline sync.  These are needed for the PM branch among other things.
> 
> Applies to linux-omap master.
> 
> Kevin
> 
> Kalle Jokiniemi (1): OMAP3: DMA: Enable idlemodes for DMA OCP

This we could justify getting into mainline as a fix, as otherwise
some PM features won't work. Will add into omap-fixes.
 
> Kevin Hilman (1):
>   OMAP2/3: SoC IDs: add omap_type() for determining GP/EMU/HS

Is there any reason to get this one into mainline early?

If not, I suggest you keep this in your pm branch for next merge
window that I can keep merging to l-o master as needed.

However, if omap_type() is by other queues earlier, then I can
add it into my upstream queue. If this blocks several queues
from being rebased against mainline kernel, that alone might
already be a good enough reason to get it in early.

Regards,

Tony

 
>  arch/arm/mach-omap2/id.c              |   22 ++++++++++++++++++++++
>  arch/arm/plat-omap/dma.c              |   13 +++++++++++++
>  arch/arm/plat-omap/include/mach/dma.h |   15 +++++++++++++++
>  3 files changed, 50 insertions(+), 0 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
