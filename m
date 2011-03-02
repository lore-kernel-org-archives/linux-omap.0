From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 2/3] OMAP2+: Replace Voltage values with Macros.
Date: Wed, 2 Mar 2011 17:02:39 +0530
Message-ID: <AANLkTinuEbOK3duA-CCXPWsXz9QQD7tr-t8MaskoyzzT@mail.gmail.com>
References: <1297837073-8874-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:50330 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753556Ab1CBLdB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Mar 2011 06:33:01 -0500
Received: by mail-wy0-f175.google.com with SMTP id 38so5542612wyb.6
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 03:32:59 -0800 (PST)
In-Reply-To: <1297837073-8874-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, Vishwanath BS <vishwanath.bs@ti.com>

2011/2/16 Shweta Gulati <shweta.gulati@ti.com>:
> From: Vishwanath BS <vishwanath.bs@ti.com>
>
> Currently voltage values on opp tables are hardcoded. As these voltag=
e values
> are anyway defined in voltage.h as macros, opp table can reuse these =
values.
> This will avoid opp table and voltage layer having conflicting values=
=2E

Acked-by: Nishanth Menon <nm@ti.com>

Warning: with the cleanups that Paul is doing in
http://marc.info/?l=3Dlinux-arm-kernel&m=3D129867019501257&w=3D2
There can be some sets of minor conflicts.

Regards,
Nishanth Menon


>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> ---
> =A0arch/arm/mach-omap2/opp3xxx_data.c | =A0 47 ++++++++++++++++++----=
-------------
> =A0arch/arm/mach-omap2/opp4xxx_data.c | =A0 13 +++++----
> =A02 files changed, 31 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2=
/opp3xxx_data.c
> index fd3a1af..e3ea9ba 100644
> --- a/arch/arm/mach-omap2/opp3xxx_data.c
> +++ b/arch/arm/mach-omap2/opp3xxx_data.c
> @@ -19,21 +19,22 @@
> =A0#include <linux/module.h>
>
> =A0#include <plat/cpu.h>
> +#include <plat/voltage.h>
>
> =A0#include "omap_opp_data.h"
> =A0#include "pm.h"
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
> @@ -43,47 +44,47 @@ static struct omap_opp_def __initdata omap34xx_op=
p_def_list[] =3D {
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
> index f0e9939..705fe9a 100644
> --- a/arch/arm/mach-omap2/opp4xxx_data.c
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -20,23 +20,24 @@
> =A0#include <linux/module.h>
>
> =A0#include <plat/cpu.h>
> +#include <plat/voltage.h>
>
> =A0#include "omap_opp_data.h"
> =A0#include "pm.h"
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
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
