From: Tony Lindgren <tony@atomide.com>
Subject: Re: Unnecessary line in omapfb_main.c
Date: Fri, 28 Mar 2008 12:30:52 +0200
Message-ID: <20080328103051.GT24896@atomide.com>
References: <c656a4d20803250210l7a950409lbc6897b68c27019f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51045 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbYC1Kay (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 06:30:54 -0400
Content-Disposition: inline
In-Reply-To: <c656a4d20803250210l7a950409lbc6897b68c27019f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org

* arun c <arunedarath@mistralsolutions.com> [080325 11:11]:
> Hi all,
> 
> While grepping through the sources i found one unnecessary line in
> omapfb_main.c
> 
> The patch is pasted below.
> 
> diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
> index f66b81a..07eb3f0 100644
> --- a/drivers/video/omap/omapfb_main.c
> +++ b/drivers/video/omap/omapfb_main.c
> @@ -559,7 +559,6 @@ static int set_fb_var(struct fb_info *fbi,
>  		var->xoffset = var->xres_virtual - var->xres;
>  	if (var->yres + var->yoffset > var->yres_virtual)
>  		var->yoffset = var->yres_virtual - var->yres;
> -	line_size = var->xres * bpp / 8;
> 
>  	if (plane->color_mode == OMAPFB_COLOR_RGB444) {
>  		var->red.offset	  = 8; var->red.length	 = 4;

Indeed looks like dead code as line_size is not used after that line
:) Can you please send the patch with proper Signed-off-by?

Thanks,

Tony
