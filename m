From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/5] OMAP4: powerdomain: add context_offset field
Date: Wed, 22 Sep 2010 00:13:14 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009220008560.21002@utopia.booyaka.com>
References: <1284641906-24231-1-git-send-email-rnayak@ti.com> <1284641906-24231-2-git-send-email-rnayak@ti.com> <1284641906-24231-3-git-send-email-rnayak@ti.com> <1284641906-24231-4-git-send-email-rnayak@ti.com> <1284641906-24231-5-git-send-email-rnayak@ti.com>
 <1284641906-24231-6-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51808 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab0IVGNP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 02:13:15 -0400
In-Reply-To: <1284641906-24231-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hello Santosh, Rajendra,

a few comments on this patch:

On Thu, 16 Sep 2010, Rajendra Nayak wrote:

> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Context register in various power domain is not at same offset
> on OMAP4. Mainly the CPUx context resgiters againts rest of
> them. This patch adds a field in power-domain strucures to handle
> this.
> 
> This will be needed to make "pwrdm_clear_all_prev_pwrst" API work on
> OMAP4.

Is the powerdomain.c code that uses context_offset ready yet?  If not, 
it seems best to submit this together with the code that uses it?

> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/powerdomains44xx.h        |   14 ++++++++++++++
>  arch/arm/plat-omap/include/plat/powerdomain.h |    1 +
>  2 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomains44xx.h b/arch/arm/mach-omap2/powerdomains44xx.h
> index 9c01b55..65e919b 100644
> --- a/arch/arm/mach-omap2/powerdomains44xx.h
> +++ b/arch/arm/mach-omap2/powerdomains44xx.h
> @@ -40,6 +40,7 @@ static struct powerdomain core_44xx_pwrdm = {
>  	.pwrsts		  = PWRSTS_RET_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 5,
> +	.context_offset	  = 0x24,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRDM_POWER_OFF,	/* core_nret_bank */
>  		[1] = PWRSTS_OFF_RET,	/* core_ocmram */
> @@ -64,6 +65,7 @@ static struct powerdomain gfx_44xx_pwrdm = {
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>  	.pwrsts		  = PWRSTS_OFF_ON,
>  	.banks		  = 1,
> +	.context_offset	  = 0x24,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRDM_POWER_OFF,	/* gfx_mem */
>  	},
> @@ -81,6 +83,7 @@ static struct powerdomain abe_44xx_pwrdm = {
>  	.pwrsts		  = PWRSTS_OFF_RET_ON,
>  	.pwrsts_logic_ret = PWRDM_POWER_OFF,
>  	.banks		  = 2,
> +	.context_offset	  = 0x24,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRDM_POWER_RET,	/* aessmem */
>  		[1] = PWRDM_POWER_OFF,	/* periphmem */
> @@ -100,6 +103,7 @@ static struct powerdomain dss_44xx_pwrdm = {
>  	.pwrsts		  = PWRSTS_OFF_RET_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF,
>  	.banks		  = 1,
> +	.context_offset	  = 0x24,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRDM_POWER_OFF,	/* dss_mem */
>  	},
> @@ -117,6 +121,7 @@ static struct powerdomain tesla_44xx_pwrdm = {
>  	.pwrsts		  = PWRSTS_OFF_RET_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 3,
> +	.context_offset	  = 0x24,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRDM_POWER_RET,	/* tesla_edma */
>  		[1] = PWRSTS_OFF_RET,	/* tesla_l1 */
> @@ -137,6 +142,7 @@ static struct powerdomain wkup_44xx_pwrdm = {
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>  	.pwrsts		  = PWRSTS_ON,
>  	.banks		  = 1,
> +	.context_offset	  = 0x24,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRDM_POWER_OFF,	/* wkup_bank */
>  	},
> @@ -153,6 +159,7 @@ static struct powerdomain cpu0_44xx_pwrdm = {
>  	.pwrsts		  = PWRSTS_OFF_RET_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 1,
> +	.context_offset	  = 0x18,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRSTS_OFF_RET,	/* cpu0_l1 */
>  	},
> @@ -169,6 +176,7 @@ static struct powerdomain cpu1_44xx_pwrdm = {
>  	.pwrsts		  = PWRSTS_OFF_RET_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 1,
> +	.context_offset	  = 0x18,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRSTS_OFF_RET,	/* cpu1_l1 */
>  	},
> @@ -184,6 +192,7 @@ static struct powerdomain emu_44xx_pwrdm = {
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>  	.pwrsts		  = PWRSTS_OFF_ON,
>  	.banks		  = 1,
> +	.context_offset	  = 0x24,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRDM_POWER_OFF,	/* emu_bank */
>  	},
> @@ -200,6 +209,7 @@ static struct powerdomain mpu_44xx_pwrdm = {
>  	.pwrsts		  = PWRSTS_OFF_RET_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 3,
> +	.context_offset	  = 0x24,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRSTS_OFF_RET,	/* mpu_l1 */
>  		[1] = PWRSTS_OFF_RET,	/* mpu_l2 */
> @@ -220,6 +230,7 @@ static struct powerdomain ivahd_44xx_pwrdm = {
>  	.pwrsts		  = PWRSTS_OFF_RET_ON,
>  	.pwrsts_logic_ret = PWRDM_POWER_OFF,
>  	.banks		  = 4,
> +	.context_offset	  = 0x24,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRDM_POWER_OFF,	/* hwa_mem */
>  		[1] = PWRSTS_OFF_RET,	/* sl2_mem */
> @@ -242,6 +253,7 @@ static struct powerdomain cam_44xx_pwrdm = {
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>  	.pwrsts		  = PWRSTS_OFF_ON,
>  	.banks		  = 1,
> +	.context_offset	  = 0x24,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRDM_POWER_OFF,	/* cam_mem */
>  	},
> @@ -259,6 +271,7 @@ static struct powerdomain l3init_44xx_pwrdm = {
>  	.pwrsts		  = PWRSTS_OFF_RET_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 1,
> +	.context_offset	  = 0x24,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRDM_POWER_OFF,	/* l3init_bank1 */
>  	},
> @@ -276,6 +289,7 @@ static struct powerdomain l4per_44xx_pwrdm = {
>  	.pwrsts		  = PWRSTS_OFF_RET_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>  	.banks		  = 2,
> +	.context_offset	  = 0x24,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRDM_POWER_OFF,	/* nonretained_bank */
>  		[1] = PWRDM_POWER_RET,	/* retained_bank */
> diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
> index 3ea7220..a524285 100644
> --- a/arch/arm/plat-omap/include/plat/powerdomain.h
> +++ b/arch/arm/plat-omap/include/plat/powerdomain.h
> @@ -102,6 +102,7 @@ struct powerdomain {
>  	const u8 pwrsts_logic_ret;
>  	const u8 flags;
>  	const u8 banks;
> +	const s16 context_offset;

Looks like this can simply be a u8?

Also, this structure has kerneldoc entries defined for most of its 
members.  Please add some kerneldoc for this new field, describing what it 
is and noting that it is used on OMAP4 only.

>  	const u8 pwrsts_mem_ret[PWRDM_MAX_MEM_BANKS];
>  	const u8 pwrsts_mem_on[PWRDM_MAX_MEM_BANKS];
>  	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
