From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] da8xx-fb: add missing FB_BLANK operations
Date: Mon, 2 Jul 2012 07:51:24 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA60AE9@DBDE01.ent.ti.com>
References: <1341213073-2986-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54743 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298Ab2GBHwS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 03:52:18 -0400
In-Reply-To: <1341213073-2986-1-git-send-email-yegorslists@googlemail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "yegorslists@googlemail.com" <yegorslists@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On Mon, Jul 02, 2012 at 12:41:13, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> add FB_BLANK_NORMAL, FB_BLANK_VSYNC_SUSPEND and FB_BLANK_HSYNC_SUSPEND
> modes (copy drivers/video/omap2/omapfb/omapfb-main.c implementation).
> Otherwise X-server will complain about invalid parameter.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  drivers/video/da8xx-fb.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 29577bf..9879edc 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -987,6 +987,9 @@ static int cfb_blank(int blank, struct fb_info *info)
>  
>  		lcd_enable_raster();
>  		break;
> +	case FB_BLANK_NORMAL:
> +	case FB_BLANK_VSYNC_SUSPEND:
> +	case FB_BLANK_HSYNC_SUSPEND:
>  	case FB_BLANK_POWERDOWN:
>  		if (par->panel_power_ctrl)
>  			par->panel_power_ctrl(0);


+ linux-fbdev & Florian

You should always send Fbdev patches to linux-fbdev list.


Thanks,
Vaibhav
