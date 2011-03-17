From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] omap3: voltage: fix variable type and name
Date: Thu, 17 Mar 2011 13:11:59 -0700
Message-ID: <874o711p80.fsf@ti.com>
References: <1300374757-23010-1-git-send-email-premi@ti.com>
	<1300374757-23010-3-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:44821 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752188Ab1CQUMD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 16:12:03 -0400
Received: by pzk12 with SMTP id 12so647638pzk.24
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 13:12:01 -0700 (PDT)
In-Reply-To: <1300374757-23010-3-git-send-email-premi@ti.com> (Sanjeev Premi's
	message of "Thu, 17 Mar 2011 20:42:37 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> In all usages, variables prm_mod_offs and prm_irqst_ocp_mod_offs
> are expected to be "u16" but have been declared as "s16".

What kind of problem is that causing?

Kevin

> In addition, renamed prm_irqst_ocp_mod_offs to ocp_sysreg_prm_offs
> for better association with the TRM. Original name perhaps came
> from the current usage of this offset to reach PRM_IRQSTATUS_MPU
> offset.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/voltage.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index ce3098a..c686eca 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -51,8 +51,8 @@ static struct omap_vdd_info **vdd_info;
>  static int nr_scalable_vdd;
>  
>  /* XXX document */
> -static s16 prm_mod_offs;
> -static s16 prm_irqst_ocp_mod_offs;
> +static u16 prm_mod_offs;
> +static u16 ocp_sysreg_prm_offs;
>  
>  static struct dentry *voltage_dir;
>  
> @@ -447,8 +447,8 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
>  	 */
>  	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
>  		vdd->write_reg(vdd->vp_data->prm_irqst_data->tranxdone_status,
> -			       prm_irqst_ocp_mod_offs, prm_irqst_reg);
> -		if (!(vdd->read_reg(prm_irqst_ocp_mod_offs, prm_irqst_reg) &
> +			       ocp_sysreg_prm_offs, prm_irqst_reg);
> +		if (!(vdd->read_reg(ocp_sysreg_prm_offs, prm_irqst_reg) &
>  		      vdd->vp_data->prm_irqst_data->tranxdone_status))
>  			break;
>  		udelay(1);
> @@ -481,7 +481,7 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
>  	 * Depends on SMPSWAITTIMEMIN/MAX and voltage change
>  	 */
>  	timeout = 0;
> -	omap_test_timeout((vdd->read_reg(prm_irqst_ocp_mod_offs, prm_irqst_reg) &
> +	omap_test_timeout((vdd->read_reg(ocp_sysreg_prm_offs, prm_irqst_reg) &
>  			   vdd->vp_data->prm_irqst_data->tranxdone_status),
>  			  VP_TRANXDONE_TIMEOUT, timeout);
>  	if (timeout >= VP_TRANXDONE_TIMEOUT)
> @@ -498,8 +498,8 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
>  	timeout = 0;
>  	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
>  		vdd->write_reg(vdd->vp_data->prm_irqst_data->tranxdone_status,
> -			       prm_irqst_ocp_mod_offs, prm_irqst_reg);
> -		if (!(vdd->read_reg(prm_irqst_ocp_mod_offs, prm_irqst_reg) &
> +			       ocp_sysreg_prm_offs, prm_irqst_reg);
> +		if (!(vdd->read_reg(ocp_sysreg_prm_offs, prm_irqst_reg) &
>  		      vdd->vp_data->prm_irqst_data->tranxdone_status))
>  			break;
>  		udelay(1);
> @@ -1101,10 +1101,10 @@ int __init omap_voltage_early_init(struct omap_vdd_info *omap_vdd_array[],
>  {
>  	if (cpu_is_omap44xx()) {
>  		prm_mod_offs = OMAP4430_PRM_DEVICE_INST;
> -		prm_irqst_ocp_mod_offs = OMAP4430_PRM_OCP_SOCKET_INST;
> +		ocp_sysreg_prm_offs = OMAP4430_PRM_OCP_SOCKET_INST;
>  	} else if (cpu_is_omap34xx()) {
>  		prm_mod_offs = OMAP3430_GR_MOD;
> -		prm_irqst_ocp_mod_offs = OCP_MOD;
> +		ocp_sysreg_prm_offs = OCP_MOD;
>  	} else {
>  		/* TODO:
>  		 * What should be done for OMAP24xx?
