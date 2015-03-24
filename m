From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] ARM: DRA7: hwmod: Fix the hwmod class for GPTimer4
Date: Tue, 24 Mar 2015 18:06:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503241805060.16497@utopia.booyaka.com>
References: <1426539294-28375-1-git-send-email-s-anna@ti.com> <1426539294-28375-3-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1926266864-1427220375=:16497"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58971 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbbCXSGQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2015 14:06:16 -0400
In-Reply-To: <1426539294-28375-3-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1926266864-1427220375=:16497
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 16 Mar 2015, Suman Anna wrote:

> GPTimer 4 is a regular timer and not a secure timer, so fix
> the hwmod to use the correct hwmod class (even though there
> are no differences in the class definition itself).
>=20
> Signed-off-by: Suman Anna <s-anna@ti.com>

This one results in compiler warnings:

arch/arm/mach-omap2/omap_hwmod_7xx_data.c:1776:32: warning:=20
=A1dra7xx_timer_secure_hwmod_class=A2 defined but not used [-Wunused-variab=
le]
 static struct omap_hwmod_class dra7xx_timer_secure_hwmod_class =3D {

Have queued the following for v4.1.


- Paul

From: Suman Anna <s-anna@ti.com>
Date: Mon, 16 Mar 2015 15:54:54 -0500
Subject: [PATCH] ARM: DRA7: hwmod: Fix the hwmod class for GPTimer4

GPTimer 4 is a regular timer and not a secure timer, so fix
the hwmod to use the correct hwmod class (even though there
are no differences in the class definition itself).

Signed-off-by: Suman Anna <s-anna@ti.com>
[paul@pwsan.com: dropped dra7xx_timer_secure_hwmod_class and
 dra7xx_timer_secure_sysc to avoid compiler warnings]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap=
2/omap_hwmod_7xx_data.c
index d0f03e73add4..701234d8db1b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1763,21 +1763,6 @@ static struct omap_hwmod_class dra7xx_timer_1ms_hwmo=
d_class =3D {
 =09.sysc=09=3D &dra7xx_timer_1ms_sysc,
 };
=20
-static struct omap_hwmod_class_sysconfig dra7xx_timer_secure_sysc =3D {
-=09.rev_offs=09=3D 0x0000,
-=09.sysc_offs=09=3D 0x0010,
-=09.sysc_flags=09=3D (SYSC_HAS_EMUFREE | SYSC_HAS_RESET_STATUS |
-=09=09=09   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
-=09.idlemodes=09=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-=09=09=09   SIDLE_SMART_WKUP),
-=09.sysc_fields=09=3D &omap_hwmod_sysc_type2,
-};
-
-static struct omap_hwmod_class dra7xx_timer_secure_hwmod_class =3D {
-=09.name=09=3D "timer",
-=09.sysc=09=3D &dra7xx_timer_secure_sysc,
-};
-
 static struct omap_hwmod_class_sysconfig dra7xx_timer_sysc =3D {
 =09.rev_offs=09=3D 0x0000,
 =09.sysc_offs=09=3D 0x0010,
@@ -1841,7 +1826,7 @@ static struct omap_hwmod dra7xx_timer3_hwmod =3D {
 /* timer4 */
 static struct omap_hwmod dra7xx_timer4_hwmod =3D {
 =09.name=09=09=3D "timer4",
-=09.class=09=09=3D &dra7xx_timer_secure_hwmod_class,
+=09.class=09=09=3D &dra7xx_timer_hwmod_class,
 =09.clkdm_name=09=3D "l4per_clkdm",
 =09.main_clk=09=3D "timer4_gfclk_mux",
 =09.prcm =3D {
--=20
2.1.4

--843723315-1926266864-1427220375=:16497--
