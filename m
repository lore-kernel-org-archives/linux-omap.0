From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 08/11] omap3+: voltage: remove obsolete parameters
Date: Fri, 04 Nov 2011 14:17:32 -0700
Message-ID: <87ipmz7fkj.fsf@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
	<1317835031-8201-9-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:42633 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751016Ab1KDVRg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 17:17:36 -0400
Received: by mail-iy0-f173.google.com with SMTP id q3so3602657iaq.4
        for <linux-omap@vger.kernel.org>; Fri, 04 Nov 2011 14:17:34 -0700 (PDT)
In-Reply-To: <1317835031-8201-9-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Wed, 5 Oct 2011 20:17:08 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> Voltages for different operating modes are now provided by vc_params.
> Oscillator setup times are handled as board specific.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

These should be removed in the previous patches.

That gets at a bigger problem with this series in that it's not
bisectable.  For example, these fields are removed in PATCH 2/11 but
their usage isn't removed until here.  That means that after 2/11,
things will no longer compile.

Probably the best way to do this is to just combine patches 2, 3, 4 and
this one.    That way it's also obvious that the voltage values added in
patches 3 & 4 are just being moved, and not being invented out of thin air.

Kevin

> ---
>  arch/arm/mach-omap2/omap_twl.c |   25 -------------------------
>  arch/arm/mach-omap2/vc.h       |    1 -
>  2 files changed, 0 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
> index df4e7c3..62ed050 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -141,11 +141,6 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
>  static struct omap_voltdm_pmic omap3_mpu_pmic = {
>  	.slew_rate		= 4000,
>  	.step_size		= 12500,
> -	.on_volt		= 1200000,
> -	.onlp_volt		= 1000000,
> -	.ret_volt		= 975000,
> -	.off_volt		= 600000,
> -	.volt_setup_time	= 0xfff,
>  	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
>  	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
>  	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
> @@ -162,11 +157,6 @@ static struct omap_voltdm_pmic omap3_mpu_pmic = {
>  static struct omap_voltdm_pmic omap3_core_pmic = {
>  	.slew_rate		= 4000,
>  	.step_size		= 12500,
> -	.on_volt                = 1200000,
> -	.onlp_volt              = 1000000,
> -	.ret_volt               = 975000,
> -	.off_volt               = 600000,
> -	.volt_setup_time        = 0xfff,
>  	.vp_erroroffset		= OMAP3_VP_CONFIG_ERROROFFSET,
>  	.vp_vstepmin		= OMAP3_VP_VSTEPMIN_VSTEPMIN,
>  	.vp_vstepmax		= OMAP3_VP_VSTEPMAX_VSTEPMAX,
> @@ -183,11 +173,6 @@ static struct omap_voltdm_pmic omap3_core_pmic = {
>  static struct omap_voltdm_pmic omap4_mpu_pmic = {
>  	.slew_rate		= 4000,
>  	.step_size		= 12660,
> -	.on_volt		= 1375000,
> -	.onlp_volt		= 1375000,
> -	.ret_volt		= 830000,
> -	.off_volt		= 0,
> -	.volt_setup_time	= 0,
>  	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
>  	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
>  	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
> @@ -205,11 +190,6 @@ static struct omap_voltdm_pmic omap4_mpu_pmic = {
>  static struct omap_voltdm_pmic omap4_iva_pmic = {
>  	.slew_rate		= 4000,
>  	.step_size		= 12660,
> -	.on_volt		= 1188000,
> -	.onlp_volt		= 1188000,
> -	.ret_volt		= 830000,
> -	.off_volt		= 0,
> -	.volt_setup_time	= 0,
>  	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
>  	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
>  	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
> @@ -227,11 +207,6 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
>  static struct omap_voltdm_pmic omap4_core_pmic = {
>  	.slew_rate		= 4000,
>  	.step_size		= 12660,
> -	.on_volt		= 1200000,
> -	.onlp_volt		= 1200000,
> -	.ret_volt		= 830000,
> -	.off_volt		= 0,
> -	.volt_setup_time	= 0,
>  	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
>  	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
>  	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
> diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
> index ec50643..e6fdd23 100644
> --- a/arch/arm/mach-omap2/vc.h
> +++ b/arch/arm/mach-omap2/vc.h
> @@ -80,7 +80,6 @@ struct omap_vc_channel {
>  	u16 i2c_slave_addr;
>  	u16 volt_reg_addr;
>  	u16 cmd_reg_addr;
> -	u16 setup_time;
>  	u8 cfg_channel;
>  	bool i2c_high_speed;
