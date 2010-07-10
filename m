From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/3] omap: sram: fix is_sram_locked check
Date: Sat, 10 Jul 2010 12:57:16 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6005AAC@dbde02.ent.ti.com>
References: <1278745713-31255-1-git-send-email-vikram.pandita@ti.com>
 <1278745713-31255-2-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60426 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab0GJH1V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Jul 2010 03:27:21 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6A7RHif013393
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 10 Jul 2010 02:27:20 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o6A7RHXP006258
	for <linux-omap@vger.kernel.org>; Sat, 10 Jul 2010 12:57:17 +0530 (IST)
In-Reply-To: <1278745713-31255-2-git-send-email-vikram.pandita@ti.com>
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
> Subject: [PATCH 1/3] omap: sram: fix is_sram_locked check
> 
> For OMAP24xx/34xx/44xx: omap_type() returns the correct type:
>  OMAP2_DEVICE_TYPE_TEST
>  OMAP2_DEVICE_TYPE_EMU
>  OMAP2_DEVICE_TYPE_SEC
>  OMAP2_DEVICE_TYPE_GP
>  OMAP2_DEVICE_TYPE_BAD
> 
> In current implementation there are two problems:
> Problem 1:
> For 34xx, the current if check will never return true.
> 
> Problem 2:
> For 24xx the correct type check should be with omap_type() function
> Verified by checking the TRM 24xx for CONTROL_STATUS register bits
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  arch/arm/plat-omap/sram.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index 226b2e8..2eb5a27 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -93,16 +93,11 @@ extern unsigned long omapfb_reserve_sram(unsigned long
> sram_pstart,
>   */
>  static int is_sram_locked(void)
>  {
> -	int type = 0;
> -
>  	if (cpu_is_omap44xx())
>  		/* Not yet supported */
>  		return 0;
> 
> -	if (cpu_is_omap242x())
> -		type = omap_rev() & OMAP2_DEVICETYPE_MASK;
> -
> -	if (type == GP_DEVICE) {
> +	if (OMAP2_DEVICE_TYPE_GP == omap_type()) {
>  		/* RAMFW: R/W access to all initiators for all qualifier sets
> */
>  		if (cpu_is_omap242x()) {
>  			__raw_writel(0xFF, OMAP24XX_VA_REQINFOPERM0); /* all q-
> vects */
This one looks fine to me.
