From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [RFC][PATCH 2/3] OMAP PM: Add support for bypassing VP/VC in
 Voltage layer
Date: Tue, 15 Mar 2011 20:46:01 +0530
Message-ID: <AANLkTinzfcmXuNhUYqXRNhKk9naCahW2DKWrEmegJ56w@mail.gmail.com>
References: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com> <1300199622-32500-3-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:42115 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750734Ab1COPVp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 11:21:45 -0400
Received: by mail-wy0-f181.google.com with SMTP id 23so651717wyf.12
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 08:21:44 -0700 (PDT)
In-Reply-To: <1300199622-32500-3-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, Mar 15, 2011 at 20:03, Vishwanath BS <vishwanath.bs@ti.com> wro=
te:
> Currently Voltage layer assumes that all PMICs use VP/VC for Voltage =
scaling.
> There can be some instances where PMIC would want to bypass VP/VC for=
 voltage
> scaling. So make VOltage layer flexible enough to handle this.
please fix VOltage.

The commit message does'nt actually explain enough. it is too vague.

>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap_twl.c | =A0 =A05 +++++
> =A0arch/arm/mach-omap2/voltage.c =A0| =A0 12 +++++++-----
> =A0arch/arm/mach-omap2/voltage.h =A0| =A0 =A06 ++++++
> =A03 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/oma=
p_twl.c
> index f96d4b2..42f66c6 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -157,6 +157,7 @@ static struct omap_volt_pmic_info omap3_mpu_volt_=
info =3D {
> =A0 =A0 =A0 =A0.onlp_cmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D twl4030_uv_t=
o_vsel,
> =A0 =A0 =A0 =A0.ret_cmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D twl4030_uv=
_to_vsel,
> =A0 =A0 =A0 =A0.off_cmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D twl4030_uv=
_to_vsel,
> + =A0 =A0 =A0 .voltage_class =A0=3D VP_VC_CLASS,

Do you need this all unassigned params in a static struct is 0 which
is basically VP_VC_CLASS.

> =A0};
>
> =A0static struct omap_volt_pmic_info omap3_core_volt_info =3D {
> @@ -176,6 +177,7 @@ static struct omap_volt_pmic_info omap3_core_volt=
_info =3D {
> =A0 =A0 =A0 =A0.onlp_cmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D twl4030_uv_t=
o_vsel,
> =A0 =A0 =A0 =A0.ret_cmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D twl4030_uv=
_to_vsel,
> =A0 =A0 =A0 =A0.off_cmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D twl4030_uv=
_to_vsel,
> + =A0 =A0 =A0 .voltage_class =A0=3D VP_VC_CLASS,
here as well

> =A0};
>
> =A0static struct omap_volt_pmic_info omap4_mpu_volt_info =3D {
> @@ -195,6 +197,7 @@ static struct omap_volt_pmic_info omap4_mpu_volt_=
info =3D {
> =A0 =A0 =A0 =A0.onlp_cmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D twl4030_uv_t=
o_vsel,
> =A0 =A0 =A0 =A0.ret_cmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D twl4030_uv=
_to_vsel,
> =A0 =A0 =A0 =A0.off_cmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D twl4030_uv=
_to_vsel,
> + =A0 =A0 =A0 .voltage_class =A0=3D VP_VC_CLASS,
again

> =A0};
>
> =A0static struct omap_volt_pmic_info omap4_iva_volt_info =3D {
> @@ -214,6 +217,7 @@ static struct omap_volt_pmic_info omap4_iva_volt_=
info =3D {
> =A0 =A0 =A0 =A0.onlp_cmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D twl4030_uv_t=
o_vsel,
> =A0 =A0 =A0 =A0.ret_cmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D twl4030_uv=
_to_vsel,
> =A0 =A0 =A0 =A0.off_cmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D twl4030_uv=
_to_vsel,
> + =A0 =A0 =A0 .voltage_class =A0=3D VP_VC_CLASS,
and again

> =A0};
>
> =A0static struct omap_volt_pmic_info omap4_core_volt_info =3D {
> @@ -233,6 +237,7 @@ static struct omap_volt_pmic_info omap4_core_volt=
_info =3D {
> =A0 =A0 =A0 =A0.onlp_cmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D twl4030_uv_t=
o_vsel,
> =A0 =A0 =A0 =A0.ret_cmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D twl4030_uv=
_to_vsel,
> =A0 =A0 =A0 =A0.off_cmd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D twl4030_uv=
_to_vsel,
> + =A0 =A0 =A0 .voltage_class =A0=3D VP_VC_CLASS,
and here
> =A0};
>
> =A0int __init omap4_twl_init(void)
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/volt=
age.c
> index 2ac990f..73fa3ee 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -1194,11 +1194,13 @@ int __init omap_voltage_late_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: Unable to create voltage d=
ebugfs main dir\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);
> =A0 =A0 =A0 =A0for (i =3D 0; i < nr_scalable_vdd; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_vdd_data_configure(vdd_info[i]=
))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vc_init(vdd_info[i]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_init(vdd_info[i]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd_debugfs_init(vdd_info[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vdd_info[i]->pmic_info->voltage_cla=
ss =3D=3D VP_VC_CLASS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_vdd_data_confi=
gure(vdd_info[i]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continu=
e;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vc_init(vdd_info[i=
]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_init(vdd_info[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd_debugfs_init(vdd_in=
fo[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/volt=
age.h
> index de4e09b..17b1e10
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -23,6 +23,9 @@
> =A0#define VOLTSCALE_VPFORCEUPDATE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> =A0#define VOLTSCALE_VCBYPASS =A0 =A0 =A0 =A0 =A0 =A0 2
>
> +#define VP_VC_CLASS 0
> +#define REGULATOR_CLASS 1
please - could you ensure namespace is proper in macro usage?
I dont understand usage difference between VP_VC_CLASS and REGULATOR_CL=
ASS

> +
> =A0/**
> =A0* struct omap_vfsm_instance_data - per-voltage manager FSM registe=
r/bitfield
> =A0* data
> @@ -87,6 +90,8 @@ struct omap_volt_data {
> =A0* @onlp_cmd: =A0PMIC API to send onlp command instruction
> =A0* @ret_cmd: =A0 PMIC API to send ret command instruction
> =A0* @off_cmd: =A0 PMIC API to send off command instruction
> + * @voltage_class: Voltage class used for voltage scaling (can be VP=
/VC method
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 or regula=
tor based method for now).
> =A0*/
> =A0struct omap_volt_pmic_info {
> =A0 =A0 =A0 =A0int slew_rate;
> @@ -105,6 +110,7 @@ struct omap_volt_pmic_info {
> =A0 =A0 =A0 =A0unsigned char (*onlp_cmd)(unsigned long uV);
> =A0 =A0 =A0 =A0unsigned char (*ret_cmd)(unsigned long uV);
> =A0 =A0 =A0 =A0unsigned char (*off_cmd)(unsigned long uV);
> + =A0 =A0 =A0 u8 voltage_class;
> =A0};
>
> =A0/**
> --
> 1.7.0.4
overall, other than deciding to initialize or not initialize VP/VC
based on class, I dont see how you have achieved $subject or $commit
message in terms of bring in bypass ability to VP/VC by introducing
class.

A) the $subject is wrong. you have just introduced voltage_class - I
suggest you state that instead.
B) how your patch achieves support for bypassing vp/vc is not clear
unfortunately.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
