From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [RFC 2/3] am35xx: voltage: Add basic initialization
Date: Thu, 24 Feb 2011 00:10:48 +0530
Message-ID: <AANLkTikus4t2Mgzy-DJeXxLF8z4MeciyQ3vo+EwXLPDj@mail.gmail.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com> <1298483913-20344-3-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:40572 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754665Ab1BWSl6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 13:41:58 -0500
Received: by mail-ww0-f43.google.com with SMTP id 17so8595962wwi.0
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 10:41:36 -0800 (PST)
In-Reply-To: <1298483913-20344-3-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, Feb 23, 2011 at 23:28, Sanjeev Premi <premi@ti.com> wrote:
> This patch adds basic initialization in
> the voltage layer for AM35xx processors.
>
> In absence of AVS, functions vp_init() and
> vc_init() are empty.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
> =A0arch/arm/mach-omap2/voltage.c | =A0 45 +++++++++++++++++++++++++++=
+++++++++++++-
> =A01 files changed, 44 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/volt=
age.c
> index bbc36e7..63dac11 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -194,6 +194,30 @@ static struct omap_vdd_info omap3_vdd_info[] =3D=
 {
>
> =A0#define OMAP3_NR_SCALABLE_VDD ARRAY_SIZE(omap3_vdd_info)
>
> +/*
> + * AM3517 VDD structures
> + * TODO: The values in vp_offs are just a copy of OMAP3 for now.
> + * =A0 =A0 =A0 Assignments need to be looked again; but appears that
> + * =A0 =A0 =A0 they won't ever be used.
> + */
> +static struct omap_vdd_info am3517_vdd_info[] =3D {
> + =A0 =A0 =A0 =A0{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.vp_offs =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.vpconfig =A0 =A0 =A0=
 =3D OMAP3_PRM_VP1_CONFIG_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.vstepmin =A0 =A0 =A0=
 =3D OMAP3_PRM_VP1_VSTEPMIN_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.vstepmax =A0 =A0 =A0=
 =3D OMAP3_PRM_VP1_VSTEPMAX_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.vlimitto =A0 =A0 =A0=
 =3D OMAP3_PRM_VP1_VLIMITTO_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.vstatus =A0 =A0 =A0=
 =A0=3D OMAP3_PRM_VP1_STATUS_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.voltage =A0 =A0 =A0=
 =A0=3D OMAP3_PRM_VP1_VOLTAGE_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.voltdm =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "mpu",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 =A0},
> +};
aah! no potential of scaling for Core domain here? ok, I am starting
to get the picture of your question in
http://marc.info/?t=3D129847134400006&r=3D1&w=3D2 with TPS65023.


> +
> +#define AM3517_NR_SCALABLE_VDD 0
> +
> =A0/* OMAP4 VDD sturctures */
> =A0static struct omap_vdd_info omap4_vdd_info[] =3D {
> =A0 =A0 =A0 =A0{
> @@ -1551,11 +1575,30 @@ int __init omap_voltage_late_init(void)
> =A0}
>
> =A0/**
> + * AM35xx - dummy initialization of voltage controller
> + */
> +static void __init am3517_vc_init(struct omap_vdd_info *vdd)
> +{
> +}
> +/**
> + * AM35xx - dummy initialization of voltage processor
> + */
> +static void __init am3517_vp_init(struct omap_vdd_info *vdd)
> +{
> +}
> +
> +/**
> =A0* omap_voltage_early_init()- Volatage driver early init
> =A0*/
> =A0static int __init omap_voltage_early_init(void)
> =A0{
> - =A0 =A0 =A0 if (cpu_is_omap34xx()) {
> + =A0 =A0 =A0 if (cpu_is_omap3505() || cpu_is_omap3517()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd_info =A0 =A0 =A0 =A0=3D am3517_vdd_=
info;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_scalable_vdd =3D AM3517_NR_SCALABLE_=
VDD;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vc_init =A0 =A0 =A0 =A0 =3D am3517_vc_i=
nit;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_init =A0 =A0 =A0 =A0 =3D am3517_vp_i=
nit;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd_data_configure =3D omap3_vdd_data_c=
onfigure;
> + =A0 =A0 =A0 } else if (cpu_is_omap34xx()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd_info =3D omap3_vdd_info;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nr_scalable_vdd =3D OMAP3_NR_SCALABLE_=
VDD;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vc_init =3D omap3_vc_init;
ok I think (maybe wrongly) features is a better mechanism to introduce
this here. may even be something to look at vc and vp as seperate
devices even initialized at hwmod level - currently we do not do it
and we have a messy voltage.c with all kind of offset initialization.


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
