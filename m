From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC part2 v1][PATCH 2/4] omap3: zoom2/3 / 3630sdp: Don't init always all uarts
Date: Mon, 01 Mar 2010 13:12:42 -0800
Message-ID: <87bpf7bvat.fsf@deeprootsystems.com>
References: <1267469754-10638-1-git-send-email-saaguirre@ti.com>
	<1267469754-10638-3-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f179.google.com ([209.85.222.179]:45756 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab0CAVMp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Mar 2010 16:12:45 -0500
Received: by pzk9 with SMTP id 9so2245604pzk.25
        for <linux-omap@vger.kernel.org>; Mon, 01 Mar 2010 13:12:44 -0800 (PST)
In-Reply-To: <1267469754-10638-3-git-send-email-saaguirre@ti.com> (Sergio Aguirre's message of "Mon\,  1 Mar 2010 12\:55\:52 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-omap@vger.kernel.org

Sergio Aguirre <saaguirre@ti.com> writes:

> This is useless, since in Zoom2/3 boards, the ports aren't even
> physically accessible.
>
> They must be explicitly initted in the board-zoom2.c, board-zoom3.c
> and board-3630sdp.c files instead.
>
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>

/me likes

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index a1011ee..6b39849 100644
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -280,7 +280,6 @@ static void enable_board_wakeup_source(void)
>  void __init zoom_peripherals_init(void)
>  {
>  	omap_i2c_init();
> -	omap_serial_init_allports();
>  	usb_musb_init(&musb_board_data);
>  	enable_board_wakeup_source();
>  }
> -- 
> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
