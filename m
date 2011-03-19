From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/7] OMAP2+: voltage: move PRCM mod offets into VDD structure
Date: Sat, 19 Mar 2011 10:11:53 +0530
Message-ID: <6002d9aa481856ee6e703e8f6cbda767@mail.gmail.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com> <1300493932-17362-3-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:60903 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752288Ab1CSEl5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Mar 2011 00:41:57 -0400
Received: by gxk28 with SMTP id 28so2076940gxk.26
        for <linux-omap@vger.kernel.org>; Fri, 18 Mar 2011 21:41:56 -0700 (PDT)
In-Reply-To: <1300493932-17362-3-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Minor comment.
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Saturday, March 19, 2011 5:49 AM
> To: linux-omap@vger.kernel.org
> Cc: Paul Walmsely; Benoit Cousson
> Subject: [PATCH 2/7] OMAP2+: voltage: move PRCM mod offets into VDD
> structure
>
> Eliminate need for global variables for the various PRM module
> offsets by
> making them part of the VDD structure.
>
> Eventually, these will likely be moved again, or more likely
> removed,
> but for now just getting rid of them as global variabes so that the
> voltage domain initialization can be cleaned up.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/voltage.c                 |  109 ++++++++++++--
> -----------
>  arch/arm/mach-omap2/voltage.h                 |    6 +-
>  arch/arm/mach-omap2/voltagedomains3xxx_data.c |   10 +-
>  arch/arm/mach-omap2/voltagedomains44xx_data.c |   12 ++-
>  4 files changed, 67 insertions(+), 70 deletions(-)
>
[....]

> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-
> omap2/voltage.h
> index e9f5408..44edc1e 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -133,6 +133,9 @@ struct omap_vdd_info {
>  	struct dentry *debug_dir;
>  	u32 curr_volt;
>  	bool vp_enabled;
> +
> +	s16 prm_mod;
> +	s16 prm_irqst_mod;

Can you also add kernel doc for above two
entries?

>  	u32 (*read_reg) (u16 mod, u8 offset);
>  	void (*write_reg) (u32 val, u16 mod, u8 offset);
>  	int (*volt_scale) (struct omap_vdd_info *vdd,
> @@ -151,8 +154,7 @@ struct omap_volt_data
> *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
>  		unsigned long volt);
>  unsigned long omap_voltage_get_nom_volt(struct voltagedomain
> *voltdm);
>  struct dentry *omap_voltage_get_dbgdir(struct voltagedomain
> *voltdm);
> -int __init omap_voltage_early_init(s16 prm_mod, s16 prm_irqst_mod,
> -				   struct omap_vdd_info *omap_vdd_array[],
> +int __init omap_voltage_early_init(struct omap_vdd_info
> *omap_vdd_array[],
>  				   u8 omap_vdd_count);
>  #ifdef CONFIG_PM
>  int omap_voltage_register_pmic(struct voltagedomain *voltdm,
