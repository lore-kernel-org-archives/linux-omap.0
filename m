From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 05/13] OMAP2&3: hwmod: Remove _hwmod prefix in name
 string
Date: Wed, 23 Jun 2010 23:04:44 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006232302580.1550@utopia.booyaka.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com> <1277336563-24988-6-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-660243411-1277355884=:1550"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56587 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab0FXFEp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 01:04:45 -0400
In-Reply-To: <1277336563-24988-6-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-660243411-1277355884=:1550
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Beno=EEt,

one minor comment here:

On Wed, 23 Jun 2010, Kevin Hilman wrote:

> From: Benoit Cousson <b-cousson@ti.com>
>=20
> In the lastest OMAP4 hwmod data file, the _hwmod was removed
> in order to save some memory space and because it does not
> bring a lot.
> Align OMAP2420, 2430 and 3430 data files with the same convention.

Shouldn't we also synchronize the names of the structures as well?  i.e.,=
=20
if the name is changed to "l3_main", shouldn't the name of the structure=20
also be changed from=20

   static struct omap_hwmod omap2420_l3_hwmod =3D {

to=20

   static struct omap_hwmod omap2420_l3_main_hwmod =3D {

(... as one example?)


- Paul

>=20
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |    6 +++---
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 +++---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++----
>  3 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-o=
map2/omap_hwmod_2420_data.c
> index a8b57a6..646386c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -59,7 +59,7 @@ static struct omap_hwmod_ocp_if *omap2420_l3_masters[] =
=3D {
> =20
>  /* L3 */
>  static struct omap_hwmod omap2420_l3_hwmod =3D {
> -=09.name=09=09=3D "l3_hwmod",
> +=09.name=09=09=3D "l3_main",
>  =09.class=09=09=3D &l3_hwmod_class,
>  =09.masters=09=3D omap2420_l3_masters,
>  =09.masters_cnt=09=3D ARRAY_SIZE(omap2420_l3_masters),
> @@ -90,7 +90,7 @@ static struct omap_hwmod_ocp_if *omap2420_l4_core_maste=
rs[] =3D {
> =20
>  /* L4 CORE */
>  static struct omap_hwmod omap2420_l4_core_hwmod =3D {
> -=09.name=09=09=3D "l4_core_hwmod",
> +=09.name=09=09=3D "l4_core",
>  =09.class=09=09=3D &l4_hwmod_class,
>  =09.masters=09=3D omap2420_l4_core_masters,
>  =09.masters_cnt=09=3D ARRAY_SIZE(omap2420_l4_core_masters),
> @@ -111,7 +111,7 @@ static struct omap_hwmod_ocp_if *omap2420_l4_wkup_mas=
ters[] =3D {
> =20
>  /* L4 WKUP */
>  static struct omap_hwmod omap2420_l4_wkup_hwmod =3D {
> -=09.name=09=09=3D "l4_wkup_hwmod",
> +=09.name=09=09=3D "l4_wkup",
>  =09.class=09=09=3D &l4_hwmod_class,
>  =09.masters=09=3D omap2420_l4_wkup_masters,
>  =09.masters_cnt=09=3D ARRAY_SIZE(omap2420_l4_wkup_masters),
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-o=
map2/omap_hwmod_2430_data.c
> index 8b1f74b..b2100cf 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -59,7 +59,7 @@ static struct omap_hwmod_ocp_if *omap2430_l3_masters[] =
=3D {
> =20
>  /* L3 */
>  static struct omap_hwmod omap2430_l3_hwmod =3D {
> -=09.name=09=09=3D "l3_hwmod",
> +=09.name=09=09=3D "l3_main",
>  =09.class=09=09=3D &l3_hwmod_class,
>  =09.masters=09=3D omap2430_l3_masters,
>  =09.masters_cnt=09=3D ARRAY_SIZE(omap2430_l3_masters),
> @@ -92,7 +92,7 @@ static struct omap_hwmod_ocp_if *omap2430_l4_core_maste=
rs[] =3D {
> =20
>  /* L4 CORE */
>  static struct omap_hwmod omap2430_l4_core_hwmod =3D {
> -=09.name=09=09=3D "l4_core_hwmod",
> +=09.name=09=09=3D "l4_core",
>  =09.class=09=09=3D &l4_hwmod_class,
>  =09.masters=09=3D omap2430_l4_core_masters,
>  =09.masters_cnt=09=3D ARRAY_SIZE(omap2430_l4_core_masters),
> @@ -113,7 +113,7 @@ static struct omap_hwmod_ocp_if *omap2430_l4_wkup_mas=
ters[] =3D {
> =20
>  /* L4 WKUP */
>  static struct omap_hwmod omap2430_l4_wkup_hwmod =3D {
> -=09.name=09=09=3D "l4_wkup_hwmod",
> +=09.name=09=09=3D "l4_wkup",
>  =09.class=09=09=3D &l4_hwmod_class,
>  =09.masters=09=3D omap2430_l4_wkup_masters,
>  =09.masters_cnt=09=3D ARRAY_SIZE(omap2430_l4_wkup_masters),
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_3xxx_data.c
> index e288b20..ec6a5f8 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -70,7 +70,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l3_masters[] =
=3D {
> =20
>  /* L3 */
>  static struct omap_hwmod omap3xxx_l3_hwmod =3D {
> -=09.name=09=09=3D "l3_hwmod",
> +=09.name=09=09=3D "l3_main",
>  =09.class=09=09=3D &l3_hwmod_class,
>  =09.masters=09=3D omap3xxx_l3_masters,
>  =09.masters_cnt=09=3D ARRAY_SIZE(omap3xxx_l3_masters),
> @@ -101,7 +101,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_core_mas=
ters[] =3D {
> =20
>  /* L4 CORE */
>  static struct omap_hwmod omap3xxx_l4_core_hwmod =3D {
> -=09.name=09=09=3D "l4_core_hwmod",
> +=09.name=09=09=3D "l4_core",
>  =09.class=09=09=3D &l4_hwmod_class,
>  =09.masters=09=3D omap3xxx_l4_core_masters,
>  =09.masters_cnt=09=3D ARRAY_SIZE(omap3xxx_l4_core_masters),
> @@ -122,7 +122,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_per_mast=
ers[] =3D {
> =20
>  /* L4 PER */
>  static struct omap_hwmod omap3xxx_l4_per_hwmod =3D {
> -=09.name=09=09=3D "l4_per_hwmod",
> +=09.name=09=09=3D "l4_per",
>  =09.class=09=09=3D &l4_hwmod_class,
>  =09.masters=09=3D omap3xxx_l4_per_masters,
>  =09.masters_cnt=09=3D ARRAY_SIZE(omap3xxx_l4_per_masters),
> @@ -143,7 +143,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_mas=
ters[] =3D {
> =20
>  /* L4 WKUP */
>  static struct omap_hwmod omap3xxx_l4_wkup_hwmod =3D {
> -=09.name=09=09=3D "l4_wkup_hwmod",
> +=09.name=09=09=3D "l4_wkup",
>  =09.class=09=09=3D &l4_hwmod_class,
>  =09.masters=09=3D omap3xxx_l4_wkup_masters,
>  =09.masters_cnt=09=3D ARRAY_SIZE(omap3xxx_l4_wkup_masters),
> --=20
> 1.7.0.2
>=20


- Paul
--155748971-660243411-1277355884=:1550--
