From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: add RTC support to beagleboard
Date: Thu, 8 May 2008 09:53:50 -0700
Message-ID: <5e088bd90805080953k3e705a8kdb8ebb5e861a502d@mail.gmail.com>
References: <6996A016-47DB-45BF-8F78-8AD0051C4695@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:13314 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932344AbYEHQxw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 12:53:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so567537fgg.17
        for <linux-omap@vger.kernel.org>; Thu, 08 May 2008 09:53:50 -0700 (PDT)
In-Reply-To: <6996A016-47DB-45BF-8F78-8AD0051C4695@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap@vger.kernel.org, Khasim Syed Mohammed <khasim@ti.com>, Beagle Board <beagleboard@googlegroups.com>

I've reviewed this patch and based upon my experience with the OMAP3
EVM believe it should also work on the beagleboard.

Acked-by: Steve Sakoman <steve@sakoman.com>

On Thu, May 8, 2008 at 9:35 AM, Koen Kooi <k.kooi@student.utwente.nl> wrote:
> This patch adds RTC support to the omap3 based beagleboard
>
>  Signed-off-by: Koen Kooi <koen@openembedded.org>
>  ---
>   arch/arm/mach-omap2/board-omap3beagle.c |   11 +++++++++++
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
>
>
>  --
>  To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
