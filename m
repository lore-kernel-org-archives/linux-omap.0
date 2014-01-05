From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
Date: Sun, 05 Jan 2014 16:16:54 +0200
Message-ID: <52C96956.7040803@gmail.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com> <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:50366 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaAEORT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Jan 2014 09:17:19 -0500
In-Reply-To: <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Ivaylo Dimitrov <freemangordon@abv.bg>, Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>


On 30.12.2013 15:19, Tomi Valkeinen wrote:
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
> ---
>   arch/arm/mach-omap2/common.c |  1 +
>   arch/arm/mach-omap2/common.h |  2 ++
>   arch/arm/mach-omap2/fb.c     | 77 +++++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 79 insertions(+), 1 deletion(-)
>

Tested on Nokia N900 with Maemo5 and linux 3.13-rc6
