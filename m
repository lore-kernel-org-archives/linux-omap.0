From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3: hwmod: remove incorrect SmartReflex -> L4 CORE
 interconnect links
Date: Wed, 9 Mar 2011 19:32:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103091931420.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2045462948-1299724351=:15132"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32785 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab1CJCcc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 21:32:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Sanjeev Premi <premi@ti.com>, Thara Gopinath <thara@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2045462948-1299724351=:15132
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


Commit d34427267186827dfd62bd8cf726601fffb22534 ("OMAP3: PM: Adding
smartreflex hwmod data") added data that claims that the L4 CORE has
two slave interfaces that originate from the SmartReflex modules,
omap3_l4_core__sr1 and omap3_l4_core__sr2.  But as those two data
structure records show, it's L4 CORE that has a master port towards
SR1 and SR2.  Remove the incorrect data.

Based on a patch by Beno=EEt Cousson <b-cousson@ti.com>:

    https://patchwork.kernel.org/patch/590561/

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_3xxx_data.c
index 8d81813..18b0dd4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -304,8 +304,6 @@ static struct omap_hwmod_ocp_if omap3_l4_core__sr2 =3D =
{
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] =3D {
 =09&omap3xxx_l3_main__l4_core,
-=09&omap3_l4_core__sr1,
-=09&omap3_l4_core__sr2,
 };
=20
 /* Master interfaces on the L4_CORE interconnect */
--=20
1.7.2.3

--155748971-2045462948-1299724351=:15132--
