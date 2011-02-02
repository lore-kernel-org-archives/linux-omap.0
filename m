From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/6] omap4: powerdomain: Use intended PWRSTS_* flags instead of values
Date: Tue, 01 Feb 2011 17:21:51 -0800
Message-ID: <87aaifmdsg.fsf@ti.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
	<1296212688-21951-4-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:49296 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020Ab1BBBVz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 20:21:55 -0500
Received: by ywa8 with SMTP id 8so3331437ywa.32
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 17:21:54 -0800 (PST)
In-Reply-To: <1296212688-21951-4-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Fri, 28 Jan 2011 16:34:45 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> IVAHD and ABE power domain logic state is populated using directly
> value instead of the capability flags.
>
> Fix the same.

Again, has this been fixed in the scripts?

For future reference,  It will be helpful to note in the changelog that
this kind of thing has been fixed in the autogen scripts.

Thanks,

Kevin

> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/powerdomains44xx_data.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
> index 96cde98..daee255 100644
> --- a/arch/arm/mach-omap2/powerdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
> @@ -80,7 +80,7 @@ static struct powerdomain abe_44xx_pwrdm = {
>  	.prcm_partition	  = OMAP4430_PRM_PARTITION,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>  	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
> -	.pwrsts_logic_ret = PWRDM_POWER_OFF,
> +	.pwrsts_logic_ret = PWRSTS_OFF,
>  	.banks		  = 2,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRDM_POWER_RET,	/* aessmem */
> @@ -227,7 +227,7 @@ static struct powerdomain ivahd_44xx_pwrdm = {
>  	.prcm_partition	  = OMAP4430_PRM_PARTITION,
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>  	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
> -	.pwrsts_logic_ret = PWRDM_POWER_OFF,
> +	.pwrsts_logic_ret = PWRSTS_OFF,
>  	.banks		  = 4,
>  	.pwrsts_mem_ret	= {
>  		[0] = PWRDM_POWER_OFF,	/* hwa_mem */
