From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/3] omap4: fix omap_type() function
Date: Sat, 10 Jul 2010 12:53:20 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6005AA8@dbde02.ent.ti.com>
References: <1278745713-31255-1-git-send-email-vikram.pandita@ti.com>
 <1278745713-31255-2-git-send-email-vikram.pandita@ti.com>
 <1278745713-31255-3-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51914 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030Ab0GJHX0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Jul 2010 03:23:26 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6A7NNN9020078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 10 Jul 2010 02:23:25 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o6A7NMF4005733
	for <linux-omap@vger.kernel.org>; Sat, 10 Jul 2010 12:53:23 +0530 (IST)
In-Reply-To: <1278745713-31255-3-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Pandita, Vikram
> Sent: Saturday, July 10, 2010 12:39 PM
> To: linux-omap@vger.kernel.org
> Cc: Pandita, Vikram
> Subject: [PATCH 2/3] omap4: fix omap_type() function
> 
> Following patch added the omap_type() functionality for omap4
> 	737daa03: omap4: Fix omap_type() for omap4
> 
> However the omap_type() function would not work as:
> 1) the base address for CONTROL_STATUS register is wrongly mapped
> 
As I already told you off the list, the address is not wrong. OMAP4 
has different bases for CORE and WAKEUP control modules.
Your patch will break the PBIAS of MMC straight a way.

NAK.

I have reported this issue to Tony when the mux framework 
was getting developed.

> 2) "Not yet supported" check for omap4 needs to be removed
> 
> Verified on OMAP4 SDP board
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/omap44xx.h |    2 +-
>  arch/arm/plat-omap/sram.c                  |    4 ----
>  2 files changed, 1 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-
> omap/include/plat/omap44xx.h
> index 8b3f12f..2075856 100644
> --- a/arch/arm/plat-omap/include/plat/omap44xx.h
> +++ b/arch/arm/plat-omap/include/plat/omap44xx.h
> @@ -33,7 +33,7 @@
>  #define OMAP4430_PRCM_MPU_BASE		0x48243000
>  #define OMAP44XX_GPMC_BASE		0x50000000
>  #define OMAP443X_SCM_BASE		0x4a002000
> -#define OMAP443X_CTRL_BASE		0x4a100000
> +#define OMAP443X_CTRL_BASE		0x4a002000
>  #define OMAP44XX_IC_BASE		0x48200000
>  #define OMAP44XX_IVA_INTC_BASE		0x40000000
>  #define IRQ_SIR_IRQ			0x0040
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index 2eb5a27..112b807 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -93,10 +93,6 @@ extern unsigned long omapfb_reserve_sram(unsigned long
> sram_pstart,
>   */
>  static int is_sram_locked(void)
>  {
> -	if (cpu_is_omap44xx())
> -		/* Not yet supported */
> -		return 0;
> -
>  	if (OMAP2_DEVICE_TYPE_GP == omap_type()) {
>  		/* RAMFW: R/W access to all initiators for all qualifier sets
> */
>  		if (cpu_is_omap242x()) {
> --
> 1.6.6.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
