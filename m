From: "shekhar, chandra" <x0044955@ti.com>
Subject: Re: [PATCH 1/3] [OMAPZOOM] Lower i2c speed on bus 1 for LDP.
Date: Thu, 13 Nov 2008 08:19:59 +0530
Message-ID: <062701c9453a$85ee81b0$LocalHost@wipultra806>
References: <200811121421.38438.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47157 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbYKMCuM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2008 21:50:12 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAD2o5aJ006885
	for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 20:50:11 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dominic Curran <dcurran@ti.com>, linux-omap@vger.kernel.org


----- Original Message ----- 
From: "Dominic Curran" <dcurran@ti.com>
To: <linux-omap@vger.kernel.org>
Sent: Thursday, November 13, 2008 1:51 AM
Subject: [PATCH 1/3] [OMAPZOOM] Lower i2c speed on bus 1 for LDP.


> Resending patch with more descriptive comment.
>
> Lower i2c bus 1 speed to 400KHz for LDP.
> At 2600KHz i2c reads from twl4030 keypad driver are returning
> incorrect data. Reason unknown. Lowering bus speed as temporary
> fix to get LDP keypad working.
>
> Signed-off-by: Dominic Curran <dcurran@ti.com>
> ---
> arch/arm/mach-omap2/board-ldp.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
> index d889ce8..b2e8c9c 100755
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -797,7 +797,7 @@ static struct i2c_board_info __initdata 
> ldp_i2c_boardinfo_2[] = {
>
> static int __init omap_i2c_init(void)
> {
> - omap_register_i2c_bus(1, 2600, ldp_i2c_boardinfo,
> + omap_register_i2c_bus(1, 400, ldp_i2c_boardinfo,
>  ARRAY_SIZE(ldp_i2c_boardinfo));


Last time i checked we were getting few errors (returning incorrect values) even 
at 400k , and no error at 100k.
Have you seen any at 400k?


>  omap_register_i2c_bus(2, 100, ldp_i2c_boardinfo_2,
>  ARRAY_SIZE(ldp_i2c_boardinfo_2));
> -- 
> 1.5.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

