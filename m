From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/6] omap4: powerdomain: Add supported INACTIVE power state
Date: Tue, 01 Feb 2011 17:19:10 -0800
Message-ID: <87pqrbmdwx.fsf@ti.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
	<1296212688-21951-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:55972 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020Ab1BBBTP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 20:19:15 -0500
Received: by yia25 with SMTP id 25so3441440yia.0
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 17:19:14 -0800 (PST)
In-Reply-To: <1296212688-21951-2-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Fri, 28 Jan 2011 16:34:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On OMAP4, one can explicitly program INACTIVE as the power state of
> the logic area inside the power domain. Techincally PD state programmed
> to ON and if all the clock domains within the PD are idled, is equivalent
> tp PD programmed to INACTIVE and all the clock domains within the PD are
> idled. There won't be any power difference in above two.
>
> Since the CPUIDLE C-states explicitly make use of INACTIVE as a PD
> targeted state 

I think you're referring to code that is not upstream here.  I'm not
aware of any C-states targetting INACTIVE.

Kevin

> and also there is some additional latancy involved
> with PD INACTIVE vs PD ON, it's better to support it as an explcit
> PD state.
>
> This patch adds the support to allow explicit PD INACTIVE
> programming if supported.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/powerdomain.h           |   12 ++++++++++++
>  arch/arm/mach-omap2/powerdomains44xx_data.c |   26 +++++++++++++-------------
>  2 files changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
> index c66431e..0e15ca7 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -46,6 +46,18 @@
>  
>  #define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | (1 << PWRDM_POWER_ON))
>  
> +#define PWRSTS_RET_INA_ON	((1 << PWRDM_POWER_RET) | \
> +				 (1 << PWRDM_POWER_INACTIVE)  | \
> +				 (1 << PWRDM_POWER_ON))
> +
> +#define PWRSTS_OFF_INA_ON	((1 << PWRDM_POWER_OFF) | \
> +				 (1 << PWRDM_POWER_INACTIVE)  | \
> +				 (1 << PWRDM_POWER_ON))
> +
> +#define PWRSTS_OFF_RET_INA_ON	((1 << PWRDM_POWER_OFF) | \
> +				 (1 << PWRDM_POWER_RET) | \
> +				 (1 << PWRDM_POWER_INACTIVE)  | \
> +				 (1 << PWRDM_POWER_ON))
>  
>  /* Powerdomain flags */
>  #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware save-and-restore support */
> diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
> index 26d7641..96cde98 100644
> --- a/arch/arm/mach-omap2/powerdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
> @@ -36,7 +36,7 @@ static struct powerdomain core_44xx_pwrdm = {
>  	.prcm_offs	  = OMAP4430_PRM_CORE_INST,
>  	.prcm_partition	  = OMAP4430_PRM_PARTITION,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> -	.pwrsts		  = PWRSTS_RET_ON,
> +	.pwrsts		  = PWRSTS_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 5,
>  	.pwrsts_mem_ret	= {
> @@ -62,7 +62,7 @@ static struct powerdomain gfx_44xx_pwrdm = {
>  	.prcm_offs	  = OMAP4430_PRM_GFX_INST,
>  	.prcm_partition	  = OMAP4430_PRM_PARTITION,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> -	.pwrsts		  = PWRSTS_OFF_ON,
> +	.pwrsts		  = PWRSTS_OFF_INA_ON,
>  	.banks		  = 1,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRDM_POWER_OFF,	/* gfx_mem */
> @@ -79,7 +79,7 @@ static struct powerdomain abe_44xx_pwrdm = {
>  	.prcm_offs	  = OMAP4430_PRM_ABE_INST,
>  	.prcm_partition	  = OMAP4430_PRM_PARTITION,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRDM_POWER_OFF,
>  	.banks		  = 2,
>  	.pwrsts_mem_ret	= {
> @@ -99,7 +99,7 @@ static struct powerdomain dss_44xx_pwrdm = {
>  	.prcm_offs	  = OMAP4430_PRM_DSS_INST,
>  	.prcm_partition	  = OMAP4430_PRM_PARTITION,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF,
>  	.banks		  = 1,
>  	.pwrsts_mem_ret	= {
> @@ -117,7 +117,7 @@ static struct powerdomain tesla_44xx_pwrdm = {
>  	.prcm_offs	  = OMAP4430_PRM_TESLA_INST,
>  	.prcm_partition	  = OMAP4430_PRM_PARTITION,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 3,
>  	.pwrsts_mem_ret	= {
> @@ -155,7 +155,7 @@ static struct powerdomain cpu0_44xx_pwrdm = {
>  	.prcm_offs	  = OMAP4430_PRCM_MPU_CPU0_INST,
>  	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 1,
>  	.pwrsts_mem_ret	= {
> @@ -172,7 +172,7 @@ static struct powerdomain cpu1_44xx_pwrdm = {
>  	.prcm_offs	  = OMAP4430_PRCM_MPU_CPU1_INST,
>  	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 1,
>  	.pwrsts_mem_ret	= {
> @@ -205,7 +205,7 @@ static struct powerdomain mpu_44xx_pwrdm = {
>  	.prcm_offs	  = OMAP4430_PRM_MPU_INST,
>  	.prcm_partition	  = OMAP4430_PRM_PARTITION,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 3,
>  	.pwrsts_mem_ret	= {
> @@ -226,7 +226,7 @@ static struct powerdomain ivahd_44xx_pwrdm = {
>  	.prcm_offs	  = OMAP4430_PRM_IVAHD_INST,
>  	.prcm_partition	  = OMAP4430_PRM_PARTITION,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRDM_POWER_OFF,
>  	.banks		  = 4,
>  	.pwrsts_mem_ret	= {
> @@ -250,7 +250,7 @@ static struct powerdomain cam_44xx_pwrdm = {
>  	.prcm_offs	  = OMAP4430_PRM_CAM_INST,
>  	.prcm_partition	  = OMAP4430_PRM_PARTITION,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> -	.pwrsts		  = PWRSTS_OFF_ON,
> +	.pwrsts		  = PWRSTS_OFF_INA_ON,
>  	.banks		  = 1,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRDM_POWER_OFF,	/* cam_mem */
> @@ -267,7 +267,7 @@ static struct powerdomain l3init_44xx_pwrdm = {
>  	.prcm_offs	  = OMAP4430_PRM_L3INIT_INST,
>  	.prcm_partition	  = OMAP4430_PRM_PARTITION,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> -	.pwrsts		  = PWRSTS_RET_ON,
> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 1,
>  	.pwrsts_mem_ret	= {
> @@ -285,7 +285,7 @@ static struct powerdomain l4per_44xx_pwrdm = {
>  	.prcm_offs	  = OMAP4430_PRM_L4PER_INST,
>  	.prcm_partition	  = OMAP4430_PRM_PARTITION,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> -	.pwrsts		  = PWRSTS_RET_ON,
> +	.pwrsts		  = PWRSTS_RET_INA_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 2,
>  	.pwrsts_mem_ret	= {
> @@ -317,7 +317,7 @@ static struct powerdomain cefuse_44xx_pwrdm = {
>  	.prcm_offs	  = OMAP4430_PRM_CEFUSE_INST,
>  	.prcm_partition	  = OMAP4430_PRM_PARTITION,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> -	.pwrsts		  = PWRSTS_OFF_ON,
> +	.pwrsts		  = PWRSTS_OFF_INA_ON,
>  };
>  
>  /*
