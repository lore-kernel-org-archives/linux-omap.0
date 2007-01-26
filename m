From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omapfb: Add sanity check to omapfb_update_window_async
Date: Fri, 26 Jan 2007 13:54:08 -0800
Message-ID: <20070126215408.GM29286@atomide.com>
References: <858xg5g236.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <858xg5g236.fsf@orfeo.duckcorp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Arnaud Patard <arnaud.patard@rtp-net.org> [070114 05:45]:
> 
> This patch makes sure that the fb_info pointer given to
> omapfb_update_window_async is not null.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> ---

> ---
>  drivers/video/omap/omapfb_main.c |    9 	7 +	2 -	0 !
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> Index: linux-omap-2.6/drivers/video/omap/omapfb_main.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/video/omap/omapfb_main.c	2007-01-14 14:10:26.000000000 +0100
> +++ linux-omap-2.6/drivers/video/omap/omapfb_main.c	2007-01-14 14:10:29.000000000 +0100
> @@ -626,10 +626,15 @@ int omapfb_update_window_async(struct fb
>  				void (*callback)(void *),
>  				void *callback_data)
>  {
> -	struct omapfb_plane_struct *plane = fbi->par;
> -	struct omapfb_device *fbdev = plane->fbdev;
> +	struct omapfb_plane_struct *plane;
> +	struct omapfb_device *fbdev;
>  	struct fb_var_screeninfo *var;
>  
> +	if (!fbi)
> +		return -EINVAL;
> +
> +	plane = fbi->par;
> +	fbdev = plane->fbdev;
>  	var = &fbi->var;
>  
>  	if (win->x >= var->xres || win->y >= var->yres)

Pushing today.

Tony
