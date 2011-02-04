From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 06/13] OMAP: Disable Smartreflex across DVFS
Date: Fri, 04 Feb 2011 08:06:26 -0800
Message-ID: <871v3nu6m5.fsf@ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<1295618465-15234-7-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:41642 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752938Ab1BDQGj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 11:06:39 -0500
Received: by mail-yw0-f43.google.com with SMTP id 5so973503yws.16
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 08:06:29 -0800 (PST)
In-Reply-To: <1295618465-15234-7-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Fri, 21 Jan 2011 19:30:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

Vishwanath BS <vishwanath.bs@ti.com> writes:

> From: Thara Gopinath <thara@ti.com>
>
> This patch disables smartreflex for a particular voltage
> domain when the the voltage domain and the devices belonging
> to it is being scaled and re-enables it back once the scaling
> is done.

Should also describe why.

> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
>  arch/arm/mach-omap2/dvfs.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/dvfs.c b/arch/arm/mach-omap2/dvfs.c
> index 05a9ce3..1e5492c 100755
> --- a/arch/arm/mach-omap2/dvfs.c
> +++ b/arch/arm/mach-omap2/dvfs.c
> @@ -529,6 +529,9 @@ static int omap_dvfs_voltage_scale(struct omap_vdd_dvfs_info *dvfs_info)
>  
>  	curr_volt = omap_voltage_get_nom_volt(voltdm);
>  
> +	/* Disable smartreflex module across voltage and frequency scaling */

comment redundant

> +	omap_sr_disable(voltdm);
> +
>  	if (curr_volt == volt) {
>  		is_volt_scaled = 1;
>  	} else if (curr_volt < volt) {
> @@ -536,6 +539,7 @@ static int omap_dvfs_voltage_scale(struct omap_vdd_dvfs_info *dvfs_info)
>  		if (ret) {
>  			pr_warning("%s: Unable to scale the %s to %ld volt\n",
>  						__func__, voltdm->name, volt);
> +			omap_sr_enable(voltdm);

Would probably be cleaner to make this error path 'goto' the end where
the SR enable and mutex_unlock are already being done.

>  			mutex_unlock(&dvfs_info->scaling_mutex);
>  			return ret;
>  		}
> @@ -570,6 +574,9 @@ static int omap_dvfs_voltage_scale(struct omap_vdd_dvfs_info *dvfs_info)
>  	if (!is_volt_scaled && !ret)
>  		omap_voltage_scale_vdd(voltdm, volt);
>  
> +	/* Enable Smartreflex module */

comment redundant

> +	omap_sr_enable(voltdm);
> +
>  	mutex_unlock(&dvfs_info->scaling_mutex);
>  
>  	/* calculate the voltages for dependent vdd's */

Kevin
