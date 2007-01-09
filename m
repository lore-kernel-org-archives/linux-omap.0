From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix warnings in lcd_palmz71
Date: Tue, 9 Jan 2007 15:30:20 -0800
Message-ID: <20070109233019.GO7384@atomide.com>
References: <459D484C.3010202@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <459D484C.3010202@googlemail.com>
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

* Dirk Behme <dirk.behme@googlemail.com> [070104 10:40]:
> 
> ARM: OMAP: Fix warnings in lcd_palmz71.c about
> "initialization from incompatible pointer type". Minor
> formatting fix.
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> 

> Index: linux-osk/drivers/video/omap/lcd_palmz71.c
> ===================================================================
> --- linux-osk.orig/drivers/video/omap/lcd_palmz71.c
> +++ linux-osk/drivers/video/omap/lcd_palmz71.c
> @@ -30,28 +30,29 @@
>  #include <asm/arch/gpio.h>
>  #include <asm/arch/omapfb.h>
>  
> -static int palmz71_panel_init(struct omapfb_device *panel)
> +static int palmz71_panel_init(struct lcd_panel *panel,
> +			      struct omapfb_device *fbdev)
>  {
>  	return 0;
>  }
>  
> -static void palmz71_panel_cleanup(void)
> +static void palmz71_panel_cleanup(struct lcd_panel *panel)
>  {
>  
>  }
>  
> -static int palmz71_panel_enable(void)
> +static int palmz71_panel_enable(struct lcd_panel *panel)
>  {
>  	return 0;
>  }
>  
> -static void palmz71_panel_disable(void)
> +static void palmz71_panel_disable(struct lcd_panel *panel)
>  {
>  }
>  
> -static unsigned long palmz71_panel_get_caps(void)
> +static unsigned long palmz71_panel_get_caps(struct lcd_panel *panel)
>  {
> -return OMAPFB_CAPS_SET_BACKLIGHT;
> +	return OMAPFB_CAPS_SET_BACKLIGHT;
>  }
>  
>  struct lcd_panel palmz71_panel = {

Pushing today.

Tony
