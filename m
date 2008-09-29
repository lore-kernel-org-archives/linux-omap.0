From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [i2c] [PATCH 6/8] i2c-omap: Mark init-only functions as __init
Date: Mon, 29 Sep 2008 23:30:45 +0100
Message-ID: <20080929223045.GU2716@fluff.org.uk>
References: <1222329234-31473-1-git-send-email-tony@atomide.com> <1222329234-31473-2-git-send-email-tony@atomide.com> <1222329234-31473-3-git-send-email-tony@atomide.com> <1222329234-31473-4-git-send-email-tony@atomide.com> <1222329234-31473-5-git-send-email-tony@atomide.com> <1222329234-31473-6-git-send-email-tony@atomide.com> <1222329234-31473-7-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:51859 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754424AbYI2Wav (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 18:30:51 -0400
Content-Disposition: inline
In-Reply-To: <1222329234-31473-7-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: i2c@lm-sensors.org, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

On Thu, Sep 25, 2008 at 10:53:52AM +0300, Tony Lindgren wrote:
> From: Paul Walmsley <paul@pwsan.com>
> 
> Mark functions called only at init time as __init.

surely these should be __devinit in case of hotplugged-ness?
 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index b41431a..e71f1f2 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -154,7 +154,7 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
>  	return __raw_readw(i2c_dev->base + reg);
>  }
>  
> -static int omap_i2c_get_clocks(struct omap_i2c_dev *dev)
> +static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
>  {
>  	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
>  		dev->iclk = clk_get(dev->dev, "i2c_ick");
> @@ -697,7 +697,7 @@ static const struct i2c_algorithm omap_i2c_algo = {
>  	.functionality	= omap_i2c_func,
>  };
>  
> -static int
> +static int __init
>  omap_i2c_probe(struct platform_device *pdev)
>  {
>  	struct omap_i2c_dev	*dev;
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
