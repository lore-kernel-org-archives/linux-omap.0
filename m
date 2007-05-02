From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix warning in lcdc.c
Date: Wed, 2 May 2007 17:36:18 +0000
Message-ID: <20070502173617.GG3520@atomide.com>
References: <46373FBC.40808@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <46373FBC.40808@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070501 13:30]:
> 
> Fix warning
> 
> drivers/video/omap/lcdc.c:878: warning: initialization from
> incompatible pointer type
> 
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

> Index: linux-osk/drivers/video/omap/lcdc.c
> ===================================================================
> --- linux-osk.orig/drivers/video/omap/lcdc.c
> +++ linux-osk/drivers/video/omap/lcdc.c
> @@ -611,9 +611,9 @@ static void omap_lcdc_resume(void)
>  	}
>  }
>  
> -static unsigned long omap_lcdc_get_caps(void)
> +static void omap_lcdc_get_caps(int plane, struct omapfb_caps *caps)
>  {
> -	return 0;
> +	return;
>  }
>  
>  int omap_lcdc_set_dma_callback(void (*callback)(void *data), void *data)
> 
> 

Pushing today.

Tony
