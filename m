From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm-wip/voltdm_nm][PATCH 02/10] OMAP4: PM: VC: allow channels use of default channel i2c_slaveaddr
Date: Thu, 09 Jun 2011 11:07:10 -0700
Message-ID: <87boy6zxo1.fsf@ti.com>
References: <1307412972-25854-1-git-send-email-nm@ti.com>
	<1307412972-25854-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:52700 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751669Ab1FISH1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 14:07:27 -0400
Received: by mail-pw0-f50.google.com with SMTP id 3so870152pwi.9
        for <linux-omap@vger.kernel.org>; Thu, 09 Jun 2011 11:07:13 -0700 (PDT)
In-Reply-To: <1307412972-25854-3-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Mon, 6 Jun 2011 21:16:05 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> OMAP4's PRM_VC_CFG_CHANNEL register allows for flexibility of configuring
> for various PMIC configurations. In combinations where the same slave address
> is used for all domains, it is possible to setup the VC channel for the
> dependent channels to use the same slave address as the default channel.
>
> Since I2C addressing could be 7 bit or 11 bits as per the I2C specification,

That alone should be the justification for the u8 -> u16 change.

In fact, I'll change all these i2c address fields so u16 in the original
patches for that reason.  Then here, you can just say you use BIT(15)
because I2C address are a max of 11 bits.   BTW is it 11 or 10?  I've
only heard of 10-bit addressing for I2C.

> we use the BIT(15) to flag that this should use the default channel's
> configuration. Depending on the PMIC and platform used, this can
> be populated on the PMIC's datastructure and percolates to VC's configuration.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/vc.c      |   18 ++++++++++++++----
>  arch/arm/mach-omap2/vc.h      |    2 +-
>  arch/arm/mach-omap2/voltage.h |   11 ++++++++++-
>  3 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index aa9f0bc..0c0e416 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -309,11 +309,21 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
>  	vc->cmd_reg_addr = voltdm->pmic->cmd_reg_addr;
>  	vc->setup_time = voltdm->pmic->volt_setup_time;
>  
> +	if ((vc->flags & OMAP_VC_CHANNEL_DEFAULT) &&
> +		(vc->i2c_slave_addr == USE_DEFAULT_CHANNEL_I2C_PARAM)) {
> +		pr_err("%s: voltdm %s: default channel "
> +			"bad config-sa=%2x ?\n", __func__, voltdm->name,
> +			vc->i2c_slave_addr);
> +		return;
> +	}
> +
>  	/* Configure the i2c slave address for this VC */
> -	voltdm->rmw(vc->smps_sa_mask,
> -		    vc->i2c_slave_addr << __ffs(vc->smps_sa_mask),
> -		    vc->common->smps_sa_reg);
> -	vc->cfg_channel |= vc_cfg_bits->sa;
> +	if (vc->i2c_slave_addr != USE_DEFAULT_CHANNEL_I2C_PARAM) {
> +		voltdm->rmw(vc->smps_sa_mask,
> +			vc->i2c_slave_addr << __ffs(vc->smps_sa_mask),
> +			vc->common->smps_sa_reg);
> +		vc->cfg_channel |= vc_cfg_bits->sa;
> +	}
>  
>  	/*
>  	 * Configure the PMIC register addresses.
> diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
> index e16dacf..22c0060 100644
> --- a/arch/arm/mach-omap2/vc.h
> +++ b/arch/arm/mach-omap2/vc.h
> @@ -77,7 +77,7 @@ struct omap_vc_channel {
>  	u8 flags;
>  
>  	/* channel state */
> -	u8 i2c_slave_addr;
> +	u16 i2c_slave_addr;
>  	u8 volt_reg_addr;
>  	u8 cmd_reg_addr;
>  	u8 cfg_channel;
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index f079167..1732258 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -109,6 +109,15 @@ struct omap_volt_data {
>  	u8	vp_errgain;
>  };
>  
> +/*
> + * Introduced in OMAP4, is a concept of a default channel - in OMAP4, this
> + * channel is MPU, all other domains such as IVA/CORE, could optionally
> + * link their i2c reg configuration to use MPU channel's configuration if
> + * required. To do this, mark in the PMIC structure's
> + * i2c_slave_addr with this macro.
> + */
> +#define USE_DEFAULT_CHANNEL_I2C_PARAM  0x8000
> +

Needs a VC prefix, also use BIT().  

Also, later on in the series you use the same value for things other
than the I2C slave address.  How about just calling this:

#define OMAP_VC_USE_DEFAULT_CHANNEL    BIT(15)


>  /**
>   * struct omap_voltdm_pmic - PMIC specific data required by voltage driver.
>   * @slew_rate:	PMIC slew rate (in uv/us)
> @@ -132,7 +141,7 @@ struct omap_voltdm_pmic {
>  	u8 vp_vddmin;
>  	u8 vp_vddmax;
>  	u8 vp_timeout_us;
> -	u8 i2c_slave_addr;
> +	u16 i2c_slave_addr;
>  	u8 volt_reg_addr;
>  	u8 cmd_reg_addr;
>  	bool i2c_high_speed;
