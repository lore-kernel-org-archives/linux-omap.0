From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC part1/2 merge v2 RESEND][PATCH 09/10] omap3: zoom 2/3: Change debugboard serial port id
Date: Mon, 08 Mar 2010 09:59:12 -0800
Message-ID: <878wa2u233.fsf@deeprootsystems.com>
References: <1268069332-14082-1-git-send-email-saaguirre@ti.com>
	<1268069332-14082-10-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f198.google.com ([209.85.221.198]:52317 "EHLO
	mail-qy0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab0CHR7Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 12:59:16 -0500
Received: by qyk36 with SMTP id 36so4481102qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Mar 2010 09:59:14 -0800 (PST)
In-Reply-To: <1268069332-14082-10-git-send-email-saaguirre@ti.com> (Sergio Aguirre's message of "Mon\,  8 Mar 2010 11\:28\:51 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Sergio Aguirre <saaguirre@ti.com> writes:

> This is now changed to PLAT8250_DEV_PLATFORM (= 0), because
> it is the only port that's going to be initted in Zoom 2/3 boards.
                                         ^^^^^^^

minor nit: not a word.  :) please use the much harder to spell:
initialized.  ;)

Kevin

>
> So, it doesn't make sense to keep the hardcoded 3 value anymore.
>
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  arch/arm/mach-omap2/board-zoom-debugboard.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
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
