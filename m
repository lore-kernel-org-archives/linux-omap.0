From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle for GPT1
Date: Wed, 9 Mar 2011 18:48:24 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103091847150.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-107851298-1299721704=:15132"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54450 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab1CJBsZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 20:48:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-107851298-1299721704=:15132
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


From: Rajendra Nayak <rnayak@ti.com>

Some issues seen (which cause lockups in suspend) with GPT1
after the MPU<->L4_WKUP static dependency was cleared can be
Worked-around for now by forcing GPT1 in software
controlled idle.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Beno=EEt Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index 7b72316..cfe957a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4005,6 +4005,7 @@ static struct omap_hwmod_ocp_if *omap44xx_timer1_slav=
es[] =3D {
 static struct omap_hwmod omap44xx_timer1_hwmod =3D {
 =09.name=09=09=3D "timer1",
 =09.class=09=09=3D &omap44xx_timer_1ms_hwmod_class,
+=09.flags=09=09=3D HWMOD_SWSUP_SIDLE,
 =09.mpu_irqs=09=3D omap44xx_timer1_irqs,
 =09.mpu_irqs_cnt=09=3D ARRAY_SIZE(omap44xx_timer1_irqs),
 =09.main_clk=09=3D "timer1_fck",
--=20
1.7.2.3

--155748971-107851298-1299721704=:15132--
