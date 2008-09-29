From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [i2c] [PATCH 7/8] i2c-omap: Don't compile in OMAP15xx I2C ISR
	for non-OMAP15xx builds
Date: Mon, 29 Sep 2008 23:29:42 +0100
Message-ID: <20080929222942.GT2716@fluff.org.uk>
References: <1222329234-31473-1-git-send-email-tony@atomide.com> <1222329234-31473-2-git-send-email-tony@atomide.com> <1222329234-31473-3-git-send-email-tony@atomide.com> <1222329234-31473-4-git-send-email-tony@atomide.com> <1222329234-31473-5-git-send-email-tony@atomide.com> <1222329234-31473-6-git-send-email-tony@atomide.com> <1222329234-31473-7-git-send-email-tony@atomide.com> <1222329234-31473-8-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:51851 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751772AbYI2W3r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 18:29:47 -0400
Content-Disposition: inline
In-Reply-To: <1222329234-31473-8-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: i2c@lm-sensors.org, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

On Thu, Sep 25, 2008 at 10:53:53AM +0300, Tony Lindgren wrote:
> From: Paul Walmsley <paul@pwsan.com>
> 
> Skip compiling OMAP15xx I2C ISR for non-OMAP15xx builds.  Saves 400 bytes
> of text for most OMAP builds.

you've sneaked in __devinit/__devexit changes into this patch,
I'm going to put my foot down on that.
 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index e71f1f2..5c54864 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -511,6 +511,9 @@ omap_i2c_ack_stat(struct omap_i2c_dev *dev, u16 stat)
>  	omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
>  }
>  
> +/* rev1 devices are apparently only on some 15xx */
> +#ifdef CONFIG_ARCH_OMAP15XX
> +
>  static irqreturn_t
>  omap_i2c_rev1_isr(int this_irq, void *dev_id)
>  {
> @@ -565,6 +568,9 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
>  
>  	return IRQ_HANDLED;
>  }
> +#else
> +#define omap_i2c_rev1_isr		0
> +#endif
>  
>  static irqreturn_t
>  omap_i2c_isr(int this_irq, void *dev_id)
> @@ -843,14 +849,14 @@ static struct platform_driver omap_i2c_driver = {
>  };
>  
>  /* I2C may be needed to bring up other drivers */
> -static int __init
> +static int __devinit
>  omap_i2c_init_driver(void)
>  {
>  	return platform_driver_register(&omap_i2c_driver);
>  }
>  subsys_initcall(omap_i2c_init_driver);
>  
> -static void __exit omap_i2c_exit_driver(void)
> +static void __devexit omap_i2c_exit_driver(void)

a differerent change to the one advertised.

>  {
>  	platform_driver_unregister(&omap_i2c_driver);
>  }
> -- 
> 1.5.6.rc3.21.g8c6b5
> 
> 
> _______________________________________________
> i2c mailing list
> i2c@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
