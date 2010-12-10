From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/5 v4] usb: musb: Using runtime pm APIs for musb.
Date: Fri, 10 Dec 2010 14:59:58 +0200
Message-ID: <20101210125958.GK6027@legolas.emea.dhcp.ti.com>
References: <1291985626-27174-1-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:60734 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756269Ab0LJNAD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 08:00:03 -0500
Content-Disposition: inline
In-Reply-To: <1291985626-27174-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Fri, Dec 10, 2010 at 06:23:46PM +0530, Hema HK wrote:
>@@ -429,28 +392,29 @@ static int __init omap2430_probe(struct
> 			pdev->num_resources);
> 	if (ret) {
> 		dev_err(&pdev->dev, "failed to add resources\n");
>-		goto err4;
>+		goto err2;
> 	}
>
> 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
> 	if (ret) {
> 		dev_err(&pdev->dev, "failed to add platform_data\n");
>-		goto err4;
>+		goto err2;
> 	}
>
> 	ret = platform_device_add(musb);
> 	if (ret) {
> 		dev_err(&pdev->dev, "failed to register musb device\n");
>-		goto err4;
>+		goto err2;
> 	}
>
>-	return 0;
>+	pm_runtime_enable(&pdev->dev);
>+	if (pm_runtime_get_sync(dev)) {
>+		dev_err(dev, "pm_runtime_get_sync FAILED");
>+		goto err2;
>+	}

don't you have to pm_runtime_disable() if get_sync fails ?

>@@ -468,8 +432,7 @@ static int __exit omap2430_remove(struct
>
> 	platform_device_del(glue->musb);
> 	platform_device_put(glue->musb);
>-	clk_disable(glue->clk);
>-	clk_put(glue->clk);
>+	pm_runtime_put_sync(&pdev->dev);

same here, don't you need to pm_runtime_disable() ??

-- 
balbi
