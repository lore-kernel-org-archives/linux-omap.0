From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH 1/3] omap4: Add platform changes for Ambient Light sensor
Date: Mon, 13 Dec 2010 11:38:26 +0530
Message-ID: <3DF2192837DC438680A0D92C4C5C8A19@wipblrx0099946>
References: <54105.10.24.255.17.1291274954.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45895 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab0LMGIc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 01:08:32 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id oBD68Sbd029140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 00:08:31 -0600
Received: from wipblrx0099946 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with SMTP id oBD68Rru012713
	for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 11:38:28 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

----- Original Message ----- 
From: "Hemanth V" <hemanthv@ti.com>
To: <linux-omap@vger.kernel.org>
Sent: Thursday, December 02, 2010 12:59 PM
Subject: [PATCH 1/3] omap4: Add platform changes for Ambient Light sensor


> From 10f5f9f918e197f4052ac66b4e4cfb4b72646878 Mon Sep 17 00:00:00 2001
> From: Hemanth V <hemanthv@ti.com>
> Date: Wed, 1 Dec 2010 16:28:51 +0530
> Subject: [PATCH] omap4: Add platform changes for Ambient Light sensor
>
> Register BH1780GLI Ambient light sensor, which is an I2C device
> for 4430SDP board.

Tony, would you be pulling these patches for the next merge window.

Thanks
Hemanth

>
> Signed-off-by: Hemanth V <hemanthv@ti.com>
> ---
> BH1780GLI Driver is part of mainline kernel
>
> arch/arm/mach-omap2/board-4430sdp.c |    3 +++
> 1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c 
> b/arch/arm/mach-omap2/board-4430sdp.c
> index 49b5a7b..d8ef903 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -465,6 +465,9 @@ static struct i2c_board_info __initdata 
> sdp4430_i2c_3_boardinfo[] = {
>  {
>  I2C_BOARD_INFO("tmp105", 0x48),
>  },
> + {
> + I2C_BOARD_INFO("bh1780", 0x29),
> + },
> };
> static struct i2c_board_info __initdata sdp4430_i2c_4_boardinfo[] = {
>  {
> -- 
> 1.5.4.3
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

