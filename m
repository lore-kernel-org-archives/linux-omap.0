From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 broken with 36-rc1
Date: Wed, 25 Aug 2010 11:09:28 +0300
Message-ID: <1282723768.9299.90.camel@tubuntu.research.nokia.com>
References: <1281962906.1888.25.camel@chotu>
	 <4C72192A.9050801@compulab.co.il>
	 <1282547709.2202.1.camel@tubuntu.research.nokia.com>
	 <4C722115.50401@compulab.co.il>
	 <1282548930.2202.16.camel@tubuntu.research.nokia.com>
	 <4C7236A2.7080701@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:37654 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab0HYIJy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 04:09:54 -0400
In-Reply-To: <4C7236A2.7080701@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mike Rapoport <mike@compulab.co.il>
Cc: "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, 2010-08-23 at 10:51 +0200, ext Mike Rapoport wrote:
> Tomi Valkeinen wrote:
> > On Mon, 2010-08-23 at 09:19 +0200, ext Mike Rapoport wrote:
> >> Tomi Valkeinen wrote:
> >>> I tested 36-rc1 briefly with OMAP 3430SDP board. I wonder why that
> >>> works, but not N900...
> >> May it be that 3430SDP uses SRAM for the framebuffer? Or reserves framebuffer 
> >> memory from the RAM that is not managed by the kernel, e.g with something like
> >> mem=<RAM size - fb size> vram=<fb size>,0x8...... ?
> > 
> > No, SRAM cannot be used on OMAP3s, as SRAM is too small to hold a
> > framebuffer. And no, I don't think it's reserving it from RAM not
> > managed by the kernel.
> 
> The N900 only sets omap_vram_sdram_{start,size} in rx51_video_mem_init.
> I think that it should also call omap_vram_reserve_sdram_memblock():
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
> index 5a1005b..fdfe844 100644
> --- a/arch/arm/mach-omap2/board-rx51-video.c
> +++ b/arch/arm/mach-omap2/board-rx51-video.c
> @@ -101,6 +101,7 @@ void __init rx51_video_mem_init(void)
>           */
>          omap_vram_set_sdram_vram(PAGE_ALIGN(864 * 480 * 4) +
>                          2 * PAGE_ALIGN(1280 * 720 * 4 * 2), 0);
> +       omap_vram_reserve_sdram_memblock();
>   }

But omap_vram_reserve_sdram_memblock() is called automatically from
arch/arm/plat-omap/common.c. rx51_video_mem_init() should have been
called before that happens. Has the call order changed, so that
omap_vram_reserve_sdram_memblock() is called first, and
rx51_video_mem_init() only after that?

 Tomi


