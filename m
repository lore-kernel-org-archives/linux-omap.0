From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] arm: omap4: panda: remove usb_nop_xceiv_register
Date: Tue, 04 Jan 2011 16:29:04 -0800
Message-ID: <87ipy442i7.fsf@ti.com>
References: <1294148397-26582-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:34981 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750919Ab1AEA3I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 19:29:08 -0500
Received: by pwj8 with SMTP id 8so2992793pwj.22
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 16:29:07 -0800 (PST)
In-Reply-To: <1294148397-26582-1-git-send-email-tom.leiming@gmail.com> (tom
	leiming's message of "Tue, 4 Jan 2011 21:39:57 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tom.leiming@gmail.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

tom.leiming@gmail.com writes:

> From: Ming Lei <tom.leiming@gmail.com>
>
> Panda uses twl6030 otg phy instead of internal phy,
> so removes usb_nop_xceiv_register to make musb working.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

Please Cc the linux-arm-kernel list for OMAP kernel patches targetted
for upstream.

Also, would be nice to get some Reviewed-by and/or Tested-by tags from
Panda users on this one as well.

Kevin

> ---
>  arch/arm/mach-omap2/board-omap4panda.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index 1ecd0a6..802ae20 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -374,8 +374,6 @@ static void __init omap4_panda_init(void)
>  	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
>  	omap_serial_init();
>  	omap4_twl6030_hsmmc_init(mmc);
> -	/* OMAP4 Panda uses internal transceiver so register nop transceiver */
> -	usb_nop_xceiv_register();
>  	omap4_ehci_init();
>  	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
>  	if (!cpu_is_omap44xx())
