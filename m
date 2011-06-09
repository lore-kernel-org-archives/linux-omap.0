From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm-wip/voltdm_nm][PATCH 04/10] OMAP4: PM: VC: allow channels use of default channel volt_reg_addr
Date: Thu, 09 Jun 2011 11:32:56 -0700
Message-ID: <87sjriyhwn.fsf@ti.com>
References: <1307412972-25854-1-git-send-email-nm@ti.com>
	<1307412972-25854-5-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:42991 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751047Ab1FISdB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 14:33:01 -0400
Received: by mail-pz0-f43.google.com with SMTP id 1so1250169pzk.16
        for <linux-omap@vger.kernel.org>; Thu, 09 Jun 2011 11:33:00 -0700 (PDT)
In-Reply-To: <1307412972-25854-5-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Mon, 6 Jun 2011 21:16:07 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> OMAP4's PRM_VC_CFG_CHANNEL register allows for flexibility of configuring
> for various PMIC configurations. In combinations where we'd like to
> use the default VC channel's voltage_reg address in a particular non-default
> VC channel, we allow the use of USE_DEFAULT_CHANNEL_I2C_PARAM.
>
> Since 0 is a valid register address, we need to increase the size of
> reg storage for the flag. Depending on the PMIC and platform used,
> this can be populated on the PMIC's datastructure and percolates to
> VC's configuration.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Approach is fine.  After rebase, you won't have to do the u16 changes
anymore since I squashed them into earlier patches already.

Minor nit below...

> ---
>  arch/arm/mach-omap2/vc.c      |   17 ++++++++++-------
>  arch/arm/mach-omap2/vc.h      |    2 +-
>  arch/arm/mach-omap2/voltage.h |    4 ++--
>  3 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index 6017c70..53a16cc 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -310,10 +310,11 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
>  	vc->setup_time = voltdm->pmic->volt_setup_time;
>  
>  	if ((vc->flags & OMAP_VC_CHANNEL_DEFAULT) &&
> -		(vc->i2c_slave_addr == USE_DEFAULT_CHANNEL_I2C_PARAM)) {
> +		((vc->i2c_slave_addr == USE_DEFAULT_CHANNEL_I2C_PARAM) ||
> +		(vc->volt_reg_addr == USE_DEFAULT_CHANNEL_I2C_PARAM))) {

Please fixup the indentation here.  (and in original patch that added
this.)  Run it through scripts/Lindent and see what the result should
look like.  I usually ends up to be leading tabs plus any extra spaces
required to make it line up right.

Kevin

>  		pr_err("%s: voltdm %s: default channel "
> -			"bad config-sa=%2x ?\n", __func__, voltdm->name,
> -			vc->i2c_slave_addr);
> +			"bad config-sa=%2x vol=%2x?\n", __func__, voltdm->name,
> +			vc->i2c_slave_addr, vc->volt_reg_addr);
>  		return;
>  	}
>  
> @@ -328,10 +329,12 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
>  	/*
>  	 * Configure the PMIC register addresses.
>  	 */
> -	voltdm->rmw(vc->smps_volra_mask,
> -		    vc->volt_reg_addr << __ffs(vc->smps_volra_mask),
> -		    vc->common->smps_volra_reg);
> -	vc->cfg_channel |= vc_cfg_bits->rav;
> +	if (vc->volt_reg_addr != USE_DEFAULT_CHANNEL_I2C_PARAM) {
> +		voltdm->rmw(vc->smps_volra_mask,
> +			    vc->volt_reg_addr << __ffs(vc->smps_volra_mask),
> +			    vc->common->smps_volra_reg);
> +		vc->cfg_channel |= vc_cfg_bits->rav;
> +	}
>  
>  	if (vc->cmd_reg_addr) {
>  		voltdm->rmw(vc->smps_cmdra_mask,
> diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
> index 22c0060..310368f 100644
> --- a/arch/arm/mach-omap2/vc.h
> +++ b/arch/arm/mach-omap2/vc.h
> @@ -78,7 +78,7 @@ struct omap_vc_channel {
>  
>  	/* channel state */
>  	u16 i2c_slave_addr;
> -	u8 volt_reg_addr;
> +	u16 volt_reg_addr;
>  	u8 cmd_reg_addr;
>  	u8 cfg_channel;
>  	u16 setup_time;
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index 1732258..75f3557 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -114,7 +114,7 @@ struct omap_volt_data {
>   * channel is MPU, all other domains such as IVA/CORE, could optionally
>   * link their i2c reg configuration to use MPU channel's configuration if
>   * required. To do this, mark in the PMIC structure's
> - * i2c_slave_addr with this macro.
> + * i2c_slave_addr, volt_reg_addr with this macro.
>   */
>  #define USE_DEFAULT_CHANNEL_I2C_PARAM  0x8000
>  
> @@ -142,7 +142,7 @@ struct omap_voltdm_pmic {
>  	u8 vp_vddmax;
>  	u8 vp_timeout_us;
>  	u16 i2c_slave_addr;
> -	u8 volt_reg_addr;
> +	u16 volt_reg_addr;
>  	u8 cmd_reg_addr;
>  	bool i2c_high_speed;
>  	u8 i2c_mcode;
