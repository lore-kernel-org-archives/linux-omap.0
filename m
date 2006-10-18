From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Replace apollon LCD mux setting
Date: Wed, 18 Oct 2006 22:55:42 +0300
Message-ID: <20061018195540.GJ4669@atomide.com>
References: <000901c6ed0f$bf962ba0$c7a3580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <000901c6ed0f$bf962ba0$c7a3580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Kyungmin Park <kyungmin.park@samsung.com> [061011 11:50]:
> Change the LCD mux setting from enable() to init() for PM
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> --
> 
> diff --git a/drivers/video/omap/lcd_apollon.c
> b/drivers/video/omap/lcd_apollon.c
> index fabc3a5..4c0f370 100644
> --- a/drivers/video/omap/lcd_apollon.c
> +++ b/drivers/video/omap/lcd_apollon.c
> @@ -35,6 +35,8 @@ #include <asm/arch/omapfb.h>  static int
> apollon_panel_init(struct lcd_panel *panel,
>  				struct omapfb_device *fbdev)
>  {
> +	/* configure LCD PWR_EN */
> +	omap_cfg_reg(M21_242X_GPIO11);
>  	return 0;
>  }
>  
> @@ -44,10 +46,6 @@ static void apollon_panel_cleanup(struct
>  
>  static int apollon_panel_enable(struct lcd_panel *panel)  {
> -
> -	/* configure LCD PWR_EN */
> -	omap_cfg_reg(M21_242X_GPIO11);
> -
>  	return 0;
>  }

Pushing today. Again your mailer badly reformats the patch... Maybe also
attach it in addition to inlining? Or does somebody know how to send
patches without them getting wrapped from Outlook?

Regards,

Tony
