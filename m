From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH v2] watchdog: omap_wdt: convert to new watchdog core
Date: Tue, 11 Sep 2012 15:29:53 +0530
Message-ID: <504F0B99.5090500@ti.com>
References: <1347127441-23125-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347127441-23125-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

On Saturday 08 September 2012 11:34 PM, Aaro Koskinen wrote:
> -static struct platform_device *omap_wdt_dev;
> -
>  static unsigned timer_margin;
>  module_param(timer_margin, uint, 0);
>  MODULE_PARM_DESC(timer_margin, "initial watchdog timeout (in seconds)");
>  
> -static unsigned int wdt_trgr_pattern = 0x1234;
> -static DEFINE_SPINLOCK(wdt_lock);
> -
you may want to describe this more.
>  struct omap_wdt_dev {
>  	void __iomem    *base;          /* physical */
>  	struct device   *dev;
> -	int             omap_wdt_users;
> +	bool		omap_wdt_users;
>  	struct resource *mem;
> -	struct miscdevice omap_wdt_miscdev;
> +	int		wdt_trgr_pattern;
> +	struct mutex	lock;		/* to avoid races with PM */
>  };
>  
