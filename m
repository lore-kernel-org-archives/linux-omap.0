From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH 1/3] OMAP PM: Seggregate Voltage layer parameters
Date: Fri, 01 Apr 2011 17:03:04 -0700
Message-ID: <87sju1cyfb.fsf@ti.com>
References: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com>
	<1300199622-32500-2-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:56021 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751612Ab1DBADI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 20:03:08 -0400
Received: by mail-iw0-f175.google.com with SMTP id 10so5248514iwn.20
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 17:03:07 -0700 (PDT)
In-Reply-To: <1300199622-32500-2-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Tue, 15 Mar 2011 20:03:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Vishwa,

Vishwanath BS <vishwanath.bs@ti.com> writes:

> Voltage layer takes various parameters which can be broadly classified as
> 1. OMAP/VP specific parameters
> 2. PMIC specific parameters
> 3. Board specific parameters
>
> This patch attempts to categorize the parameters in current voltage layer into
> above buckets. This will make voltage layer to work with different kinds of PMIC
> and boards.
>
> TODO: Provide infrastructure to use VC I2C (I2C4) for PMIC configuration (useful
> for cases where PMIC is connected to OMAP only via I2C4.
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>

Looking back at this in light of the voltage layer cleanup/restructure
I've been working on, and I have a few more comments/questions.

First, I'm glad to see the various hard-coded setup times cleaned up and
made configuable.  Can you redo this on top of the voltage layer
cleanups in progress (my pm-wip/voltdm_b branch)?   More details on this
below...

[...]

> @@ -44,6 +54,15 @@ struct omap_volt_data omap34xx_vddmpu_volt_data[] = {
>  	VOLT_DATA_DEFINE(0, 0, 0, 0),
>  };
>  
> +struct omap_vp_param omap34xx_mpu_vp_data = {
> +	.on_volt		= OMAP3_ON_VOLTAGE_UV,
> +	.onlp_volt		= OMAP3_ONLP_VOLTAGE_UV,
> +	.ret_volt		= OMAP3_RET_VOLTAGE_UV,
> +	.off_volt		= OMAP3_OFF_VOLTAGE_UV,
> +	.vp_vddmin		= OMAP3430_VP1_VLIMITTO_VDDMIN,
> +	.vp_vddmax		= OMAP3430_VP1_VLIMITTO_VDDMAX,
> +};
> +

I'm glad to see these removed from the PMIC structure since they are not
PMIC-specific, but the _volt fields in this structure are written to the
VC, not the VP, so should not be part of a VP structure.

[...]

> @@ -523,15 +523,35 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
>  
>  static void __init omap3_vfsm_init(struct omap_vdd_info *vdd)
>  {
> +	struct clk *omap_32k_clk;
> +	u32 omap_32k_clk_speed;
> +	unsigned long temp;
> +
>  	/*
>  	 * Voltage Manager FSM parameters init
> -	 * XXX This data should be passed in from the board file
>  	 */
> -	vdd->write_reg(OMAP3_CLKSETUP, prm_mod_offs, OMAP3_PRM_CLKSETUP_OFFSET);
> -	vdd->write_reg(OMAP3_VOLTOFFSET, prm_mod_offs,
> -		       OMAP3_PRM_VOLTOFFSET_OFFSET);
> -	vdd->write_reg(OMAP3_VOLTSETUP2, prm_mod_offs,
> -		       OMAP3_PRM_VOLTSETUP2_OFFSET);
> +
> +	omap_32k_clk = clk_get(NULL, "wkup_32k_fck");
> +	if (IS_ERR(omap_32k_clk)) {
> +		pr_warning("%s: Could not get the 32k_clk clk to calculate"
> +			"various vdd_%s params\n", __func__, vdd->voltdm.name);
> +		return;
> +	}
> +	omap_32k_clk_speed = clk_get_rate(omap_32k_clk);
> +	clk_put(omap_32k_clk);

You probably don't need to do a clk_get/clk_get_rate/clk_put of the 32k
clock, since we know what the rate of that clock is already. :)

IOW, 'omap_32k_clk_speed = (32 << 10)' should suffice.

> +	temp = vdd->board_data->omap3_board_data.vdd_setup_off.clksetup;
> +	temp = temp * omap_32k_clk_speed / (1000 * 1000) + 1;
> +	vdd->write_reg(temp, prm_mod_offs, OMAP3_PRM_CLKSETUP_OFFSET);
> +
> +	temp = vdd->board_data->omap3_board_data.vdd_setup_off.voltsetup2;
> +	temp = temp * omap_32k_clk_speed / (1000 * 1000) + 1;
> +	vdd->write_reg(temp, prm_mod_offs, OMAP3_PRM_VOLTSETUP2_OFFSET);
> +
> +	temp = vdd->board_data->omap3_board_data.voltoffset;
> +	temp = temp * omap_32k_clk_speed / (1000 * 1000) + 1;
> +	vdd->write_reg(temp, prm_mod_offs, OMAP3_PRM_VOLTOFFSET_OFFSET);

According to the TRM (vZK, section 4.12.5.1.2), the VOLTOFFSET value
should be calculated based on the CLKSETUP and VOLTSETUP2 registers, so
we probably don't need a configurable value for this.

[...]

> @@ -139,6 +163,61 @@ struct omap_vdd_info {
>  		unsigned long target_volt);
>  };
>  
> +/**
> + * omap3_vdd_setuptime - vdd set up time info
> + * @voltsetup	: setup time of the VDDregulators in us
> + * @clksetup	: setup time of the oscillator system clock (sys_clk) in us
> + * @voltsetup2	: Overall setup time of VDDregulators in us
> + */
> +struct omap3_vdd_setuptime {
> +	u16 voltsetup;
> +	u16 clksetup;
> +	u16 voltsetup2;
> +};
> +
> +/**
> + * omap3_volt_board_data - vdd set up time info for OMAP3
> + * @vdd_setup_ret	: VDD setup time for retention mode
> + * @vdd_setup_off	: VDD setup time for off mode
> + * @voltoffset		: offset-time to de-assert sys_offmode
> + *					when exiting the OFF mode
> + */
> +struct omap3_volt_board_data {
> +	struct omap3_vdd_setuptime vdd_setup_ret;
> +	struct omap3_vdd_setuptime vdd_setup_off;
> +	u16 voltoffset;

voltoffset can be dropped.  Based on TRM, voltoffset can be calulated
(see comment above.)

> +};
> +
> +/**
> + * omap4_volt_setuptime - vdd set up time info for OMAP4
> + * @voltsetup_ramp_up	: VDD ram up time in us
> + * @voltsetup_ramp_down	: VDD ram down time in us
> + */
> +struct omap4_volt_setuptime {
> +	u16 voltsetup_ramp_up;
> +	u16 voltsetup_ramp_down;
> +};
> +
> +/**
> + * omap4_volt_board_data - vdd set up time info for OMAP4
> + * @vdd_setup_ret	: VDD setup time for retention mode
> + * @vdd_setup_off	: VDD setup time for off mode
> + */
> +struct omap4_volt_board_data {
> +	struct omap4_volt_setuptime vdd_setup_ret;
> +	struct omap4_volt_setuptime vdd_setup_off;
> +};
> +
> +/**
> + * omap_volt_board_data - board specific voltage set up time data
> + * @omap3_board_data	: omap3 board data
> + * @omap4_board_data	: omap4 board data
> + */
> +union omap_volt_board_data {
> +	struct omap3_volt_board_data omap3_board_data;
> +	struct omap4_volt_board_data omap4_board_data;
> +};

For the setup times, we need a generic way to define these times that
can be used for both OMAP3 & OMAP4+.  

IIUC, The primary difference is that on OMAP4, both a ramp up and a ramp
down time are configurable, where OMAP3 has a single time for both.  If
the values are given in usecs and not in register values, defining a
common structure to handle both should be straight forward,

For OMAP3 and OMAP4, there you have a clock setup time, and then
separate voltage setup times for ret/sleep and off.  The structure can
contain both ramp up and ramp down times, but one will obviously be
ignored in the OMAP3 specific code that programs these registers
(probably in prmXXXX.c)

Kevin
