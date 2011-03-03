From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC] AM35x: Workaround to use generic OMAP3 hwmods
Date: Thu, 3 Mar 2011 16:15:51 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103031614440.10981@utopia.booyaka.com>
References: <1298641689-7417-1-git-send-email-premi@ti.com> <4D67E0C0.4080805@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-968895443-1299194151=:10981"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35487 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758989Ab1CCXPw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 18:15:52 -0500
In-Reply-To: <4D67E0C0.4080805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-968895443-1299194151=:10981
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt,

one question about this.

On Fri, 25 Feb 2011, Cousson, Benoit wrote:

> From 09506eedef901af0fa19ddb48f486ce4ef353645 Mon Sep 17 00:00:00 2001
> From: Benoit Cousson <b-cousson@ti.com>
> Date: Fri, 25 Feb 2011 17:46:33 +0100
> Subject: [PATCH] OMAP3: hwmod data: Remove masters port links for
> interconnects.
>=20
> Master ports from interconnect are generating some annoying circular
> references that become tricky to handle if we have to dynamically
> remove some IP on some variant platforms.
> Since they are not used for the moment, and since we can still build
> that relation using the reverse relation (slave port from the IP
> toward master port of the interconnect), let remove them for the
> moment like it is done on OMAP4.
>=20
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   28
> ----------------------------
>  1 files changed, 0 insertions(+), 28 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 7fa2dfb..0e7d43f 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -463,26 +463,12 @@ static struct omap_hwmod_ocp_if
> *am35xx_usbhsotg_slaves[] =3D {
>  /* Slave interfaces on the L4_CORE interconnect */
>  static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] =3D {
>  =09&omap3xxx_l3_main__l4_core,
> -=09&omap3_l4_core__sr1,
> -=09&omap3_l4_core__sr2,

Is there some reason why these SR OCP slaves are removed?

> -};
> -
> -/* Master interfaces on the L4_CORE interconnect */
> -static struct omap_hwmod_ocp_if *omap3xxx_l4_core_masters[] =3D {
> -=09&omap3xxx_l4_core__l4_wkup,
> -=09&omap3_l4_core__uart1,
> -=09&omap3_l4_core__uart2,
> -=09&omap3_l4_core__i2c1,
> -=09&omap3_l4_core__i2c2,
> -=09&omap3_l4_core__i2c3,
>  };
>=20
>  /* L4 CORE */
>  static struct omap_hwmod omap3xxx_l4_core_hwmod =3D {
>  =09.name=09=09=3D "l4_core",
>  =09.class=09=09=3D &l4_hwmod_class,
> -=09.masters=09=3D omap3xxx_l4_core_masters,
> -=09.masters_cnt=09=3D ARRAY_SIZE(omap3xxx_l4_core_masters),
>  =09.slaves=09=09=3D omap3xxx_l4_core_slaves,
>  =09.slaves_cnt=09=3D ARRAY_SIZE(omap3xxx_l4_core_slaves),
>  =09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> @@ -494,18 +480,10 @@ static struct omap_hwmod_ocp_if
> *omap3xxx_l4_per_slaves[] =3D {
>  =09&omap3xxx_l3_main__l4_per,
>  };
>=20
> -/* Master interfaces on the L4_PER interconnect */
> -static struct omap_hwmod_ocp_if *omap3xxx_l4_per_masters[] =3D {
> -=09&omap3_l4_per__uart3,
> -=09&omap3_l4_per__uart4,
> -};
> -
>  /* L4 PER */
>  static struct omap_hwmod omap3xxx_l4_per_hwmod =3D {
>  =09.name=09=09=3D "l4_per",
>  =09.class=09=09=3D &l4_hwmod_class,
> -=09.masters=09=3D omap3xxx_l4_per_masters,
> -=09.masters_cnt=09=3D ARRAY_SIZE(omap3xxx_l4_per_masters),
>  =09.slaves=09=09=3D omap3xxx_l4_per_slaves,
>  =09.slaves_cnt=09=3D ARRAY_SIZE(omap3xxx_l4_per_slaves),
>  =09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> @@ -517,16 +495,10 @@ static struct omap_hwmod_ocp_if
> *omap3xxx_l4_wkup_slaves[] =3D {
>  =09&omap3xxx_l4_core__l4_wkup,
>  };
>=20
> -/* Master interfaces on the L4_WKUP interconnect */
> -static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_masters[] =3D {
> -};
> -
>  /* L4 WKUP */
>  static struct omap_hwmod omap3xxx_l4_wkup_hwmod =3D {
>  =09.name=09=09=3D "l4_wkup",
>  =09.class=09=09=3D &l4_hwmod_class,
> -=09.masters=09=3D omap3xxx_l4_wkup_masters,
> -=09.masters_cnt=09=3D ARRAY_SIZE(omap3xxx_l4_wkup_masters),
>  =09.slaves=09=09=3D omap3xxx_l4_wkup_slaves,
>  =09.slaves_cnt=09=3D ARRAY_SIZE(omap3xxx_l4_wkup_slaves),
>  =09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> --=20
> 1.7.0.4
>=20


- Paul
--155748971-968895443-1299194151=:10981--
