From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: add comments for erratas i540 and i478 workarounds
Date: Wed, 17 Nov 2010 09:40:59 -0800
Message-ID: <87aal77sr8.fsf@deeprootsystems.com>
References: <1290009410-7316-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43198 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933709Ab0KQRlD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 12:41:03 -0500
Received: by ywg8 with SMTP id 8so1251813ywg.19
        for <linux-omap@vger.kernel.org>; Wed, 17 Nov 2010 09:41:03 -0800 (PST)
In-Reply-To: <1290009410-7316-1-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Wed, 17 Nov 2010 16:56:50 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> From: Jean Pihet <jean.pihet@newoldbits.com>
>
> Add comments and IDs for the following erratas:
> - i540: MPU cannot exit from Standby,
> - i478: Unexpected Cold-Reset is generated when device is coming
>    back from OFF mode
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Nice, it's great to have the errata numbers in the code.

Minor comment, please fix up the multi-line comment style to follow
CodingStyle.  Search for 'multi-line' in Documentation/CodingStyle.

Kevin

> ---
>  arch/arm/mach-omap2/irq.c              |    3 ++-
>  arch/arm/mach-omap2/powerdomains34xx.h |    6 ++++++
>  2 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 32eeabe..e28b417 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -284,7 +284,8 @@ void omap3_intc_suspend(void)
>  
>  void omap3_intc_prepare_idle(void)
>  {
> -	/* Disable autoidle as it can stall interrupt controller */
> +	/* Disable autoidle as it can stall interrupt controller,
> +	 * Cf. errata ID i540 for 3430 (all revisions up to 3.1.x) */
>  	intc_bank_write_reg(0, &irq_banks[0], INTC_SYSCONFIG);
>  }
>  
> diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
> index fa90486..349f2bf 100644
> --- a/arch/arm/mach-omap2/powerdomains34xx.h
> +++ b/arch/arm/mach-omap2/powerdomains34xx.h
> @@ -80,6 +80,10 @@ static struct powerdomain mpu_3xxx_pwrdm = {
>   * 3430s upto ES3.0 and 3630ES1.0. Hence this feature
>   * needs to be disabled on these chips.
>   * Refer: 3430 errata ID i459 and 3630 errata ID i579
> + *
> + * Note: setting the SAR flag could help for errata ID i478
> + *  which applies to 3430 <= ES3.1, but since the SAR feature
> + *  is broken, do not use it.
>   */
>  static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
>  	.name		  = "core_pwrdm",
> @@ -108,6 +112,8 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
>  					  CHIP_GE_OMAP3630ES1_1),
>  	.pwrsts		  = PWRSTS_OFF_RET_ON,
>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
> +	/* Setting the SAR flag for errata ID i478 which applies
> +	 *  to 3430 <= ES3.1 */
>  	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBTLL only */
>  	.banks		  = 2,
>  	.pwrsts_mem_ret	  = {
