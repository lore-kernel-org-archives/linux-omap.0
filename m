From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC] [PATCH] omapfb: Fix 12-bit display (RGB444 color mode)
 handling
Date: Thu, 28 Jan 2010 11:24:44 +0200
Message-ID: <1264670684.2701.216.camel@tubuntu.research.nokia.com>
References: <201001142125.45468.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:30104 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574Ab0A1JWs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 04:22:48 -0500
In-Reply-To: <201001142125.45468.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2010-01-14 at 21:25 +0100, ext Janusz Krzysztofik wrote:
> Support for RGB444 (12-bit) pixel format has been introduced into omapfb/lcdc 
> by Mark Underwood on 2006-05-26 (commit 
> f74edb6668aad9fc8e81585861b18f996c78a574) in preparation for Amstrad Delta 
> (E3) videophone LCD display support.

I haven't seen any comments on this. Shall I apply it to my tree?

 Tomi


> 
> Before the Amstrad Delta LCD patch by Jonathan McDowell was applied (on 
> 2006-08-04, commit 8d22fb2ea004cdb6379b54c1a8fd1546cfe40ed7), omapfb and lcdc 
> code was changed substantially (commit 
> e563dc81aa01bd8bbb01bc53975a15c398715f62 dated 2006-06-26) in a way that broke 
> Mark's 12-bit display support. Than, a patch by Jonathan, that supposed to 
> correct the problem, was introduced immediatelly (on 2006-08-04, commit 
> e10a75b49e7a57ae17c28b705153c70eba15a8ef).
> 
> As a result, the Amstrad Delta display was working correctly at boot time, 
> with fbset reporting:
> 
> 	geometry 480 320 480 320 16
> 	...
> 	rgba 4/8,4/4,4/0,0/0
> 
> However, after first framebuffer reinitialization, colors were no longer being 
> displayed correctly and fbset was reporting:
> 
>         rgba 5/11,6/5,5/0,0/0
> 
> The patch tries to correct the issue by setting plane->color_mode depending on 
> panel->bpp, not var->bits_per_pixel.
> 
> Created and tested on Amstrad Delta against linux-2.6.33-rc3.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzysz@tis.icnet.pl>
> 
> ---
> --- git/drivers/video/omap/omapfb_main.c.orig	2010-01-14 19:30:23.000000000 +0100
> +++ git/drivers/video/omap/omapfb_main.c	2010-01-14 20:31:18.000000000 +0100
> @@ -473,10 +473,11 @@ static int set_color_mode(struct omapfb_
>  		return 0;
>  	case 12:
>  		var->bits_per_pixel = 16;
> -		plane->color_mode = OMAPFB_COLOR_RGB444;
> -		return 0;
>  	case 16:
> -		plane->color_mode = OMAPFB_COLOR_RGB565;
> +		if (plane->fbdev->panel->bpp == 12)
> +			plane->color_mode = OMAPFB_COLOR_RGB444;
> +		else
> +			plane->color_mode = OMAPFB_COLOR_RGB565;
>  		return 0;
>  	default:
>  		return -EINVAL;


