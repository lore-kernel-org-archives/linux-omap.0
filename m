From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC part2 v1][PATCH 4/4] omap3: zoom 2/3: Change debugboard serial port id
Date: Mon, 01 Mar 2010 13:12:06 -0800
Message-ID: <87hbozbvbt.fsf@deeprootsystems.com>
References: <1267469754-10638-1-git-send-email-saaguirre@ti.com>
	<1267469754-10638-5-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52456 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab0CAVMJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Mar 2010 16:12:09 -0500
Received: by pwj8 with SMTP id 8so1918898pwj.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Mar 2010 13:12:08 -0800 (PST)
In-Reply-To: <1267469754-10638-5-git-send-email-saaguirre@ti.com> (Sergio Aguirre's message of "Mon\,  1 Mar 2010 12\:55\:54 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-omap@vger.kernel.org

Sergio Aguirre <saaguirre@ti.com> writes:

> This is now changed to PLAT8250_DEV_PLATFORM (= 0), because
> it is the only port that's going to be initted in Zoom 2/3 boards.
>
> So, it doesn't make sense to keep the hardcoded 3 value anymore.
>
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

In addition, when we switch to using omap-serial, this will be the
only 8250 driver (ttyS*), so it makes sense that it is zero.

Kevin


> --- arch/arm/mach-omap2/board-zoom-debugboard.c | 2 +- 1 files
> changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
> index bb4018b..e15d2e8 100644
> --- a/arch/arm/mach-omap2/board-zoom-debugboard.c
> +++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
> @@ -96,7 +96,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
>  
>  static struct platform_device zoom_debugboard_serial_device = {
>  	.name			= "serial8250",
> -	.id			= 3,
> +	.id			= PLAT8250_DEV_PLATFORM,
>  	.dev			= {
>  		.platform_data	= serial_platform_data,
>  	},
> -- 
> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
