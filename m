From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/NOT FOR MERGING 1/3] arm: omap: use generic
	implementation if !od
Date: Thu, 14 Feb 2013 11:20:43 +0000
Message-ID: <20130214112043.GQ17852@n2100.arm.linux.org.uk>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42899 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756870Ab3BNLUu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 06:20:50 -0500
Content-Disposition: inline
In-Reply-To: <1360840554-26901-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Thu, Feb 14, 2013 at 01:15:52PM +0200, Felipe Balbi wrote:
>  	struct platform_device *pdev = to_platform_device(dev);
> +	struct omap_device *od = to_omap_device(pdev);
>  	int ret;
>  
>  	ret = pm_generic_runtime_suspend(dev);
>  
> +	if (!od)
> +		goto out;
> +
>  	if (!ret)

What's wrong with the single line change per function of:

-	if (!ret)
+	if (!ret && to_omap_device(pdev))

?

>  		omap_device_idle(pdev);
>  
> +out:
>  	return ret;
>  }
