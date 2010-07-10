From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/3] omap4: SRAM start and size change for EMU/HS devices
Date: Sat, 10 Jul 2010 12:55:34 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6005AAA@dbde02.ent.ti.com>
References: <1278745713-31255-1-git-send-email-vikram.pandita@ti.com>
 <1278745713-31255-2-git-send-email-vikram.pandita@ti.com>
 <1278745713-31255-3-git-send-email-vikram.pandita@ti.com>
 <1278745713-31255-4-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60404 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab0GJHZm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Jul 2010 03:25:42 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6A7Pa7a013366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 10 Jul 2010 02:25:39 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o6A7PaVm006063
	for <linux-omap@vger.kernel.org>; Sat, 10 Jul 2010 12:55:36 +0530 (IST)
In-Reply-To: <1278745713-31255-4-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Vikram Pandita
> Sent: Saturday, July 10, 2010 12:39 PM
> To: linux-omap@vger.kernel.org
> Cc: Pandita, Vikram
> Subject: [PATCH 3/3] omap4: SRAM start and size change for EMU/HS devices
> 
> On OMAP4 the SRAM configuration is:
> GP Device:
>         Start Address: 0x4030 0000
>         Size: 0xE000 (56KB)
> 
> EMU/HS Device:
>         Start Address: 0x4030 4000
>         Size: 0xA000 (40KB)
> 
> Implement this mapping in the sram file
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  arch/arm/plat-omap/sram.c |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index 112b807..3c7c9a6 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -53,7 +53,7 @@
>  #define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
>  #define OMAP4_SRAM_PUB_VA	(OMAP4_SRAM_VA + 0x4000)
> 
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP2PLUS)
Only this line needs to be added in this patch
>  #define SRAM_BOOTLOADER_SZ	0x00
>  #else
>  #define SRAM_BOOTLOADER_SZ	0x80
> @@ -134,9 +134,18 @@ void __init omap_detect_sram(void)
>  					omap_sram_size = 0x8000; /* 32K */
>  				}
>  			} else if (cpu_is_omap44xx()) {
> -				omap_sram_base = OMAP4_SRAM_PUB_VA;
> -				omap_sram_start = OMAP4_SRAM_PUB_PA;
> -				omap_sram_size = 0xa000; /* 40K */
> +				if ((omap_type() == OMAP2_DEVICE_TYPE_EMU) ||
> +				    (omap_type() == OMAP2_DEVICE_TYPE_SEC)) {
> +					/* 40K For Public SRAM */
> +					omap_sram_base = OMAP4_SRAM_PUB_VA;
> +					omap_sram_start = OMAP4_SRAM_PUB_PA;
> +					omap_sram_size = 0xA000;
> +				} else {
> +					/* 56 KB SRAM on GP device */
> +					omap_sram_base = OMAP4_SRAM_VA;
> +					omap_sram_start = OMAP4_SRAM_PA;
> +					omap_sram_size = 0xE000;

Not necessary. If the "is_sram_locked" retunrs the correct retun value then this already handled.

Just look below the else part which handles the GP and if already has EMU size.
> +				}
>  			} else {
>  				omap_sram_base = OMAP2_SRAM_PUB_VA;
>  				omap_sram_start = OMAP2_SRAM_PUB_PA;
> --
> 1.6.6.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
