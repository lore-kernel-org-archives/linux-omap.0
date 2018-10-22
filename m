From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/9] net: simplify getting .driver_data
Date: Sun, 21 Oct 2018 21:11:08 -0700 (PDT)
Message-ID: <20181021.211108.848222946495599164.davem@davemloft.net>
References: <20181021200021.1693-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021200021.1693-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa+renesas@sang-engineering.com
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Sun, 21 Oct 2018 22:00:11 +0200

> I got tired of fixing this in Renesas drivers manually, so I took the big
> hammer. Remove this cumbersome code pattern which got copy-pasted too much
> already:
> 
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
> +	struct ep93xx_keypad *keypad = dev_get_drvdata(dev);
> 
> A branch, tested by buildbot, can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git coccinelle/get_drvdata
> 
> I have been asked if it couldn't be done for dev_set_drvdata as well. I checked
> it and did not find one occasion where it could be simplified like this. Not
> much of a surprise because driver_data is usually set in probe() functions
> which access struct platform_device in many other ways.
> 
> I am open for other comments, suggestions, too, of course.
> 
> Here is the cocci-script I created:
 ...

Series applied to net-next, thanks.
