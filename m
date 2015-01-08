From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] arm: omap2plus_defconfig: enable TPS65218 power
 button
Date: Wed, 7 Jan 2015 16:55:09 -0800
Message-ID: <20150108005508.GU13010@atomide.com>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-6-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40252 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbbAHA6z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2015 19:58:55 -0500
Content-Disposition: inline
In-Reply-To: <1419622104-25812-6-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [141226 11:31]:
> Enable tps65218 power button driver by default as
> a dynamically linked module so AM437x SK can report
> power button presses.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applying this into omap-for-v3.20/defconfig thanks.

Tony

> ---
>  arch/arm/configs/omap2plus_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index c2c3a85..f4a4b2f 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -183,6 +183,7 @@ CONFIG_TOUCHSCREEN_EDT_FT5X06=m
>  CONFIG_TOUCHSCREEN_TSC2005=m
>  CONFIG_TOUCHSCREEN_TSC2007=m
>  CONFIG_INPUT_MISC=y
> +CONFIG_INPUT_TPS65218_PWRBUTTON=m
>  CONFIG_INPUT_TWL4030_PWRBUTTON=y
>  # CONFIG_LEGACY_PTYS is not set
>  CONFIG_SERIAL_8250=y
> -- 
> 2.2.0
> 
