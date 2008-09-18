From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/5] watchdog: another ioremap() fix
Date: Fri, 19 Sep 2008 00:06:53 +0100
Message-ID: <20080918230653.GG14307@flint.arm.linux.org.uk>
References: <1221776622-22906-1-git-send-email-me@felipebalbi.com> <1221776622-22906-2-git-send-email-me@felipebalbi.com> <1221776622-22906-3-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41809 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbYIRXHG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 19:07:06 -0400
Content-Disposition: inline
In-Reply-To: <1221776622-22906-3-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "George G. Davis" <gdavis@mvista.com>, Wim Van Sebroeck <wim@iguana.be>, Felipe Balbi <felipe.balbi@nokia.com>

On Fri, Sep 19, 2008 at 01:23:39AM +0300, Felipe Balbi wrote:
> @@ -359,6 +364,8 @@ fail:
>  			clk_put(wdev->mpu_wdt_ick);
>  		if (wdev->mpu_wdt_fck)
>  			clk_put(wdev->mpu_wdt_fck);
> +		if (wdev->base)
> +			iounmap(wdev->base);
>  		kfree(wdev);
>  	}
>  	if (mem) {
> @@ -396,6 +403,9 @@ static int omap_wdt_remove(struct platform_device *pdev)
>  		clk_put(wdev->mpu_wdt_fck);
>  		wdev->mpu_wdt_fck = NULL;
>  	}
> +	if (wdev->base)
> +		iounmap(wdev->base);
> +

For both of these... iounmap on NULL pointers is allowed, so the
test is redundant.
