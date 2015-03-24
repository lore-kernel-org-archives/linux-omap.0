From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 2/2] ARM: DRA7: hwmod: Fix the hwmod class for GPTimer4
Date: Tue, 24 Mar 2015 14:23:52 -0500
Message-ID: <5511B9C8.8010703@ti.com>
References: <1426539294-28375-1-git-send-email-s-anna@ti.com> <1426539294-28375-3-git-send-email-s-anna@ti.com> <alpine.DEB.2.02.1503241805060.16497@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53809 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932584AbbCXTYS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2015 15:24:18 -0400
In-Reply-To: <alpine.DEB.2.02.1503241805060.16497@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/24/2015 01:06 PM, Paul Walmsley wrote:
> On Mon, 16 Mar 2015, Suman Anna wrote:
>=20
>> GPTimer 4 is a regular timer and not a secure timer, so fix
>> the hwmod to use the correct hwmod class (even though there
>> are no differences in the class definition itself).
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>=20
> This one results in compiler warnings:
>=20
> arch/arm/mach-omap2/omap_hwmod_7xx_data.c:1776:32: warning:=20
> =A1dra7xx_timer_secure_hwmod_class=A2 defined but not used [-Wunused-=
variable]
>  static struct omap_hwmod_class dra7xx_timer_secure_hwmod_class =3D {
>=20
> Have queued the following for v4.1.

Thanks Paul. I will add it back when I post the hwmod for Timer 12, I
had the Timer12 locally in my tree, so missed the warning.

regards
Suman

>=20
>=20
> - Paul
>=20
> From: Suman Anna <s-anna@ti.com>
> Date: Mon, 16 Mar 2015 15:54:54 -0500
> Subject: [PATCH] ARM: DRA7: hwmod: Fix the hwmod class for GPTimer4
>=20
> GPTimer 4 is a regular timer and not a secure timer, so fix
> the hwmod to use the correct hwmod class (even though there
> are no differences in the class definition itself).
>=20
> Signed-off-by: Suman Anna <s-anna@ti.com>
> [paul@pwsan.com: dropped dra7xx_timer_secure_hwmod_class and
>  dra7xx_timer_secure_sysc to avoid compiler warnings]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mac=
h-omap2/omap_hwmod_7xx_data.c
> index d0f03e73add4..701234d8db1b 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1763,21 +1763,6 @@ static struct omap_hwmod_class dra7xx_timer_1m=
s_hwmod_class =3D {
>  	.sysc	=3D &dra7xx_timer_1ms_sysc,
>  };
> =20
> -static struct omap_hwmod_class_sysconfig dra7xx_timer_secure_sysc =3D=
 {
> -	.rev_offs	=3D 0x0000,
> -	.sysc_offs	=3D 0x0010,
> -	.sysc_flags	=3D (SYSC_HAS_EMUFREE | SYSC_HAS_RESET_STATUS |
> -			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
> -	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> -			   SIDLE_SMART_WKUP),
> -	.sysc_fields	=3D &omap_hwmod_sysc_type2,
> -};
> -
> -static struct omap_hwmod_class dra7xx_timer_secure_hwmod_class =3D {
> -	.name	=3D "timer",
> -	.sysc	=3D &dra7xx_timer_secure_sysc,
> -};
> -
>  static struct omap_hwmod_class_sysconfig dra7xx_timer_sysc =3D {
>  	.rev_offs	=3D 0x0000,
>  	.sysc_offs	=3D 0x0010,
> @@ -1841,7 +1826,7 @@ static struct omap_hwmod dra7xx_timer3_hwmod =3D=
 {
>  /* timer4 */
>  static struct omap_hwmod dra7xx_timer4_hwmod =3D {
>  	.name		=3D "timer4",
> -	.class		=3D &dra7xx_timer_secure_hwmod_class,
> +	.class		=3D &dra7xx_timer_hwmod_class,
>  	.clkdm_name	=3D "l4per_clkdm",
>  	.main_clk	=3D "timer4_gfclk_mux",
>  	.prcm =3D {
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
