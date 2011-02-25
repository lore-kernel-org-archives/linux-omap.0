From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/5] usb: musb: Idle path retention and offmode support
 for OMAP3
Date: Fri, 25 Feb 2011 12:14:52 +0200
Message-ID: <20110225101452.GB4190@legolas.emea.dhcp.ti.com>
References: <1298628663-27650-1-git-send-email-hemahk@ti.com>
 <1298628663-27650-4-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:35540 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932514Ab1BYKO5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 05:14:57 -0500
Content-Disposition: inline
In-Reply-To: <1298628663-27650-4-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

On Fri, Feb 25, 2011 at 03:41:01PM +0530, Hema HK wrote:
> @@ -520,8 +524,8 @@ static int omap2430_resume(struct device *dev)
>  }
>  
>  static struct dev_pm_ops omap2430_pm_ops = {
> -	.suspend	= omap2430_suspend,
> -	.resume		= omap2430_resume,
> +	.runtime_suspend = omap2430_suspend,
> +	.runtime_resume = omap2430_resume,

while at that, please rename omap2430_suspend to
omap2430_runtime_suspend and omap2430_resume to omap2430_runtime_resume
just to keep consistency.

-- 
balbi
