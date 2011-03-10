From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC] AM35x: Workaround to use generic OMAP3 hwmods
Date: Thu, 10 Mar 2011 11:23:41 +0100
Message-ID: <4D78A6AD.8090403@ti.com>
References: <1298641689-7417-1-git-send-email-premi@ti.com> <4D67E0C0.4080805@ti.com> <alpine.DEB.2.00.1103091933260.15132@utopia.booyaka.com> <4D788E43.4040201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58310 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab1CJKXo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 05:23:44 -0500
In-Reply-To: <4D788E43.4040201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 3/10/2011 9:39 AM, Cousson, Benoit wrote:
> Salut Paul,
>=20
> On 3/10/2011 3:37 AM, Paul Walmsley wrote:
>>
>> Hi,
>>
>> I just queued a patch to fix the SmartReflex problem.  It's the part=
 that
>> fixes the incorrect data:
>>
>>       http://marc.info/?l=3Dlinux-omap&m=3D129972435510631&w=3D2
>>
>> Beno=EEt, if you are happy with it, care to send an Acked-by:?  Also=
, I
>> guess we should revisit the other part of your patch at some point.
>=20
> I'm almost fine with it, but if you do not want to remove the other
> masters ports of the interconnect, then you should move SR ocp_if fro=
m
> slaves to masters first, like it was supposed to be during the
> introduction of the SR data?
>=20
> And then remove all the interconnect master list in a second patch?

Please find below the 2 patches, rebased on top of the latest omap-for-=
linus.

git://gitorious.org/omap-pm/linux.git for_2.6.39/omap3_hwmod_data

Regards,
Benoit

---
=46rom b9ccf8afe2d2eafe18f90d2925f8464313fe0b56 Mon Sep 17 00:00:00 200=
1
=46rom: Benoit Cousson <b-cousson@ti.com>
Date: Thu, 10 Mar 2011 10:53:15 +0100
Subject: [PATCH 1/2] OMAP3: hwmod data: Fix incorrect SmartReflex -> L4=
 CORE interconnect links
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Commit d34427267186827dfd62bd8cf726601fffb22534 ("OMAP3: PM: Adding
smartreflex hwmod data") added data that claims that the L4 CORE has
two slave interfaces that originate from the SmartReflex modules,
omap3_l4_core__sr1 and omap3_l4_core__sr2.  But as those two data
structure records show, it's L4 CORE that has a master port towards
SR1 and SR2.
Move the incorrect data from slaves list to master list.

Based on a path by Paul Walmsley <paul@pwsan.com>

    https://patchwork.kernel.org/patch/623171/

That is based on a patch by Beno=C3=AEt Cousson <b-cousson@ti.com>:

    https://patchwork.kernel.org/patch/590561/

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_3xxx_data.c
index c4ca005..dec329f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -491,8 +491,6 @@ static struct omap_hwmod_ocp_if *am35xx_usbhsotg_sl=
aves[] =3D {
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] =3D {
 	&omap3xxx_l3_main__l4_core,
-	&omap3_l4_core__sr1,
-	&omap3_l4_core__sr2,
 };
=20
 /* Master interfaces on the L4_CORE interconnect */
@@ -503,6 +501,8 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_core_m=
asters[] =3D {
 	&omap3_l4_core__i2c1,
 	&omap3_l4_core__i2c2,
 	&omap3_l4_core__i2c3,
+	&omap3_l4_core__sr1,
+	&omap3_l4_core__sr2,
 };
=20
 /* L4 CORE */
--=20
1.7.0.4

---
=46rom 478f478bc1a58f97f09fd2048488bafdfa9d8fce Mon Sep 17 00:00:00 200=
1
=46rom: Benoit Cousson <b-cousson@ti.com>
Date: Fri, 25 Feb 2011 17:46:33 +0100
Subject: [PATCH 2/2] OMAP3: hwmod data: Remove masters port links for i=
nterconnects.

Master ports from interconnect are generating some annoying circular
references that become tricky to handle if we have to dynamically
remove some IP on some variant platforms.
Since they are not used for the moment, and since we can still build
that relation using the reverse relation (slave port from the IP
toward master port of the interconnect), let remove them for the
moment like it is done on OMAP4.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   28 --------------------=
--------
 1 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_3xxx_data.c
index dec329f..229eb94 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -493,24 +493,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_core=
_slaves[] =3D {
 	&omap3xxx_l3_main__l4_core,
 };
=20
-/* Master interfaces on the L4_CORE interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l4_core_masters[] =3D {
-	&omap3xxx_l4_core__l4_wkup,
-	&omap3_l4_core__uart1,
-	&omap3_l4_core__uart2,
-	&omap3_l4_core__i2c1,
-	&omap3_l4_core__i2c2,
-	&omap3_l4_core__i2c3,
-	&omap3_l4_core__sr1,
-	&omap3_l4_core__sr2,
-};
-
 /* L4 CORE */
 static struct omap_hwmod omap3xxx_l4_core_hwmod =3D {
 	.name		=3D "l4_core",
 	.class		=3D &l4_hwmod_class,
-	.masters	=3D omap3xxx_l4_core_masters,
-	.masters_cnt	=3D ARRAY_SIZE(omap3xxx_l4_core_masters),
 	.slaves		=3D omap3xxx_l4_core_slaves,
 	.slaves_cnt	=3D ARRAY_SIZE(omap3xxx_l4_core_slaves),
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -522,18 +508,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_per_=
slaves[] =3D {
 	&omap3xxx_l3_main__l4_per,
 };
=20
-/* Master interfaces on the L4_PER interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l4_per_masters[] =3D {
-	&omap3_l4_per__uart3,
-	&omap3_l4_per__uart4,
-};
-
 /* L4 PER */
 static struct omap_hwmod omap3xxx_l4_per_hwmod =3D {
 	.name		=3D "l4_per",
 	.class		=3D &l4_hwmod_class,
-	.masters	=3D omap3xxx_l4_per_masters,
-	.masters_cnt	=3D ARRAY_SIZE(omap3xxx_l4_per_masters),
 	.slaves		=3D omap3xxx_l4_per_slaves,
 	.slaves_cnt	=3D ARRAY_SIZE(omap3xxx_l4_per_slaves),
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -545,16 +523,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup=
_slaves[] =3D {
 	&omap3xxx_l4_core__l4_wkup,
 };
=20
-/* Master interfaces on the L4_WKUP interconnect */
-static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_masters[] =3D {
-};
-
 /* L4 WKUP */
 static struct omap_hwmod omap3xxx_l4_wkup_hwmod =3D {
 	.name		=3D "l4_wkup",
 	.class		=3D &l4_hwmod_class,
-	.masters	=3D omap3xxx_l4_wkup_masters,
-	.masters_cnt	=3D ARRAY_SIZE(omap3xxx_l4_wkup_masters),
 	.slaves		=3D omap3xxx_l4_wkup_slaves,
 	.slaves_cnt	=3D ARRAY_SIZE(omap3xxx_l4_wkup_slaves),
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
--=20
1.7.0.4


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
