From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: omap2plus_defconfig: enable OMAP DMA engine support
Date: Mon, 16 Jul 2012 10:12:28 -0700
Message-ID: <87bojfeikj.fsf@ti.com>
References: <1342321398-11009-1-git-send-email-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45699 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752799Ab2GPRMK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 13:12:10 -0400
Received: by ghbz2 with SMTP id z2so4843358ghb.6
        for <linux-omap@vger.kernel.org>; Mon, 16 Jul 2012 10:12:06 -0700 (PDT)
In-Reply-To: <1342321398-11009-1-git-send-email-javier@dowhile0.org> (Javier
	Martinez Canillas's message of "Sun, 15 Jul 2012 05:03:18 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Javier Martinez Canillas <javier@dowhile0.org> writes:

> commit 13f30fc893e4610f67dd7a8b0b67aec02eac1775
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Sat Apr 21 22:41:10 2012 +0100
>
>     mmc: omap: remove private DMA API implementation
>
> removed the private DMA API implementation from the OMAP mmc host to
> make it use exclusively the DMA engine API.
>
> Unfortunately the omap2plus_defconfig doesn't enable this feature
> leading to the following error on an IGEPv2 Rev.C (and probably on most
> boards with MMC support):

Personally, I'd rather see this fixed by having the drivers that depend
on DMA engine 'select DMADEVICES'.  That way, any defconfig will work
correctly instead of just omap2plus_defconfig.

Kevin

> [    2.199981] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
> [    2.215087] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62
>
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> ---
>  arch/arm/configs/omap2plus_defconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index b152de7..e58edc3 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -193,6 +193,8 @@ CONFIG_MMC_OMAP_HS=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_TWL92330=y
>  CONFIG_RTC_DRV_TWL4030=y
> +CONFIG_DMADEVICES=y
> +CONFIG_DMA_OMAP=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
>  # CONFIG_EXT3_FS_XATTR is not set
