From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2/3: VENC hwmod: add OCPIF_SWSUP_IDLE flag to
 interface
Date: Thu, 3 Mar 2011 23:02:15 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103032300480.10981@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-559659360-1299218535=:10981"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50978 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab1CDGCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 01:02:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@ti.com, b-cousson@ti.com, svadivu@ti.com, sumit.semwal@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-559659360-1299218535=:10981
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


According to the hwmod interface data, the DSS submodule "VENC" uses a
clock, "dss_54m_fck"/"dss_tv_fck", which the PRCM cannot autoidle.  By
default, the hwmod code assumes that interface clocks can be autoidled
by the PRCM.  When the interface clock can't be autoidled by the PRCM,
those interfaces must be marked with the OCPIF_SWSUP_IDLE flag.
Otherwise, the "interface clock" will always have a non-zero use
count, and the device won't enter idle.  This problem was observed on
N8x0.

Fix the immediate problem by marking the VENC interface with the
OCPIF_SWSUP_IDLE flag.  But it's not clear that
"dss_54m_fck"/"dss_tv_fck" is really the correct interface clock for
VENC.  It may be that the VENC interface should use a
hardware-autoidling interface clock.  This is the situation on OMAP4,
which uses "l3_div_ck" as the VENC interface clock, which can be
autoidled by the PRCM.  Clarification from TI is needed.

Problem found and patch tested on N8x0 by Tony Lindgren
<tony@atomide.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>
Cc: Sumit Semwal <sumit.semwal@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_2420_data.c
index e0bc2c7..61e58bd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1410,6 +1410,7 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__dss=
_venc =3D {
 =09=09=09.flags=09=3D OMAP_FIREWALL_L4,
 =09=09}
 =09},
+=09.flags=09=09=3D OCPIF_SWSUP_IDLE,
 =09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_2430_data.c
index 4aa74d7..490789a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1485,6 +1485,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__dss=
_venc =3D {
 =09.clk=09=09=3D "dss_54m_fck",
 =09.addr=09=09=3D omap2430_dss_venc_addrs,
 =09.addr_cnt=09=3D ARRAY_SIZE(omap2430_dss_venc_addrs),
+=09.flags=09=09=3D OCPIF_SWSUP_IDLE,
 =09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_3xxx_data.c
index e2792cf..eb48b8c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1844,6 +1844,7 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss=
_venc =3D {
 =09=09=09.flags=09=3D OMAP_FIREWALL_L4,
 =09=09}
 =09},
+=09.flags=09=09=3D OCPIF_SWSUP_IDLE,
 =09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
--=20
1.7.2.3

--155748971-559659360-1299218535=:10981--
