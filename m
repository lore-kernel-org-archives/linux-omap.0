From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Integration branch base switchover to Tony's omap-for-linus
 branch
Date: Mon, 7 Mar 2011 16:25:14 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103071622540.10981@utopia.booyaka.com>
References: <alpine.DEB.2.00.1102251722450.6198@utopia.booyaka.com> <3f332cbd75f835ca119bdeccd72c4bb2@mail.gmail.com> <alpine.DEB.2.00.1103011431240.16349@utopia.booyaka.com> <4D6F89FB.7080201@ti.com> <4D70F25C.4040206@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-171305276-1299540314=:10981"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45754 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756783Ab1CGXZQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 18:25:16 -0500
In-Reply-To: <4D70F25C.4040206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, b-cousson@ti.com
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-171305276-1299540314=:10981
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Rajendra, Santosh,

On Fri, 4 Mar 2011, Rajendra Nayak wrote:

> On Thursday 03 March 2011 06:00 PM, Rajendra Nayak wrote:
> =20
> > Also some more testing showed up a lockup in suspend on OMAP4 which I
> > could narrow down to a similar case with GPT1. Either keeping the
> > staticdep between MPU and L4_WKUP _or_ forcing GPT1 to use software
> > idle control seems to help.
>=20
> This however is still not rootcaused and is not the same as the issue
> seen with i2c as the WE for GPT1 is already programmed for enabling
> wakeup.
>=20
> The one way to fix this for now is to put GPT1 block in software
> controlled idle as was done by your test patch for i2c.

OK, thanks for the update.

Beno=EEt, do you have any more OMAP4 hwmod patches for 2.6.39?  If not, wan=
t=20
to send an Acked-by:, and either Tony or I will take this one?


- Paul

> ---
> From fde94c22bb2db233b0b0cc4c2024d6f4e9f95257 Mon Sep 17 00:00:00 2001
> From: Rajendra Nayak <rnayak@ti.com>
> Date: Fri, 4 Mar 2011 19:33:45 +0530
> Subject: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle for GPT1
>=20
> Some issues seen (which cause lockups in suspend) with GPT1
> after the MPU<->L4_WKUP static dependency was cleared can be
> Worked-around for now by forcing GPT1 in software
> controlled idle.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 2c58827..9317a05 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -3989,7 +3989,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer1_slaves[] =3D {
>  static struct omap_hwmod omap44xx_timer1_hwmod =3D {
>         .name           =3D "timer1",
>         .class          =3D &omap44xx_timer_1ms_hwmod_class,
> -       .flags          =3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
> +       .flags          =3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET |
> HWMOD_SWSUP_SIDLE,
>         .mpu_irqs       =3D omap44xx_timer1_irqs,
>         .mpu_irqs_cnt   =3D ARRAY_SIZE(omap44xx_timer1_irqs),
>         .main_clk       =3D "timer1_fck",
> --=20
> 1.7.0.4


- Paul
--155748971-171305276-1299540314=:10981--
