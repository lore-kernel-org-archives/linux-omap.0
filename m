From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND] arm: omap2plus_defconfig: enable AM33xx SOC EVM
 audio
Date: Wed, 8 Jan 2014 11:18:20 -0800
Message-ID: <20140108191820.GB31323@atomide.com>
References: <cover.1383639261.git.jsarha@ti.com>
 <481115f4e0c15e22f0fa61f1f013fd2851e2737a.1383639261.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19976 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882AbaAHTSY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jan 2014 14:18:24 -0500
Content-Disposition: inline
In-Reply-To: <481115f4e0c15e22f0fa61f1f013fd2851e2737a.1383639261.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: linux-omap@vger.kernel.org

* Jyri Sarha <jsarha@ti.com> [131105 00:43]:
> Modifying the omap2plus_defconfig to enable the audio support for
> AM335x EVM and other AM33xx based devices with TLV320AIC3X connected
> to McASP.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>

Thanks applying into omap-for-v3.14/fixes-not-urgent.

Tony

> ---
>  arch/arm/configs/omap2plus_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 254cf05..4443b92 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -210,6 +210,8 @@ CONFIG_SND_DEBUG=y
>  CONFIG_SND_USB_AUDIO=m
>  CONFIG_SND_SOC=m
>  CONFIG_SND_OMAP_SOC=m
> +CONFIG_SND_AM33XX_SOC_EVM=m
> +CONFIG_SND_DAVINCI_SOC=m
>  CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
>  CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
>  CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
> -- 
