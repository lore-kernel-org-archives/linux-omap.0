From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/5] watchdog: sync linux-omap changes
Date: Fri, 19 Sep 2008 23:40:19 +0100
Message-ID: <20080919224019.GC9675@flint.arm.linux.org.uk>
References: <1221820359-8943-1-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48417 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939AbYISWkl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 18:40:41 -0400
Content-Disposition: inline
In-Reply-To: <1221820359-8943-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Wim Van Sebroeck <wim@iguana.be>, Andrew Morton <akpm@linux-foundation.org>, "George G. Davis" <gdavis@mvista.com>

You're getting there with this patch, but still not completely up to
snuff.

On Fri, Sep 19, 2008 at 01:32:35PM +0300, Felipe Balbi wrote:
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 3a11dad..e55f2cc 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -39,6 +39,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/moduleparam.h>
>  #include <linux/clk.h>
> +
>  #include <linux/bitops.h>
>  #include <linux/io.h>
>  #include <linux/uaccess.h>

This hunk is unnecessary.

> @@ -218,19 +240,18 @@ static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
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

This is removing the spin lock which should remain.

>  		/* Fall */
>  	case WDIOC_GETTIMEOUT:
>  		return put_user(timer_margin, (int __user *)arg);
>  	default:
>  		return -ENOTTY;
>  	}
> +	return 0;

And this return statement shouldn't be required.

Apart from those three points, nice work.
