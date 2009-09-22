From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] [ARM] omap850: Fix wrong jtag_id.
Date: Tue, 22 Sep 2009 14:56:58 -0700
Message-ID: <20090922215658.GF4919@atomide.com>
References: <4AA1AA3B.7020007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65526 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbZIVV45 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 17:56:57 -0400
Content-Disposition: inline
In-Reply-To: <4AA1AA3B.7020007@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Angelo Arrifano <miknix@gmail.com>
Cc: linux-omap@vger.kernel.org, "Zebediah C. McClure" <zmc@lurian.net>

* Angelo Arrifano <miknix@gmail.com> [090904 16:56]:
> Original message:
> The previous value of the jtag_id was set for the omap730.  For the
> omap850, this value is different, and this was causing
> autodetection to fail.

Thanks, I've applied all three. Had to apply the first two manually
because of the warpping, please check.

Regards,

Tony

> 
> Reported-by:
>   Cory Maccarrone <darkstar6262@gmail.com>
>   Angelo Arrifano <miknix@gmail.com>
>   Alistair Buxton <a.j.buxton@gmail.com>
> 
> Signed-off-by: Angelo Arrifano <miknix@gmail.com>
> ---
>  arch/arm/mach-omap1/id.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
> index 4ef26fa..e5dcdf7 100644
> --- a/arch/arm/mach-omap1/id.c
> +++ b/arch/arm/mach-omap1/id.c
> @@ -38,7 +38,7 @@ static struct omap_id omap_ids[] __initdata = {
>  	{ .jtag_id = 0xb574, .die_rev = 0x2, .omap_id = 0x03310315, .type =
> 0x03100000},
>  	{ .jtag_id = 0x355f, .die_rev = 0x0, .omap_id = 0x03320000, .type =
> 0x07300100},
>  	{ .jtag_id = 0xb55f, .die_rev = 0x0, .omap_id = 0x03320000, .type =
> 0x07300300},
> -	{ .jtag_id = 0xb55f, .die_rev = 0x0, .omap_id = 0x03320500, .type =
> 0x08500000},
> +	{ .jtag_id = 0xb62c, .die_rev = 0x1, .omap_id = 0x03320500, .type =
> 0x08500000},
>  	{ .jtag_id = 0xb470, .die_rev = 0x0, .omap_id = 0x03310100, .type =
> 0x15100000},
>  	{ .jtag_id = 0xb576, .die_rev = 0x0, .omap_id = 0x03320000, .type =
> 0x16100000},
>  	{ .jtag_id = 0xb576, .die_rev = 0x2, .omap_id = 0x03320100, .type =
> 0x16110000},
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
