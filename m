From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [PATCH] omapfb: invalid test on unsigned
Date: Mon, 22 Jun 2009 21:35:14 +0200
Message-ID: <20090622213514.d3722324.krzysztof.h1@poczta.fm>
References: <4A3FEB2F.8040307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp239.poczta.interia.pl ([217.74.64.239]:6516 "EHLO
	smtp239.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbZFVTao (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 15:30:44 -0400
In-Reply-To: <4A3FEB2F.8040307@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: imre.deak@nokia.com, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Mon, 22 Jun 2009 22:35:59 +0200
Roel Kluin <roel.kluin@gmail.com> wrote:

> Unsigned regno cannot be less than 0.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Is this correct? please review.
> 

No. It is a case for truecolor modes. They do not use the cmap. 
Either remove the if clause completely or make it a an else clause for the next if

if (regno < 16) {
...
} else {
    r = -EINVAL;
}


The latter (the else clause) is a better solution.

Kind regards,
Krzysztof

> diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
> index 060d72f..787271f 100644
> --- a/drivers/video/omap/omapfb_main.c
> +++ b/drivers/video/omap/omapfb_main.c
> @@ -276,7 +276,7 @@ static int _setcolreg(struct fb_info *info, u_int regno, u_int red, u_int green,
>  		if (r != 0)
>  			break;
>  
> -		if (regno < 0) {
> +		if (regno >= info->cmap.len) {
>  			r = -EINVAL;
>  			break;
>  		}
> 
> ------------------------------------------------------------------------------
> Are you an open source citizen? Join us for the Open Source Bridge conference!
> Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
> Need another reason to go? 24-hour hacker lounge. Register today!
> http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

----------------------------------------------------------------------
Nowa akcja Pepsi - nagrody za kody spod nakretek. Zarejestruj sie!
http://link.interia.pl/f21cc 


