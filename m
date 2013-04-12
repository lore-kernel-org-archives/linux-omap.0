From: Jyri Sarha <oku@iki.fi>
Subject: Re: [PATCH] ARM: OMAP4+: =?UTF-8?Q?omap=32plus=5Fdefconfig=3A=20Enable=20?=
 =?UTF-8?Q?audio=20via=20TWL=36=30=34=30=20as=20module?=
Date: Fri, 12 Apr 2013 15:14:44 +0300
Message-ID: <acf32629312b1315da0d04598a757673@mail.kapsi.fi>
References: <1365584880-25810-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:42677 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753077Ab3DLMOu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Apr 2013 08:14:50 -0400
In-Reply-To: <1365584880-25810-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Jyri Sarha <jsarha@ti.com>

On Wed, 10 Apr 2013 11:08:00 +0200, Peter Ujfalusi <peter.ujfalusi@ti.com>
wrote:
> Boards supported upstream all use TWL6040 as audio codec, enable the
common
> ASoC machine driver by default for them.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Jyri Sarha <jsarha@ti.com>

Brings a working PCM for TWL6040 trough McPDM legacy port on top of
8.3-rc3 for my Blaze and Panda.
> ---
>  arch/arm/configs/omap2plus_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig
> b/arch/arm/configs/omap2plus_defconfig
> index bd07864..eea501c 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -152,6 +152,7 @@ CONFIG_OMAP_WATCHDOG=y
>  CONFIG_TWL4030_WATCHDOG=y
>  CONFIG_MFD_TPS65217=y
>  CONFIG_MFD_TPS65910=y
> +CONFIG_TWL6040_CORE=y
>  CONFIG_REGULATOR_TWL4030=y
>  CONFIG_REGULATOR_TPS65023=y
>  CONFIG_REGULATOR_TPS6507X=y
> @@ -194,6 +195,7 @@ CONFIG_SND_USB_AUDIO=m
>  CONFIG_SND_SOC=m
>  CONFIG_SND_OMAP_SOC=m
>  CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
> +CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
>  CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
>  CONFIG_USB=y
>  CONFIG_USB_DEBUG=y
