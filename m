From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 3/5] OMAP4: powerdomain data: Fix core mem states and
 missing cefuse flag
Date: Tue, 5 Jul 2011 23:59:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107052358450.4217@utopia.booyaka.com>
References: <1309552060-4547-1-git-send-email-b-cousson@ti.com> <1309552060-4547-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-330979496-1309931983=:4217"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39467 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab1GFF7o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 01:59:44 -0400
In-Reply-To: <1309552060-4547-4-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-330979496-1309931983=:4217
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi

I split the indentation changes into the following patch, queued for 3.1=20
at git://git.pwsan.com/linux-2.6 in the 'prcm_cleanup_a_3.1' branch.


- Paul

From: Benoit Cousson <b-cousson@ti.com>
Date: Tue, 5 Jul 2011 23:44:32 -0600
Subject: [PATCH] OMAP4: powerdomain data: Fix indentation
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Indent flags to be aligned with other fields.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
[paul@pwsan.com: split this patch from an earlier patch by Beno=EEt;
 edited commit message]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomains44xx_data.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-om=
ap2/powerdomains44xx_data.c
index c4222c7..3a7e678 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -53,7 +53,7 @@ static struct powerdomain core_44xx_pwrdm =3D {
 =09=09[3] =3D PWRSTS_ON,=09/* ducati_l2ram */
 =09=09[4] =3D PWRSTS_ON,=09/* ducati_unicache */
 =09},
-=09.flags=09=09=3D PWRDM_HAS_LOWPOWERSTATECHANGE,
+=09.flags=09=09  =3D PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
=20
 /* gfx_44xx_pwrdm: 3D accelerator power domain */
@@ -70,7 +70,7 @@ static struct powerdomain gfx_44xx_pwrdm =3D {
 =09.pwrsts_mem_on=09=3D {
 =09=09[0] =3D PWRSTS_ON,=09/* gfx_mem */
 =09},
-=09.flags=09=09=3D PWRDM_HAS_LOWPOWERSTATECHANGE,
+=09.flags=09=09  =3D PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
=20
 /* abe_44xx_pwrdm: Audio back end power domain */
@@ -90,7 +90,7 @@ static struct powerdomain abe_44xx_pwrdm =3D {
 =09=09[0] =3D PWRSTS_ON,=09/* aessmem */
 =09=09[1] =3D PWRSTS_ON,=09/* periphmem */
 =09},
-=09.flags=09=09=3D PWRDM_HAS_LOWPOWERSTATECHANGE,
+=09.flags=09=09  =3D PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
=20
 /* dss_44xx_pwrdm: Display subsystem power domain */
@@ -108,7 +108,7 @@ static struct powerdomain dss_44xx_pwrdm =3D {
 =09.pwrsts_mem_on=09=3D {
 =09=09[0] =3D PWRSTS_ON,=09/* dss_mem */
 =09},
-=09.flags=09=09=3D PWRDM_HAS_LOWPOWERSTATECHANGE,
+=09.flags=09=09  =3D PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
=20
 /* tesla_44xx_pwrdm: Tesla processor power domain */
@@ -130,7 +130,7 @@ static struct powerdomain tesla_44xx_pwrdm =3D {
 =09=09[1] =3D PWRSTS_ON,=09/* tesla_l1 */
 =09=09[2] =3D PWRSTS_ON,=09/* tesla_l2 */
 =09},
-=09.flags=09=09=3D PWRDM_HAS_LOWPOWERSTATECHANGE,
+=09.flags=09=09  =3D PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
=20
 /* wkup_44xx_pwrdm: Wake-up power domain */
@@ -241,7 +241,7 @@ static struct powerdomain ivahd_44xx_pwrdm =3D {
 =09=09[2] =3D PWRSTS_ON,=09/* tcm1_mem */
 =09=09[3] =3D PWRSTS_ON,=09/* tcm2_mem */
 =09},
-=09.flags=09=09=3D PWRDM_HAS_LOWPOWERSTATECHANGE,
+=09.flags=09=09  =3D PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
=20
 /* cam_44xx_pwrdm: Camera subsystem power domain */
@@ -258,7 +258,7 @@ static struct powerdomain cam_44xx_pwrdm =3D {
 =09.pwrsts_mem_on=09=3D {
 =09=09[0] =3D PWRSTS_ON,=09/* cam_mem */
 =09},
-=09.flags=09=09=3D PWRDM_HAS_LOWPOWERSTATECHANGE,
+=09.flags=09=09  =3D PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
=20
 /* l3init_44xx_pwrdm: L3 initators pheripherals power domain  */
@@ -276,7 +276,7 @@ static struct powerdomain l3init_44xx_pwrdm =3D {
 =09.pwrsts_mem_on=09=3D {
 =09=09[0] =3D PWRSTS_ON,=09/* l3init_bank1 */
 =09},
-=09.flags=09=09=3D PWRDM_HAS_LOWPOWERSTATECHANGE,
+=09.flags=09=09  =3D PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
=20
 /* l4per_44xx_pwrdm: Target peripherals power domain */
@@ -296,7 +296,7 @@ static struct powerdomain l4per_44xx_pwrdm =3D {
 =09=09[0] =3D PWRSTS_ON,=09/* nonretained_bank */
 =09=09[1] =3D PWRSTS_ON,=09/* retained_bank */
 =09},
-=09.flags=09=09=3D PWRDM_HAS_LOWPOWERSTATECHANGE,
+=09.flags=09=09  =3D PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
=20
 /*
--=20
1.7.5.4

--155748971-330979496-1309931983=:4217--
