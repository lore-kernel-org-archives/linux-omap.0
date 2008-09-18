From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/5] watchdog: sync linux-omap changes
Date: Fri, 19 Sep 2008 00:05:29 +0100
Message-ID: <20080918230528.GF14307@flint.arm.linux.org.uk>
References: <1221776622-22906-1-git-send-email-me@felipebalbi.com> <1221776622-22906-2-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41804 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbYIRXGm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 19:06:42 -0400
Content-Disposition: inline
In-Reply-To: <1221776622-22906-2-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "George G. Davis" <gdavis@mvista.com>, Wim Van Sebroeck <wim@iguana.be>, Felipe Balbi <felipe.balbi@nokia.com>

On Fri, Sep 19, 2008 at 01:23:38AM +0300, Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> These are changes that have been sitting in linux-omap
> and were never sent upstream.
> 
> Hopefully, it'll never happen again at least for this
> driver.

Great, thanks for looking at this.

Unfortunately, it looks like we have two entirely separate forks - one
in mainline which has been worked on, and one in the omap tree which
has been separately worked on.  The two sets of changes have never been
merged, so it's not going to just be a case of updating mainline's to
what's in OMAP.

> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 3a11dad..b111dec 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -1,7 +1,7 @@
>  /*
> - * linux/drivers/char/watchdog/omap_wdt.c
> + * linux/drivers/watchdog/omap_wdt.c
>   *
> - * Watchdog driver for the TI OMAP 16xx & 24xx 32KHz (non-secure) watchdog
> + * Watchdog driver for the TI OMAP 16xx & 24xx/34xx 32KHz (non-secure) watchdog
>   *
>   * Author: MontaVista Software, Inc.
>   *	 <gdavis@mvista.com> or <source@mvista.com>
> @@ -39,58 +39,71 @@
>  #include <linux/platform_device.h>
>  #include <linux/moduleparam.h>
>  #include <linux/clk.h>
> -#include <linux/bitops.h>
> -#include <linux/io.h>
> -#include <linux/uaccess.h>
> +
> +#include <asm/io.h>
> +#include <asm/uaccess.h>
>  #include <mach/hardware.h>
> +#include <asm/bitops.h>
> +

Please drop this change; I suspect it's a result of a mis-merge, or
maybe the mainline code is ahead in this respect of the omap tree.

> -static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
> -						unsigned long arg)
> +static int
> +omap_wdt_ioctl(struct inode *inode, struct file *file,
> +	unsigned int cmd, unsigned long arg)

This probably wants dropping as well, since it's backing out Alan's
updates to make watchdogs use the unlocked ioctl method.

>  {
> +	struct omap_wdt_dev *wdev;
>  	int new_margin;
> -	static const struct watchdog_info ident = {
> +	static struct watchdog_info ident = {

This backs out a change to add const.

>  		.identity = "OMAP Watchdog",
>  		.options = WDIOF_SETTIMEOUT,
>  		.firmware_version = 0,
>  	};
> +	wdev = file->private_data;
>  
>  	switch (cmd) {
> +	default:
> +		return -ENOTTY;

This backs out changes from 0c06090c9472db0525cb6fe229c3bea33bbbbb3c.

>  	case WDIOC_GETSUPPORT:
>  		return copy_to_user((struct watchdog_info __user *)arg, &ident,
>  				sizeof(ident));
> @@ -209,128 +231,173 @@ static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
>  			return put_user(omap_prcm_get_reset_sources(),
>  					(int __user *)arg);
>  	case WDIOC_KEEPALIVE:
> -		spin_lock(&wdt_lock);
> -		omap_wdt_ping();
> -		spin_unlock(&wdt_lock);
> +		omap_wdt_ping(wdev);

Backs out the addition of the spin locking.

>  		return 0;
>  	case WDIOC_SETTIMEOUT:
>  		if (get_user(new_margin, (int __user *)arg))
>  			return -EFAULT;
>  		omap_wdt_adjust_timeout(new_margin);
>  
> -		spin_lock(&wdt_lock);
> -		omap_wdt_disable();
> -		omap_wdt_set_timeout();
> -		omap_wdt_enable();
> +		omap_wdt_disable(wdev);
> +		omap_wdt_set_timeout(wdev);
> +		omap_wdt_enable(wdev);
>  
> -		omap_wdt_ping();
> -		spin_unlock(&wdt_lock);
> +		omap_wdt_ping(wdev);

Ditto.

>  		/* Fall */
>  	case WDIOC_GETTIMEOUT:
>  		return put_user(timer_margin, (int __user *)arg);
> -	default:
> -		return -ENOTTY;

This backs out changes from 0c06090c9472db0525cb6fe229c3bea33bbbbb3c.

>  	}
> +	return 0;

Not needed.

>  }
>  
>  static const struct file_operations omap_wdt_fops = {
>  	.owner = THIS_MODULE,
>  	.write = omap_wdt_write,
> -	.unlocked_ioctl = omap_wdt_ioctl,
> +	.ioctl = omap_wdt_ioctl,

Alan's unlocked_ioctl change backed out.

>  	.open = omap_wdt_open,
>  	.release = omap_wdt_release,
>  };
>  
> -static struct miscdevice omap_wdt_miscdev = {
> -	.minor = WATCHDOG_MINOR,
> -	.name = "watchdog",
> -	.fops = &omap_wdt_fops,
> -};
>  
>  static int __init omap_wdt_probe(struct platform_device *pdev)
>  {
>  	struct resource *res, *mem;
>  	int ret;
> +	struct omap_wdt_dev *wdev;
>  
>  	/* reserve static register mappings */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res)
>  		return -ENOENT;
>  
> +	if (omap_wdt_dev)
> +		return -EBUSY;
> +
>  	mem = request_mem_region(res->start, res->end - res->start + 1,
>  				 pdev->name);
>  	if (mem == NULL)
>  		return -EBUSY;
>  
> -	platform_set_drvdata(pdev, mem);
> -
> -	omap_wdt_users = 0;
> +	wdev = kzalloc(sizeof(struct omap_wdt_dev), GFP_KERNEL);
> +	if (!wdev) {
> +		ret = -ENOMEM;
> +		goto fail;
> +	}
> +	wdev->omap_wdt_users = 0;
> +	wdev->mem = mem;
>  
>  	if (cpu_is_omap16xx()) {
> -		armwdt_ck = clk_get(&pdev->dev, "armwdt_ck");
> -		if (IS_ERR(armwdt_ck)) {
> -			ret = PTR_ERR(armwdt_ck);
> -			armwdt_ck = NULL;
> +		wdev->armwdt_ck = clk_get(&pdev->dev, "armwdt_ck");
> +		if (IS_ERR(wdev->armwdt_ck)) {
> +			ret = PTR_ERR(wdev->armwdt_ck);
> +			wdev->armwdt_ck = NULL;
>  			goto fail;
>  		}
>  	}
>  
>  	if (cpu_is_omap24xx()) {
> -		mpu_wdt_ick = clk_get(&pdev->dev, "mpu_wdt_ick");
> -		if (IS_ERR(mpu_wdt_ick)) {
> -			ret = PTR_ERR(mpu_wdt_ick);
> -			mpu_wdt_ick = NULL;
> +		wdev->mpu_wdt_ick = clk_get(&pdev->dev, "mpu_wdt_ick");
> +		if (IS_ERR(wdev->mpu_wdt_ick)) {
> +			ret = PTR_ERR(wdev->mpu_wdt_ick);
> +			wdev->mpu_wdt_ick = NULL;
> +			goto fail;
> +		}
> +		wdev->mpu_wdt_fck = clk_get(&pdev->dev, "mpu_wdt_fck");
> +		if (IS_ERR(wdev->mpu_wdt_fck)) {
> +			ret = PTR_ERR(wdev->mpu_wdt_fck);
> +			wdev->mpu_wdt_fck = NULL;
> +			goto fail;
> +		}
> +	}
> +
> +	if (cpu_is_omap34xx()) {
> +		wdev->mpu_wdt_ick = clk_get(&pdev->dev, "wdt2_ick");
> +		if (IS_ERR(wdev->mpu_wdt_ick)) {
> +			ret = PTR_ERR(wdev->mpu_wdt_ick);
> +			wdev->mpu_wdt_ick = NULL;
>  			goto fail;
>  		}
> -		mpu_wdt_fck = clk_get(&pdev->dev, "mpu_wdt_fck");
> -		if (IS_ERR(mpu_wdt_fck)) {
> -			ret = PTR_ERR(mpu_wdt_fck);
> -			mpu_wdt_fck = NULL;
> +		wdev->mpu_wdt_fck = clk_get(&pdev->dev, "wdt2_fck");
> +		if (IS_ERR(wdev->mpu_wdt_fck)) {
> +			ret = PTR_ERR(wdev->mpu_wdt_fck);
> +			wdev->mpu_wdt_fck = NULL;
>  			goto fail;
>  		}
>  	}
> +	wdev->base = (void __iomem *) (mem->start);
> +	platform_set_drvdata(pdev, wdev);
>  
> -	omap_wdt_disable();
> +	omap_wdt_disable(wdev);
>  	omap_wdt_adjust_timeout(timer_margin);
>  
> -	omap_wdt_miscdev.parent = &pdev->dev;
> -	ret = misc_register(&omap_wdt_miscdev);
> +	wdev->omap_wdt_miscdev.parent = &pdev->dev;
> +	wdev->omap_wdt_miscdev.minor = WATCHDOG_MINOR;
> +	wdev->omap_wdt_miscdev.name = "watchdog";
> +	wdev->omap_wdt_miscdev.fops = &omap_wdt_fops;
> +
> +	ret = misc_register(&(wdev->omap_wdt_miscdev));
>  	if (ret)
>  		goto fail;
>  
> -	pr_info("OMAP Watchdog Timer: initial timeout %d sec\n", timer_margin);
> +	pr_info("OMAP Watchdog Timer Rev 0x%02x: initial timeout %d sec\n",
> +		omap_readl(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
> +		timer_margin);
>  
>  	/* autogate OCP interface clock */
> -	omap_writel(0x01, OMAP_WATCHDOG_SYS_CONFIG);
> +	omap_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
> +
> +	omap_wdt_dev = pdev;
> +
>  	return 0;
>  
>  fail:
> -	if (armwdt_ck)
> -		clk_put(armwdt_ck);
> -	if (mpu_wdt_ick)
> -		clk_put(mpu_wdt_ick);
> -	if (mpu_wdt_fck)
> -		clk_put(mpu_wdt_fck);
> -	release_resource(mem);
> +	if (wdev) {
> +		platform_set_drvdata(pdev, NULL);
> +		if (wdev->armwdt_ck)
> +			clk_put(wdev->armwdt_ck);
> +		if (wdev->mpu_wdt_ick)
> +			clk_put(wdev->mpu_wdt_ick);
> +		if (wdev->mpu_wdt_fck)
> +			clk_put(wdev->mpu_wdt_fck);
> +		kfree(wdev);
> +	}
> +	if (mem) {
> +		release_resource(mem);
> +	}
>  	return ret;
>  }
>  
>  static void omap_wdt_shutdown(struct platform_device *pdev)
>  {
> -	omap_wdt_disable();
> +	struct omap_wdt_dev *wdev;
> +	wdev = platform_get_drvdata(pdev);
> +
> +	if (wdev->omap_wdt_users)
> +		omap_wdt_disable(wdev);
>  }
>  
>  static int omap_wdt_remove(struct platform_device *pdev)
>  {
> -	struct resource *mem = platform_get_drvdata(pdev);
> -	misc_deregister(&omap_wdt_miscdev);
> -	release_resource(mem);
> -	if (armwdt_ck)
> -		clk_put(armwdt_ck);
> -	if (mpu_wdt_ick)
> -		clk_put(mpu_wdt_ick);
> -	if (mpu_wdt_fck)
> -		clk_put(mpu_wdt_fck);
> +	struct omap_wdt_dev *wdev;
> +	wdev = platform_get_drvdata(pdev);
> +
> +	misc_deregister(&(wdev->omap_wdt_miscdev));
> +	release_resource(wdev->mem);

I wish I'd seen this code before it went in... release_resource()
leaks the memory associated with the resource that was allocated
in request_mem_region().  request_mem_region()'s counterpart is
release_mem_region() not release_resource().

> +	platform_set_drvdata(pdev, NULL);
> +	if (wdev->armwdt_ck) {
> +		clk_put(wdev->armwdt_ck);
> +		wdev->armwdt_ck = NULL;
> +	}
> +	if (wdev->mpu_wdt_ick) {
> +		clk_put(wdev->mpu_wdt_ick);
> +		wdev->mpu_wdt_ick = NULL;
> +	}
> +	if (wdev->mpu_wdt_fck) {
> +		clk_put(wdev->mpu_wdt_fck);
> +		wdev->mpu_wdt_fck = NULL;
> +	}
> +	kfree(wdev);
> +	omap_wdt_dev = NULL;
>  	return 0;
>  }
>  
> @@ -344,16 +411,20 @@ static int omap_wdt_remove(struct platform_device *pdev)
>  
>  static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t state)
>  {
> -	if (omap_wdt_users)
> -		omap_wdt_disable();
> +	struct omap_wdt_dev *wdev;
> +	wdev = platform_get_drvdata(pdev);
> +	if (wdev->omap_wdt_users)
> +		omap_wdt_disable(wdev);
>  	return 0;
>  }
>  
>  static int omap_wdt_resume(struct platform_device *pdev)
>  {
> -	if (omap_wdt_users) {
> -		omap_wdt_enable();
> -		omap_wdt_ping();
> +	struct omap_wdt_dev *wdev;
> +	wdev = platform_get_drvdata(pdev);
> +	if (wdev->omap_wdt_users) {
> +		omap_wdt_enable(wdev);
> +		omap_wdt_ping(wdev);
>  	}
>  	return 0;
>  }
> @@ -377,7 +448,6 @@ static struct platform_driver omap_wdt_driver = {
>  
>  static int __init omap_wdt_init(void)
>  {
> -	spin_lock_init(&wdt_lock);

This wants to be kept.

>  	return platform_driver_register(&omap_wdt_driver);
>  }
>  

If you want to see the changes that have happened in mainline to this
driver:

git diff -u b7e04f8c61a46d742de23af5d7ca2b41b33e40ac..origin \
  drivers/watchdog/omap_wdt.c |less

where 'origin' is your latest mainline commit id or branch name.
