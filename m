From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 2/2] omap: rx51: mark reserved memory earlier
Date: Fri, 12 Nov 2010 15:28:12 +0200
Message-ID: <1289568492.3297.277.camel@tubuntu>
References: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
	 <1287146784-5517-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:23875 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757317Ab0KLN3G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Nov 2010 08:29:06 -0500
In-Reply-To: <1287146784-5517-2-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, "mike@compulab.co.il" <mike@compulab.co.il>, Russell King <linux@arm.linux.org.uk>

Hi,

On Fri, 2010-10-15 at 14:46 +0200, ext Felipe Contreras wrote:
> So that omap_vram_set_sdram_vram() is called before
> omap_vram_reserve_sdram_memblock().

Is this still valid after the latest memblock stuff? I presume it is.
I'm not able to test this, and you said you didn't test it, so I'm a bit
uneasy about applying =).

 Tomi


> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/mach-omap2/board-rx51.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
> index a58e8cb..861079b 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -144,17 +144,22 @@ static void __init rx51_init(void)
>  static void __init rx51_map_io(void)
>  {
>  	omap2_set_globals_3xxx();
> -	rx51_video_mem_init();
>  	omap34xx_map_common_io();
>  }
>  
> +static void __init rx51_reserve(void)
> +{
> +	rx51_video_mem_init();
> +	omap_reserve();
> +}
> +
>  MACHINE_START(NOKIA_RX51, "Nokia RX-51 board")
>  	/* Maintainer: Lauri Leukkunen <lauri.leukkunen@nokia.com> */
>  	.phys_io	= 0x48000000,
>  	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
>  	.boot_params	= 0x80000100,
>  	.map_io		= rx51_map_io,
> -	.reserve	= omap_reserve,
> +	.reserve	= rx51_reserve,
>  	.init_irq	= rx51_init_irq,
>  	.init_machine	= rx51_init,
>  	.timer		= &omap_timer,


