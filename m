From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] I2C: i2c subsystem should print error messages
Date: Mon, 21 Apr 2008 11:47:06 -0700
Message-ID: <20080421184705.GC24257@atomide.com>
References: <1208435341-14830-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61069 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbYDUSrH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2008 14:47:07 -0400
Content-Disposition: inline
In-Reply-To: <1208435341-14830-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080417 05:31]:
> We don't have to print any error message if i2c_add_driver
> fails since i2c subsystem already does it.

Pushing.

Tony


> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/i2c/chips/isp1301_omap.c |   10 +---------
>  drivers/i2c/chips/menelaus.c     |   10 +---------
>  2 files changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
> index 6ebff9c..09f9662 100644
> --- a/drivers/i2c/chips/isp1301_omap.c
> +++ b/drivers/i2c/chips/isp1301_omap.c
> @@ -1606,15 +1606,7 @@ static struct i2c_driver isp1301_driver = {
>  
>  static int __init isp_init(void)
>  {
> -	int	status = -ENODEV;
> -
> -	printk(KERN_INFO "%s: version %s\n", DRIVER_NAME, DRIVER_VERSION);
> -
> -	status = i2c_add_driver(&isp1301_driver);
> -	if (status)
> -		printk(KERN_ERR "%s failed to probe\n", DRIVER_NAME);
> -
> -	return status;
> +	return i2c_add_driver(&isp1301_driver);
>  }
>  module_init(isp_init);
>  
> diff --git a/drivers/i2c/chips/menelaus.c b/drivers/i2c/chips/menelaus.c
> index 1d7482a..d4d1ccc 100644
> --- a/drivers/i2c/chips/menelaus.c
> +++ b/drivers/i2c/chips/menelaus.c
> @@ -1281,15 +1281,7 @@ static struct i2c_driver menelaus_i2c_driver = {
>  
>  static int __init menelaus_init(void)
>  {
> -	int res;
> -
> -	res = i2c_add_driver(&menelaus_i2c_driver);
> -	if (res < 0) {
> -		dev_err(&the_menelaus->client->dev, "driver registration failed\n");
> -		return res;
> -	}
> -
> -	return 0;
> +	return i2c_add_driver(&menelaus_i2c_driver);
>  }
>  
>  static void __exit menelaus_exit(void)
> -- 
> 1.5.5.49.gf43e2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
