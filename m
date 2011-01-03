From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP PM: Expose vc registers in debugfs
Date: Mon, 03 Jan 2011 09:21:37 -0600
Message-ID: <4D21E981.4000008@ti.com>
References: <1293710669-3014-1-git-send-email-sawant@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:36234 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755431Ab1ACPVl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 10:21:41 -0500
Received: by mail-yi0-f41.google.com with SMTP id 25so3576606yia.14
        for <linux-omap@vger.kernel.org>; Mon, 03 Jan 2011 07:21:40 -0800 (PST)
In-Reply-To: <1293710669-3014-1-git-send-email-sawant@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sawant@ti.com
Cc: linux-omap@vger.kernel.org

sawant@ti.com had written, on 12/30/2010 06:04 AM, the following:
> From: Anand Sawant <sawant@ti.com>
> 
> This patch will expose the following voltage controller registers
> as part of voltage layer debugfs.
> 1. PRM_VC_BYPASS_VAL
> 2. PRM_VC_CMD_VAL - for all VDDs
> 
> This patch will help in debugging voltage scaling issues.
How does this patch help in debugging voltage scaling issues?

> 
> Tested on Zoom3 & OMAP4430 SDP.
> 
> Patch rebased to latest Kevin's PM branch.
> 
> Signed-off-by: Anand S Sawant <sawant@ti.com>
> ---
>  arch/arm/mach-omap2/voltage.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index ed6079c..a9b52e4 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -336,6 +336,11 @@ static void omap4_voltage_write_reg(u32 val, u16 mod, u8 offset)
>  }
>  
>  /* Voltage debugfs support */
> +
> +/**
> + * Gets the current vp output voltage (auto-compensated) for the
> + * voltage domain.
> + */
please remove this from this patch - has nothing to do with $subject
also, please read kernel documentation for function comment header style

>  static int vp_volt_debug_get(void *data, u64 *val)
>  {
>  	struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
> @@ -359,6 +364,10 @@ static int vp_volt_debug_get(void *data, u64 *val)
>  	return 0;
>  }
>  
> +/**
> + * Gets the current nominal OPP voltage (non auto-compensated) for the
> + * voltage domain.
> + */
same here
>  static int nom_volt_debug_get(void *data, u64 *val)
>  {
>  	struct omap_vdd_info *vdd = (struct omap_vdd_info *) data;
> @@ -456,6 +465,7 @@ static void __init vp_init(struct omap_vdd_info *vdd)
>  	vdd->write_reg(vp_val, mod, vdd->vp_offs.vlimitto);
>  }
>  
> +/* Creates debugfs entries for key vp & vc parameters */
and here
>  static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
>  {
>  	char *name;
> @@ -501,6 +511,11 @@ static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
>  	(void) debugfs_create_file("curr_nominal_volt", S_IRUGO,
>  				vdd->debug_dir, (void *) vdd,
>  				&nom_volt_debug_fops);
> +
> +	(void) debugfs_create_x8("vc_bypass_val", S_IRUGO, vdd->debug_dir,
> +				&(vdd->vc_reg.bypass_val_reg));
> +	(void) debugfs_create_x8("vc_cmdval", S_IRUGO, vdd->debug_dir,
> +				&(vdd->vc_reg.cmdval_reg));
why the cast to void?

>  }
>  
>  /* Voltage scale and accessory APIs */


-- 
Regards,
Nishanth Menon
