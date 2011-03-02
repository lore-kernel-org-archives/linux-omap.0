From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 3/3] OMAP4: Enable Turbo and Nitro OPP for OMAP4
Date: Wed, 2 Mar 2011 16:58:23 +0530
Message-ID: <AANLkTiny+AM9p-AsmJwsJttxuuUoDwceZL=7TWRCmphR@mail.gmail.com>
References: <1297837112-8924-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:52349 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753556Ab1CBL2p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Mar 2011 06:28:45 -0500
Received: by wwe15 with SMTP id 15so6412378wwe.24
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 03:28:43 -0800 (PST)
In-Reply-To: <1297837112-8924-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, Feb 16, 2011 at 11:48, Shweta Gulati <shweta.gulati@ti.com> wro=
te:
> All OMAP4 boards support OPP-Turbo (800M) and OPP-Nitro (1G).
s/All OMAP4/Almost all/ - there are a minority of boards that use
OMAP4430-800 device instead of the OMAP4430-1000 device.
Also please use the full term 1GHz instead of 1G
> Enable them by default in OPPTable. For 800Mhz devices where
s/For 800Mhz/For the small minority of boards which use OMAP4430-800
(800MHz device),
> OPP-Nitro is not supported, OPP-Nitro should be disabled
> from board file.

even though the TI documentation terminology is Turbo, Nitro etc.., I
suggest using frequencies to better map things historically.
>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> ---
> =A0arch/arm/mach-omap2/opp4xxx_data.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2=
/opp4xxx_data.c
> index 705fe9a..48d79e5 100644
> --- a/arch/arm/mach-omap2/opp4xxx_data.c
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -31,9 +31,9 @@ static struct omap_opp_def __initdata omap44xx_opp_=
def_list[] =3D {
> =A0 =A0 =A0 =A0/* MPU OPP2 - OPP100 */
> =A0 =A0 =A0 =A0OPP_INITIALIZER("mpu", true, 600000000, OMAP4430_VDD_M=
PU_OPP100_UV),
> =A0 =A0 =A0 =A0/* MPU OPP3 - OPP-Turbo */
> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", false, 800000000, OMAP4430_VDD_M=
PU_OPPTURBO_UV),
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 800000000, OMAP4430_VDD_MP=
U_OPPTURBO_UV),
> =A0 =A0 =A0 =A0/* MPU OPP4 - OPP-SB */
> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", false, 1008000000, OMAP4430_VDD_=
MPU_OPPNITRO_UV),
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 1008000000, OMAP4430_VDD_M=
PU_OPPNITRO_UV),
> =A0 =A0 =A0 =A0/* L3 OPP1 - OPP50 */
> =A0 =A0 =A0 =A0OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4430=
_VDD_CORE_OPP50_UV),
> =A0 =A0 =A0 =A0/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
> --
> 1.7.0.4

I am ok with the overall patch - with the minor suggestions above.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
