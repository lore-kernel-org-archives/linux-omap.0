From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] cbus-retu-wdt: Remove unused nonstandard interfaces
Date: Mon, 7 Mar 2011 09:47:26 +0200
Message-ID: <20110307074726.GG2522@legolas.emea.dhcp.ti.com>
References: <1299250349.21644.4.camel@marge>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:33387 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750972Ab1CGHre (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 02:47:34 -0500
Received: by fxm16 with SMTP id 16so5574976fxm.22
        for <linux-omap@vger.kernel.org>; Sun, 06 Mar 2011 23:47:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1299250349.21644.4.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Mar 04, 2011 at 03:52:29PM +0100, Michael Buesch wrote:
> Index: linux-2.6.38-rc6/drivers/cbus/retu-wdt.c
> ===================================================================
> --- linux-2.6.38-rc6.orig/drivers/cbus/retu-wdt.c	2011-03-04 15:45:37.533948567 +0100
> +++ linux-2.6.38-rc6/drivers/cbus/retu-wdt.c	2011-03-04 15:46:21.312816961 +0100
> @@ -52,7 +52,6 @@ static DEFINE_MUTEX(retu_wdt_mutex);
>  
>  /* Current period of watchdog */
>  static unsigned int period_val = RETU_WDT_DEFAULT_TIMER;
> -static int counter_param = RETU_WDT_MAX_TIMER;
>  
>  struct retu_wdt_dev {
>  	struct device		*dev;
> @@ -109,56 +108,6 @@ static void retu_wdt_ping_work(struct wo
>  	retu_wdt_ping_enable(wdev);
>  }
>  
> -static ssize_t retu_wdt_period_show(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> -{
> -	/* Show current max counter */
> -	return sprintf(buf, "%u\n", (u16)period_val);
> -}
> -
> -/*
> - * Note: This inteface is non-standard and likely to disappear!
> - * Use /dev/watchdog instead, that's the standard.
> - */
> -static ssize_t retu_wdt_period_store(struct device *dev,
> -				struct device_attribute *attr,
> -				const char *buf, size_t count)
> -{
> -	unsigned int new_period;
> -	int ret;
> -
> -#ifdef CONFIG_WATCHDOG_NOWAYOUT
> -	retu_wdt_ping_disable(retu_wdt);
> -#endif
> -
> -	if (sscanf(buf, "%u", &new_period) != 1) {
> -		printk(KERN_ALERT "retu_wdt_period_store: Invalid input\n");
> -		return -EINVAL;
> -	}
> -
> -	ret = retu_modify_counter(new_period);
> -	if (ret < 0)
> -		return ret;
> -
> -	return strnlen(buf, count);
> -}
> -
> -static ssize_t retu_wdt_counter_show(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> -{
> -	u16 counter;
> -
> -	/* Show current value in watchdog counter */
> -	counter = retu_read_reg(dev, RETU_REG_WATCHDOG);
> -
> -	/* Only the 5 LSB are important */
> -	return snprintf(buf, PAGE_SIZE, "%u\n", (counter & 0x3F));
> -}
> -
> -static DEVICE_ATTR(period, S_IRUGO | S_IWUSR, retu_wdt_period_show, \
> -			retu_wdt_period_store);
> -static DEVICE_ATTR(counter, S_IRUGO, retu_wdt_counter_show, NULL);
> -
>  static int retu_wdt_open(struct inode *inode, struct file *file)
>  {
>  	if (test_and_set_bit(0, &retu_wdt->users))
> @@ -232,18 +181,6 @@ static long retu_wdt_ioctl(struct file *
>  	return 0;
>  }
>  
> -/* Start kicking retu watchdog until user space starts doing the kicking */
> -static int __devinit retu_wdt_ping(void)
> -{
> -#ifdef CONFIG_WATCHDOG_NOWAYOUT
> -	retu_modify_counter(RETU_WDT_MAX_TIMER);
> -#else
> -	retu_wdt_ping_enable(retu_wdt);
> -#endif
> -
> -	return 0;
> -}

is this part of this patch ? Also, I guess other watchdog drivers have
similar tricks to kick the watchdog.

> @@ -252,8 +189,6 @@ static const struct file_operations retu
>  	.release	= retu_wdt_release,
>  };
>  
> -/*----------------------------------------------------------------------------*/
> -

trailing change.

> @@ -286,38 +209,21 @@ static int __init retu_wdt_probe(struct
>  
>  	ret = misc_register(&(wdev->retu_wdt_miscdev));
>  	if (ret)
> -		goto free3;
> +		goto err_free_wdev;
>  
>  	INIT_DELAYED_WORK(&wdev->ping_work, retu_wdt_ping_work);
>  
> -	/* passed as module parameter? */
> -	ret = retu_modify_counter(counter_param);
> -	if (ret == -EINVAL) {
> -		ret = retu_modify_counter(RETU_WDT_DEFAULT_TIMER);
> -		dev_dbg(&pdev->dev, "Initializing to default value\n");
> -	}
> -
> -	/* Kick the watchdog for kernel booting to finish */
> +	/* Kick the watchdog for kernel booting to finish.
> +	 * If nowayout is not set, we start the ping work. */

multiline comment style is wrong.

> +#ifdef CONFIG_WATCHDOG_NOWAYOUT
>  	retu_modify_counter(RETU_WDT_MAX_TIMER);
> -
> -	ret = retu_wdt_ping();
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "Failed to ping\n");
> -		goto free4;
> -	}
> +#else
> +	retu_wdt_ping_enable(retu_wdt);
> +#endif

Rather, keep that function and call it here.

-- 
balbi
