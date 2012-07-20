From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v2] da8xx-fb: add missing FB_BLANK operations
Date: Fri, 20 Jul 2012 14:20:48 +0200
Message-ID: <CAGm1_kujjERaF5K048w-YM_iKWDGn12TBhjLs_XKytitrn3jcA@mail.gmail.com>
References: <1341583288-30281-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63676 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab2GTMVL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jul 2012 08:21:11 -0400
In-Reply-To: <1341583288-30281-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, FlorianSchandinat@gmx.de, tomi.valkeinen@ti.com, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Fri, Jul 6, 2012 at 4:01 PM,  <yegorslists@googlemail.com> wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> add FB_BLANK_NORMAL, FB_BLANK_VSYNC_SUSPEND and FB_BLANK_HSYNC_SUSPEND
> modes (copy drivers/video/omap2/omapfb/omapfb-main.c implementation).
> Otherwise X-server will complain about invalid parameter.
>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
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
>                 lcd_enable_raster();
>                 break;
> +       case FB_BLANK_NORMAL:
> +       case FB_BLANK_VSYNC_SUSPEND:
> +       case FB_BLANK_HSYNC_SUSPEND:
>         case FB_BLANK_POWERDOWN:
>                 if (par->panel_power_ctrl)
>                         par->panel_power_ctrl(0);
> --
> 1.7.7
>

Were is possible to get this patch into 3.6?

Thanks.

Yegor
