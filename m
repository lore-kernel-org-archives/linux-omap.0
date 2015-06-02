From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Enable TOUCHSCREEN_PIXCIR
Date: Tue, 2 Jun 2015 07:55:25 -0700
Message-ID: <20150602145525.GL30984@atomide.com>
References: <1433238311-12990-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55371 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756353AbbFBOz1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jun 2015 10:55:27 -0400
Content-Disposition: inline
In-Reply-To: <1433238311-12990-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [150602 02:46]:
> Some of the OMAP based boards e.g. am437x-gp-evm have
> the Pixcir touch controller. Enable the related device
> driver.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/configs/omap2plus_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 3743ca2..45cdeb8 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -204,6 +204,7 @@ CONFIG_KEYBOARD_TWL4030=m
>  CONFIG_INPUT_TOUCHSCREEN=y
>  CONFIG_TOUCHSCREEN_ADS7846=m
>  CONFIG_TOUCHSCREEN_EDT_FT5X06=m
> +CONFIG_TOUCHSCREEN_PIXCIR=m
>  CONFIG_TOUCHSCREEN_TSC2005=m
>  CONFIG_TOUCHSCREEN_TSC2007=m
>  CONFIG_INPUT_MISC=y

Applying into omap-for-v4.2/defconfig thanks.

Tony
