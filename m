From: Imre Deak <imre.deak@nokia.com>
Subject: Re: [PATCH] video/omap:  adding __init/__exit macros to various
	drivers
Date: Tue, 29 Sep 2009 12:18:53 +0300
Message-ID: <20090929091853.GC9536@localhost>
References: <200909290318.07309.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753729AbZI2JUK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200909290318.07309.PeterHuewe@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Peter Huewe <PeterHuewe@gmx.de>
Cc: Jiri Kosina <trivial@kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, Jonathan McDowell <noodles@earth.li>, Arnaud Patard <arnaud.patard@rtp-net.org>, Mike Wege <ext-mike.wege@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 29, 2009 at 03:18:06AM +0200, ext Peter Huewe wrote:
> From: Peter Huewe <peterhuewe@gmx.de>
> 
> Trivial patch which adds the __init/__exit macros to the module_init/
> module_exit functions of the following drivers in media/omap:
> drivers/video/omap/lcd_ams_delta.c
> drivers/video/omap/lcd_mipid.c
> 
> Please have a look at the small patch and either pull it through
> your tree, or please ack' it so Jiri can pull it through the trivial tree.
> 
> linux version v2.6.32-rc1 - linus git tree, Di 29. Sep 01:10:18 CEST 2009
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>

Acked-by: Imre Deak <imre.deak@nokia.com>

> ---
> diff --git a/drivers/video/omap/lcd_ams_delta.c b/drivers/video/omap/lcd_ams_delta.c
> index 1f74399..319a9a2 100644
> --- a/drivers/video/omap/lcd_ams_delta.c
> +++ b/drivers/video/omap/lcd_ams_delta.c
> @@ -123,12 +123,12 @@ struct platform_driver ams_delta_panel_driver = {
>  	},
>  };
>  
> -static int ams_delta_panel_drv_init(void)
> +static int __init ams_delta_panel_drv_init(void)
>  {
>  	return platform_driver_register(&ams_delta_panel_driver);
>  }
>  
> -static void ams_delta_panel_drv_cleanup(void)
> +static void __exit ams_delta_panel_drv_cleanup(void)
>  {
>  	platform_driver_unregister(&ams_delta_panel_driver);
>  }
> diff --git a/drivers/video/omap/lcd_mipid.c b/drivers/video/omap/lcd_mipid.c
> index 918ee89..d88a792 100644
> --- a/drivers/video/omap/lcd_mipid.c
> +++ b/drivers/video/omap/lcd_mipid.c
> @@ -607,7 +607,7 @@ static struct spi_driver mipid_spi_driver = {
>  	.remove	= __devexit_p(mipid_spi_remove),
>  };
>  
> -static int mipid_drv_init(void)
> +static int __init mipid_drv_init(void)
>  {
>  	spi_register_driver(&mipid_spi_driver);
>  
> @@ -615,7 +615,7 @@ static int mipid_drv_init(void)
>  }
>  module_init(mipid_drv_init);
>  
> -static void mipid_drv_cleanup(void)
> +static void __exit mipid_drv_cleanup(void)
>  {
>  	spi_unregister_driver(&mipid_spi_driver);
>  }
