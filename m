From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 3/6] phy: core: Support regulator supply for PHY power
Date: Wed, 02 Jul 2014 16:32:18 +0400
Message-ID: <53B3FBD2.3090003@cogentembedded.com>
References: <1404302638-3003-1-git-send-email-rogerq@ti.com> <1404302638-3003-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:64797 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbaGBMcQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2014 08:32:16 -0400
Received: by mail-la0-f51.google.com with SMTP id mc6so6810904lab.24
        for <linux-omap@vger.kernel.org>; Wed, 02 Jul 2014 05:32:15 -0700 (PDT)
In-Reply-To: <1404302638-3003-4-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com, kishon@ti.com, balbi@ti.com
Cc: nsekhar@ti.com, nm@ti.com, george.cherian@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 07/02/2014 04:03 PM, Roger Quadros wrote:

> Some PHYs can be powered by an external power regulator.
> e.g. USB_HS PHY on DRA7 SoC. Make the PHY core support a
> power regulator.

> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   drivers/phy/phy-core.c  | 32 ++++++++++++++++++++++++++++++++
>   include/linux/phy/phy.h |  2 ++
>   2 files changed, 34 insertions(+)

> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 49c4465..d817107 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
[...]
> @@ -664,6 +689,10 @@ EXPORT_SYMBOL_GPL(devm_phy_create);
>   void phy_destroy(struct phy *phy)
>   {
>   	pm_runtime_disable(&phy->dev);
> +
> +	if (phy->pwr)
> +		regulator_put(phy->pwr);

    regulator_put() already handles NULL pointer.

> +
>   	device_unregister(&phy->dev);
>   }
>   EXPORT_SYMBOL_GPL(phy_destroy);
> @@ -800,6 +829,9 @@ static void phy_release(struct device *dev)
>
>   	phy = to_phy(dev);
>   	dev_vdbg(dev, "releasing '%s'\n", dev_name(dev));
> +	if (phy->pwr)
> +		regulator_put(phy->pwr);

    Same comment here.

> +
>   	ida_simple_remove(&phy_ida, phy->id);
>   	kfree(phy);
>   }

WBR, Sergei

