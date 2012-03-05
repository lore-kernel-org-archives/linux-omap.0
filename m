From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: voltage: ensure voltage used is exact
 voltage from OPP table
Date: Mon, 5 Mar 2012 11:41:27 +0200
Message-ID: <1330940487.2116.119.camel@sokoban>
References: <1330728121-26664-1-git-send-email-khilman@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56560 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756448Ab2CEJlf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 04:41:35 -0500
In-Reply-To: <1330728121-26664-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

On Fri, 2012-03-02 at 14:42 -0800, Kevin Hilman wrote:
> When using the SMPS regulators to scale voltages, the regulator
> framework may pass a minimum voltage that is not an exact OPP voltage.
> For the VC/VP controlled voltage domains, we must ensure that the
> voltage requested is the exact voltage from the OPP table.  This is
> especially critical when using SR.
> 
> To fix, voltdm_scale() uses the target voltage passed to walk through
> the OPP voltages until it finds a voltage that is >= one of the OPP
> voltages.

I have just one question to this, how about smartreflex class1p5? Do we
have any plans for that one? The old implementation at least was using
voltdm_scale, so if we modify this function, smartreflex class1p5
doesn't work anymore.

Otherwise this patch looks good to me.

-Tero

> 
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Unless there are any objections, this will be queued along with the
> rest of the SMPS regulator series from Tero.  Currently availble in
> my for_3.4/pm/smps-regulator branch at
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
> 
>  arch/arm/mach-omap2/voltage.c |   21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 8a36342..4dc60e8 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -73,7 +73,8 @@ unsigned long voltdm_get_voltage(struct voltagedomain *voltdm)
>  int voltdm_scale(struct voltagedomain *voltdm,
>  		 unsigned long target_volt)
>  {
> -	int ret;
> +	int ret, i;
> +	unsigned long volt = 0;
>  
>  	if (!voltdm || IS_ERR(voltdm)) {
>  		pr_warning("%s: VDD specified does not exist!\n", __func__);
> @@ -86,9 +87,23 @@ int voltdm_scale(struct voltagedomain *voltdm,
>  		return -ENODATA;
>  	}
>  
> -	ret = voltdm->scale(voltdm, target_volt);
> +	/* Adjust voltage to the exact voltage from the OPP table */
> +	for (i = 0; voltdm->volt_data[i].volt_nominal != 0; i++) {
> +		if (voltdm->volt_data[i].volt_nominal >= target_volt) {
> +			volt = voltdm->volt_data[i].volt_nominal;
> +			break;
> +		}
> +	}
> +
> +	if (!volt) {
> +		pr_warning("%s: not scaling. OPP voltage for %lu, not found.\n",
> +			   __func__, target_volt);
> +		return -EINVAL;
> +	}
> +
> +	ret = voltdm->scale(voltdm, volt);
>  	if (!ret)
> -		voltdm->nominal_volt = target_volt;
> +		voltdm->nominal_volt = volt;
>  
>  	return ret;
>  }


