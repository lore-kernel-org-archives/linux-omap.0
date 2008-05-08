From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: add RTC support to beagleboard
Date: Thu, 8 May 2008 18:55:47 +0200
Message-ID: <fb249edb0805080955h5222acdcy1fe8f3d83f251d43@mail.gmail.com>
References: <6996A016-47DB-45BF-8F78-8AD0051C4695@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:41545 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757743AbYEHQzw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 12:55:52 -0400
Received: by ug-out-1314.google.com with SMTP id h2so129166ugf.16
        for <linux-omap@vger.kernel.org>; Thu, 08 May 2008 09:55:49 -0700 (PDT)
In-Reply-To: <6996A016-47DB-45BF-8F78-8AD0051C4695@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap@vger.kernel.org, Khasim Syed Mohammed <khasim@ti.com>, Beagle Board <beagleboard@googlegroups.com>

On 08/05/2008, Koen Kooi <k.kooi@student.utwente.nl> wrote:
> This patch adds RTC support to the omap3 based beagleboard
>
>  Signed-off-by: Koen Kooi <koen@openembedded.org>
>  ---
>   arch/arm/mach-omap2/board-omap3beagle.c |   11
> +++++++++++
>   1 files changed, 11 insertions(+), 0 deletions(-)
>
>  diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
> b/arch/arm/mach-omap2/board-omap3beagle.c
>  index 626f004..e7b471b 100644
>  --- a/arch/arm/mach-omap2/board-omap3beagle.c
>  +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>  @@ -58,11 +58,22 @@ static struct omap_mmc_config omap3beagle_mmc_config
> __initdata = {
>         },
>   };
>
>  +static struct platform_device omap3_beagle_twl4030rtc_device = {
>  +       .name           = "twl4030_rtc",
>  +       .id             = -1,
>  +};
>  +
>   static struct omap_board_config_kernel omap3_beagle_config[] __initdata =
> {
>         { OMAP_TAG_UART,        &omap3_beagle_uart_config },
>         { OMAP_TAG_MMC,         &omap3beagle_mmc_config },
>   };
>
>  +static struct platform_device *omap3_beagle_devices[] __initdata = {
>  +#ifdef CONFIG_RTC_DRV_TWL4030
>  +       &omap3_beagle_twl4030rtc_device,
>  +#endif
>  +};
>  +
>   static void __init omap3_beagle_init(void)
>   {
>         omap_board_config = omap3_beagle_config;
>  --
>  1.5.4.3

Something must be missing here, omap3_beagle_devices is not being referenced.

The missing line probably looks something like
platform_add_devices(omap3_beagle_devices, ARRAY_SIZE(omap3_beagle_devices));

You can also add the #ifdef around omap3_beagle_twl4030rtc_device to
avoid a compiler warning, or drop it in both places.

Regards
-- 
Please do not print this email unless absolutely necessary. Spread
environmental awareness.
