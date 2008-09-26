From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 5/8] i2c: move twl4030-usb to platform_device
Date: Fri, 26 Sep 2008 13:37:25 +0300
Message-ID: <20080926103725.GK24627@gandalf.research.nokia.com>
References: <1222422061-3940-1-git-send-email-felipe.balbi@nokia.com> <1222422061-3940-2-git-send-email-felipe.balbi@nokia.com> <1222422061-3940-3-git-send-email-felipe.balbi@nokia.com> <1222422061-3940-4-git-send-email-felipe.balbi@nokia.com> <1222422061-3940-5-git-send-email-felipe.balbi@nokia.com> <1222422061-3940-6-git-send-email-felipe.balbi@nokia.com> <20080926103347.GJ24627@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31821 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264AbYIZKiB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 06:38:01 -0400
Content-Disposition: inline
In-Reply-To: <20080926103347.GJ24627@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>

On Fri, Sep 26, 2008 at 01:33:47PM +0300, Felipe Balbi wrote:
> -static void __exit twl4030_usb_exit(void)
> +static int __exit twl4030_usb_remove(struct platform_device *pdev)
>  {
> -	struct twl4030_usb *twl = the_transceiver;
> +	struct twl4030_usb *twl = dev_get_drvdata(&pdev->dev);

Damn, forgot this one. I'll resend the whole series soon. I'm converting
twl4030-madc to platform_device. Ignore this series.

-- 
balbi
