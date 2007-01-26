From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] dsp: don't use registered_fb[1]
Date: Fri, 26 Jan 2007 13:51:24 -0800
Message-ID: <20070126215123.GL29286@atomide.com>
References: <85ac0lg239.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <85ac0lg239.fsf@orfeo.duckcorp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnaud Patard <arnaud.patard@rtp-net.org>, Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Arnaud Patard <arnaud.patard@rtp-net.org> [070114 05:45]:
> 
> According to dsp_fbexport(), the dsp code handles only the first
> registered framebuffer, so using registered_fb[1] in mbox_fbctl_upd is
> wrong. registered_fb[0] must be used instead. 
> This code has also the side effect to oops the kernel as
> registered_fb[1] is null and omapfb_update_window_async doesn't handle
> this case. The fix for omapfb_update_window_async is sent in an other
> mail.
> 
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> ---

> ---
>  arch/arm/plat-omap/dsp/dsp_mem.c |    2 	1 +	1 -	0 !
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-omap-2.6/arch/arm/plat-omap/dsp/dsp_mem.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/dsp/dsp_mem.c	2007-01-14 14:10:26.000000000 +0100
> +++ linux-omap-2.6/arch/arm/plat-omap/dsp/dsp_mem.c	2007-01-14 14:10:37.000000000 +0100
> @@ -2052,7 +2052,7 @@ void mbox_fbctl_upd(void)
>  		return;
>  	}
>  	//printk("calling omapfb_update_window_async()\n");
> -	omapfb_update_window_async(registered_fb[1], &win, fbupd_cb, NULL);
> +	omapfb_update_window_async(registered_fb[0], &win, fbupd_cb, NULL);
>  }
>  
>  #else /* CONFIG_FB_OMAP_LCDC_EXTERNAL */

Toshihiro and Hiroshi, can you ack this one?

Regards,

Tony
