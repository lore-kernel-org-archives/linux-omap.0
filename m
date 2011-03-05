From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH v2] OMAP2PLUS: Replace voltage values with Macros
Date: Sat, 5 Mar 2011 15:48:49 +0530
Message-ID: <AANLkTinm1Sdd+KdwWLKm9U3Wk1xJ1p=w++0dorSvG5iz@mail.gmail.com>
References: <1299202127-28863-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:50563 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751109Ab1CEKTM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 5 Mar 2011 05:19:12 -0500
Received: by wyb32 with SMTP id 32so4290025wyb.27
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 02:19:09 -0800 (PST)
In-Reply-To: <1299202127-28863-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vishwanath BS <vishwanath.bs@ti.com>

2011/3/4 Nishanth Menon <nm@ti.com>:
> From: Vishwanath BS <vishwanath.bs@ti.com>
>
> Since all voltage data is now centralized in oppxxx_data.c, we can re=
move
> the replace the values in the opp table with the macros used for volt=
age
> values. =A0This will avoid opp table and voltage layer having conflic=
ting
> values.
dropping this patch -> i will post a v3 in a couple of mins. realized
that the $subject and commit message could be improved a bit :(

Regards,
Nishanth Menon


>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
> This patch has 3 line over 80 char warning. This is retained for read=
ability
> purposes.
>
> v2: Rebased to pm-core (since pm-core now has voltage layer cleanups)
>
> v1: http://marc.info/?l=3Dlinux-omap&m=3D129683786100355&w=3D2
>
> =A0arch/arm/mach-omap2/opp3xxx_data.c | =A0 46 ++++++++++++++++++----=
--------------
> =A0arch/arm/mach-omap2/opp4xxx_data.c | =A0 12 ++++----
> =A02 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2=
/opp3xxx_data.c
> index d2bd1bd..d95f3f9 100644
> --- a/arch/arm/mach-omap2/opp3xxx_data.c
> +++ b/arch/arm/mach-omap2/opp3xxx_data.c
> @@ -89,15 +89,15 @@ struct omap_volt_data omap36xx_vddcore_volt_data[=
] =3D {
>
> =A0static struct omap_opp_def __initdata omap34xx_opp_def_list[] =3D =
{
> =A0 =A0 =A0 =A0/* MPU OPP1 */
> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 125000000, 975000),
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 125000000, OMAP3430_VDD_MP=
U_OPP1_UV),
> =A0 =A0 =A0 =A0/* MPU OPP2 */
> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 250000000, 1075000),
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 250000000, OMAP3430_VDD_MP=
U_OPP2_UV),
> =A0 =A0 =A0 =A0/* MPU OPP3 */
> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 500000000, 1200000),
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 500000000, OMAP3430_VDD_MP=
U_OPP3_UV),
> =A0 =A0 =A0 =A0/* MPU OPP4 */
> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 550000000, 1270000),
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 550000000, OMAP3430_VDD_MP=
U_OPP4_UV),
> =A0 =A0 =A0 =A0/* MPU OPP5 */
> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 600000000, 1350000),
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 600000000, OMAP3430_VDD_MP=
U_OPP5_UV),
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * L3 OPP1 - 41.5 MHz is disabled because: The voltage=
 for that OPP is
> @@ -107,47 +107,47 @@ static struct omap_opp_def __initdata omap34xx_=
opp_def_list[] =3D {
> =A0 =A0 =A0 =A0 * impact that frequency will do to the MPU and the wh=
ole system in
> =A0 =A0 =A0 =A0 * general.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 OPP_INITIALIZER("l3_main", false, 41500000, 975000),
> + =A0 =A0 =A0 OPP_INITIALIZER("l3_main", false, 41500000, OMAP3430_VD=
D_CORE_OPP1_UV),
> =A0 =A0 =A0 =A0/* L3 OPP2 */
> - =A0 =A0 =A0 OPP_INITIALIZER("l3_main", true, 83000000, 1050000),
> + =A0 =A0 =A0 OPP_INITIALIZER("l3_main", true, 83000000, OMAP3430_VDD=
_CORE_OPP2_UV),
> =A0 =A0 =A0 =A0/* L3 OPP3 */
> - =A0 =A0 =A0 OPP_INITIALIZER("l3_main", true, 166000000, 1150000),
> + =A0 =A0 =A0 OPP_INITIALIZER("l3_main", true, 166000000, OMAP3430_VD=
D_CORE_OPP3_UV),
>
> =A0 =A0 =A0 =A0/* DSP OPP1 */
> - =A0 =A0 =A0 OPP_INITIALIZER("iva", true, 90000000, 975000),
> + =A0 =A0 =A0 OPP_INITIALIZER("iva", true, 90000000, OMAP3430_VDD_MPU=
_OPP1_UV),
> =A0 =A0 =A0 =A0/* DSP OPP2 */
> - =A0 =A0 =A0 OPP_INITIALIZER("iva", true, 180000000, 1075000),
> + =A0 =A0 =A0 OPP_INITIALIZER("iva", true, 180000000, OMAP3430_VDD_MP=
U_OPP2_UV),
> =A0 =A0 =A0 =A0/* DSP OPP3 */
> - =A0 =A0 =A0 OPP_INITIALIZER("iva", true, 360000000, 1200000),
> + =A0 =A0 =A0 OPP_INITIALIZER("iva", true, 360000000, OMAP3430_VDD_MP=
U_OPP3_UV),
> =A0 =A0 =A0 =A0/* DSP OPP4 */
> - =A0 =A0 =A0 OPP_INITIALIZER("iva", true, 400000000, 1270000),
> + =A0 =A0 =A0 OPP_INITIALIZER("iva", true, 400000000, OMAP3430_VDD_MP=
U_OPP4_UV),
> =A0 =A0 =A0 =A0/* DSP OPP5 */
> - =A0 =A0 =A0 OPP_INITIALIZER("iva", true, 430000000, 1350000),
> + =A0 =A0 =A0 OPP_INITIALIZER("iva", true, 430000000, OMAP3430_VDD_MP=
U_OPP5_UV),
> =A0};
>
> =A0static struct omap_opp_def __initdata omap36xx_opp_def_list[] =3D =
{
> =A0 =A0 =A0 =A0/* MPU OPP1 - OPP50 */
> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, =A0300000000, 1012500),
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, =A0300000000, OMAP3630_VDD=
_MPU_OPP50_UV),
> =A0 =A0 =A0 =A0/* MPU OPP2 - OPP100 */
> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, =A0600000000, 1200000),
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, =A0600000000, OMAP3630_VDD=
_MPU_OPP100_UV),
> =A0 =A0 =A0 =A0/* MPU OPP3 - OPP-Turbo */
> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", false, 800000000, 1325000),
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", false, 800000000, OMAP3630_VDD_M=
PU_OPP120_UV),
> =A0 =A0 =A0 =A0/* MPU OPP4 - OPP-SB */
> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", false, 1000000000, 1375000),
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", false, 1000000000, OMAP3630_VDD_=
MPU_OPP1G_UV),
>
> =A0 =A0 =A0 =A0/* L3 OPP1 - OPP50 */
> - =A0 =A0 =A0 OPP_INITIALIZER("l3_main", true, 100000000, 1000000),
> + =A0 =A0 =A0 OPP_INITIALIZER("l3_main", true, 100000000, OMAP3630_VD=
D_CORE_OPP50_UV),
> =A0 =A0 =A0 =A0/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
> - =A0 =A0 =A0 OPP_INITIALIZER("l3_main", true, 200000000, 1200000),
> + =A0 =A0 =A0 OPP_INITIALIZER("l3_main", true, 200000000, OMAP3630_VD=
D_CORE_OPP100_UV),
>
> =A0 =A0 =A0 =A0/* DSP OPP1 - OPP50 */
> - =A0 =A0 =A0 OPP_INITIALIZER("iva", true, =A0260000000, 1012500),
> + =A0 =A0 =A0 OPP_INITIALIZER("iva", true, =A0260000000, OMAP3630_VDD=
_MPU_OPP50_UV),
> =A0 =A0 =A0 =A0/* DSP OPP2 - OPP100 */
> - =A0 =A0 =A0 OPP_INITIALIZER("iva", true, =A0520000000, 1200000),
> + =A0 =A0 =A0 OPP_INITIALIZER("iva", true, =A0520000000, OMAP3630_VDD=
_MPU_OPP100_UV),
> =A0 =A0 =A0 =A0/* DSP OPP3 - OPP-Turbo */
> - =A0 =A0 =A0 OPP_INITIALIZER("iva", false, 660000000, 1325000),
> + =A0 =A0 =A0 OPP_INITIALIZER("iva", false, 660000000, OMAP3630_VDD_M=
PU_OPP120_UV),
> =A0 =A0 =A0 =A0/* DSP OPP4 - OPP-SB */
> - =A0 =A0 =A0 OPP_INITIALIZER("iva", false, 800000000, 1375000),
> + =A0 =A0 =A0 OPP_INITIALIZER("iva", false, 800000000, OMAP3630_VDD_M=
PU_OPP1G_UV),
> =A0};
>
> =A0/**
> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2=
/opp4xxx_data.c
> index 5030794..57f1498 100644
> --- a/arch/arm/mach-omap2/opp4xxx_data.c
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -67,17 +67,17 @@ struct omap_volt_data omap44xx_vdd_core_volt_data=
[] =3D {
>
> =A0static struct omap_opp_def __initdata omap44xx_opp_def_list[] =3D =
{
> =A0 =A0 =A0 =A0/* MPU OPP1 - OPP50 */
> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 300000000, 1100000),
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 300000000, OMAP4430_VDD_MP=
U_OPP50_UV),
> =A0 =A0 =A0 =A0/* MPU OPP2 - OPP100 */
> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 600000000, 1200000),
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 600000000, OMAP4430_VDD_MP=
U_OPP100_UV),
> =A0 =A0 =A0 =A0/* MPU OPP3 - OPP-Turbo */
> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", false, 800000000, 1260000),
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", false, 800000000, OMAP4430_VDD_M=
PU_OPPTURBO_UV),
> =A0 =A0 =A0 =A0/* MPU OPP4 - OPP-SB */
> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", false, 1008000000, 1350000),
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", false, 1008000000, OMAP4430_VDD_=
MPU_OPPNITRO_UV),
> =A0 =A0 =A0 =A0/* L3 OPP1 - OPP50 */
> - =A0 =A0 =A0 OPP_INITIALIZER("l3_main_1", true, 100000000, 930000),
> + =A0 =A0 =A0 OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4430_=
VDD_CORE_OPP50_UV),
> =A0 =A0 =A0 =A0/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
> - =A0 =A0 =A0 OPP_INITIALIZER("l3_main_1", true, 200000000, 1100000),
> + =A0 =A0 =A0 OPP_INITIALIZER("l3_main_1", true, 200000000, OMAP4430_=
VDD_CORE_OPP100_UV),
> =A0 =A0 =A0 =A0/* TODO: add IVA, DSP, aess, fdif, gpu */
> =A0};
>
> --
> 1.7.1
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
