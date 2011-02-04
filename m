From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 11/13] OMAP2PLUS: Replace voltage values with Macros
Date: Fri, 04 Feb 2011 08:44:15 -0800
Message-ID: <87zkqbrbq8.fsf@ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<1295618465-15234-12-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:34387 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751812Ab1BDQoT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 11:44:19 -0500
Received: by pwj6 with SMTP id 6so598386pwj.12
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 08:44:18 -0800 (PST)
In-Reply-To: <1295618465-15234-12-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Fri, 21 Jan 2011 19:31:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org

Vishwanath BS <vishwanath.bs@ti.com> writes:

> Currently voltage values on opp tables are hardcoded. As these voltage values
> are anyway defined in voltage.h as macros, opp table can reuse these values.
> This will avoid opp table and voltage layer having conflicting values.

ok

> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> This patch has 2 line over 80 char warning. This is kept for readability
> purpose.

This comment should be after the '---'

Kevin

> ---
>  arch/arm/mach-omap2/opp3xxx_data.c |   47 ++++++++++++++++++-----------------
>  arch/arm/mach-omap2/opp4xxx_data.c |   13 +++++----
>  2 files changed, 31 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
> index 0486fce..eefd6af 100644
> --- a/arch/arm/mach-omap2/opp3xxx_data.c
> +++ b/arch/arm/mach-omap2/opp3xxx_data.c
> @@ -19,20 +19,21 @@
>  #include <linux/module.h>
>  
>  #include <plat/cpu.h>
> +#include <plat/voltage.h>
>  
>  #include "omap_opp_data.h"
>  
>  static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
>  	/* MPU OPP1 */
> -	OPP_INITIALIZER("mpu", true, 125000000, 975000),
> +	OPP_INITIALIZER("mpu", true, 125000000, OMAP3430_VDD_MPU_OPP1_UV),
>  	/* MPU OPP2 */
> -	OPP_INITIALIZER("mpu", true, 250000000, 1075000),
> +	OPP_INITIALIZER("mpu", true, 250000000, OMAP3430_VDD_MPU_OPP2_UV),
>  	/* MPU OPP3 */
> -	OPP_INITIALIZER("mpu", true, 500000000, 1200000),
> +	OPP_INITIALIZER("mpu", true, 500000000, OMAP3430_VDD_MPU_OPP3_UV),
>  	/* MPU OPP4 */
> -	OPP_INITIALIZER("mpu", true, 550000000, 1270000),
> +	OPP_INITIALIZER("mpu", true, 550000000, OMAP3430_VDD_MPU_OPP4_UV),
>  	/* MPU OPP5 */
> -	OPP_INITIALIZER("mpu", true, 600000000, 1350000),
> +	OPP_INITIALIZER("mpu", true, 600000000, OMAP3430_VDD_MPU_OPP5_UV),
>  
>  	/*
>  	 * L3 OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
> @@ -42,47 +43,47 @@ static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
>  	 * impact that frequency will do to the MPU and the whole system in
>  	 * general.
>  	 */
> -	OPP_INITIALIZER("l3_main", false, 41500000, 975000),
> +	OPP_INITIALIZER("l3_main", false, 41500000, OMAP3430_VDD_CORE_OPP1_UV),
>  	/* L3 OPP2 */
> -	OPP_INITIALIZER("l3_main", true, 83000000, 1050000),
> +	OPP_INITIALIZER("l3_main", true, 83000000, OMAP3430_VDD_CORE_OPP2_UV),
>  	/* L3 OPP3 */
> -	OPP_INITIALIZER("l3_main", true, 166000000, 1150000),
> +	OPP_INITIALIZER("l3_main", true, 166000000, OMAP3430_VDD_CORE_OPP3_UV),
>  
>  	/* DSP OPP1 */
> -	OPP_INITIALIZER("iva", true, 90000000, 975000),
> +	OPP_INITIALIZER("iva", true, 90000000, OMAP3430_VDD_MPU_OPP1_UV),
>  	/* DSP OPP2 */
> -	OPP_INITIALIZER("iva", true, 180000000, 1075000),
> +	OPP_INITIALIZER("iva", true, 180000000, OMAP3430_VDD_MPU_OPP2_UV),
>  	/* DSP OPP3 */
> -	OPP_INITIALIZER("iva", true, 360000000, 1200000),
> +	OPP_INITIALIZER("iva", true, 360000000, OMAP3430_VDD_MPU_OPP3_UV),
>  	/* DSP OPP4 */
> -	OPP_INITIALIZER("iva", true, 400000000, 1270000),
> +	OPP_INITIALIZER("iva", true, 400000000, OMAP3430_VDD_MPU_OPP4_UV),
>  	/* DSP OPP5 */
> -	OPP_INITIALIZER("iva", true, 430000000, 1350000),
> +	OPP_INITIALIZER("iva", true, 430000000, OMAP3430_VDD_MPU_OPP5_UV),
>  };
>  
>  static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
>  	/* MPU OPP1 - OPP50 */
> -	OPP_INITIALIZER("mpu", true,  300000000, 1012500),
> +	OPP_INITIALIZER("mpu", true,  300000000, OMAP3630_VDD_MPU_OPP50_UV),
>  	/* MPU OPP2 - OPP100 */
> -	OPP_INITIALIZER("mpu", true,  600000000, 1200000),
> +	OPP_INITIALIZER("mpu", true,  600000000, OMAP3630_VDD_MPU_OPP100_UV),
>  	/* MPU OPP3 - OPP-Turbo */
> -	OPP_INITIALIZER("mpu", false, 800000000, 1325000),
> +	OPP_INITIALIZER("mpu", false, 800000000, OMAP3630_VDD_MPU_OPP120_UV),
>  	/* MPU OPP4 - OPP-SB */
> -	OPP_INITIALIZER("mpu", false, 1000000000, 1375000),
> +	OPP_INITIALIZER("mpu", false, 1000000000, OMAP3630_VDD_MPU_OPP1G_UV),
>  
>  	/* L3 OPP1 - OPP50 */
> -	OPP_INITIALIZER("l3_main", true, 100000000, 1000000),
> +	OPP_INITIALIZER("l3_main", true, 100000000, OMAP3630_VDD_CORE_OPP50_UV),
>  	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
> -	OPP_INITIALIZER("l3_main", true, 200000000, 1200000),
> +	OPP_INITIALIZER("l3_main", true, 200000000, OMAP3630_VDD_CORE_OPP100_UV),
>  
>  	/* DSP OPP1 - OPP50 */
> -	OPP_INITIALIZER("iva", true,  260000000, 1012500),
> +	OPP_INITIALIZER("iva", true,  260000000, OMAP3630_VDD_MPU_OPP50_UV),
>  	/* DSP OPP2 - OPP100 */
> -	OPP_INITIALIZER("iva", true,  520000000, 1200000),
> +	OPP_INITIALIZER("iva", true,  520000000, OMAP3630_VDD_MPU_OPP100_UV),
>  	/* DSP OPP3 - OPP-Turbo */
> -	OPP_INITIALIZER("iva", false, 660000000, 1325000),
> +	OPP_INITIALIZER("iva", false, 660000000, OMAP3630_VDD_MPU_OPP120_UV),
>  	/* DSP OPP4 - OPP-SB */
> -	OPP_INITIALIZER("iva", false, 800000000, 1375000),
> +	OPP_INITIALIZER("iva", false, 800000000, OMAP3630_VDD_MPU_OPP1G_UV),
>  };
>  
>  /**
> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
> index a11fa56..80d08bc 100644
> --- a/arch/arm/mach-omap2/opp4xxx_data.c
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -20,22 +20,23 @@
>  #include <linux/module.h>
>  
>  #include <plat/cpu.h>
> +#include <plat/voltage.h>
>  
>  #include "omap_opp_data.h"
>  
>  static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
>  	/* MPU OPP1 - OPP50 */
> -	OPP_INITIALIZER("mpu", true, 300000000, 1100000),
> +	OPP_INITIALIZER("mpu", true, 300000000, OMAP4430_VDD_MPU_OPP50_UV),
>  	/* MPU OPP2 - OPP100 */
> -	OPP_INITIALIZER("mpu", true, 600000000, 1200000),
> +	OPP_INITIALIZER("mpu", true, 600000000, OMAP4430_VDD_MPU_OPP100_UV),
>  	/* MPU OPP3 - OPP-Turbo */
> -	OPP_INITIALIZER("mpu", false, 800000000, 1260000),
> +	OPP_INITIALIZER("mpu", false, 800000000, OMAP4430_VDD_MPU_OPPTURBO_UV),
>  	/* MPU OPP4 - OPP-SB */
> -	OPP_INITIALIZER("mpu", false, 1008000000, 1350000),
> +	OPP_INITIALIZER("mpu", false, 1008000000, OMAP4430_VDD_MPU_OPPNITRO_UV),
>  	/* L3 OPP1 - OPP50 */
> -	OPP_INITIALIZER("l3_main_1", true, 100000000, 930000),
> +	OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4430_VDD_CORE_OPP50_UV),
>  	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
> -	OPP_INITIALIZER("l3_main_1", true, 200000000, 1100000),
> +	OPP_INITIALIZER("l3_main_1", true, 200000000, OMAP4430_VDD_CORE_OPP100_UV),
>  	/* TODO: add IVA, DSP, aess, fdif, gpu */
>  };
