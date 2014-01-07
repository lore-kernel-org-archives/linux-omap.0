From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
Date: Tue, 7 Jan 2014 15:59:51 -0800
Message-ID: <20140107235951.GH5074@atomide.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
 <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51683 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbaAHAAA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jan 2014 19:00:00 -0500
Content-Disposition: inline
In-Reply-To: <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ivaylo Dimitrov <freemangordon@abv.bg>, Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131230 05:21]:
> The omapfb driver uses dma_alloc to reserve memory for the framebuffers.
> However, on some use cases, even when CMA is in use, it's quite probable
> that omapfb fails to allocate the fb, either due to not enough free dma
> memory, fragmented dma memory, or CMA failing to make enough contiguous
> space.
> 
> This patch adds a kernel cmdline parameter 'omapfb_vram' which can be
> used to give the size of a memory area reserved exclusively for omapfb,
> and optionally a physical address where the memory area is reserved.
> 
> The memory area is reserved with memblock, and assigned to omapfb with
> dma_declare_coherent_memory. The dma_alloc function will first try to
> allocate the fb from the coherent memory area, and if that fails, it'll
> use the normal method of allocation.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Ivaylo Dimitrov <freemangordon@abv.bg>

Feel free to queue this along with the DSS patches:

Acked-by: Tony Lindgren <tony@atomide.com>
