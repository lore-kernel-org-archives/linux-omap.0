From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] ARM: OMAP2+: fix missing variable declaration
Date: Wed, 23 Aug 2017 16:53:50 +0300
Message-ID: <12875092.dy1RW0XmqV@avalon>
References: <20170823132841.642239-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823132841.642239-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

On Wednesday, 23 August 2017 16:28:19 EEST Arnd Bergmann wrote:
> The function that was added doesn't actually build:
> 
> arch/arm/mach-omap2/display.c: In function 'omapdss_init_fbdev':
> arch/arm/mach-omap2/display.c:184:2: error: 'r' undeclared (first use in
> this function)
> 
> This adds a declaration for 'r' to fix it.
> 
> Fixes: 5ce783025c82 ("ARM: OMAP2+: Don't register omapdss device for
> omapdrm")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks like I haven't tested the patch with CONFIG_FB_OMAP2 enabled after the 
last rebase. I'm very sorry about that :-(

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Tomi, I assume you will pick this up and sent it to Dave for v4.14-rc1.

> ---
>  arch/arm/mach-omap2/display.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index 798fc718fffe..b3f6eb5d04a2 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -172,6 +172,7 @@ static int __init omapdss_init_fbdev(void)
>  		.set_min_bus_tput = omap_dss_set_min_bus_tput,
>  	};
>  	struct device_node *node;
> +	int r;
> 
>  	board_data.version = omap_display_get_version();
>  	if (board_data.version == OMAPDSS_VER_UNKNOWN) {


-- 
Regards,

Laurent Pinchart
