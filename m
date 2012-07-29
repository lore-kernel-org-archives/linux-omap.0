From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH v2] da8xx-fb: add missing FB_BLANK operations
Date: Sun, 29 Jul 2012 21:05:04 +0000
Message-ID: <5015A580.5030203@gmx.de>
References: <1341583288-30281-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:46294 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753615Ab2G2VFI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Jul 2012 17:05:08 -0400
In-Reply-To: <1341583288-30281-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: yegorslists@googlemail.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tomi.valkeinen@ti.com

On 07/06/2012 02:01 PM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> add FB_BLANK_NORMAL, FB_BLANK_VSYNC_SUSPEND and FB_BLANK_HSYNC_SUSPEND
> modes (copy drivers/video/omap2/omapfb/omapfb-main.c implementation).
> Otherwise X-server will complain about invalid parameter.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
> v2: add linux-fbdev as recipient 
> 
>  drivers/video/da8xx-fb.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 47118c7..8d745bf 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -1026,6 +1026,9 @@ static int cfb_blank(int blank, struct fb_info *info)
>  
>  		lcd_enable_raster();
>  		break;
> +	case FB_BLANK_NORMAL:
> +	case FB_BLANK_VSYNC_SUSPEND:
> +	case FB_BLANK_HSYNC_SUSPEND:
>  	case FB_BLANK_POWERDOWN:
>  		if (par->panel_power_ctrl)
>  			par->panel_power_ctrl(0);

