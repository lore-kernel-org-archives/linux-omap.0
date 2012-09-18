From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] ARM: OMAP4+: hwmod code: remove clkdm requirement in
 _omap4_wait_target_*()
Date: Tue, 18 Sep 2012 15:12:51 -0600
Message-ID: <20120918211248.16484.93533.stgit@dusk.lan>
References: <20120918211146.16484.85893.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55038 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab2IRVN1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 17:13:27 -0400
In-Reply-To: <20120918211146.16484.85893.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

We're no longer requiring struct omap_hwmod records to contain a
clockdomain.  So we shouldn't return -EINVAL any more from
_omap4_wait_target_disable() or _omap4_wait_target_ready() if there's
no clockdomain defined, since that just gets passed back to the
caller.  This can result in pointless warnings under the relaxed data
format.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 37afbd1..80cea5b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -878,10 +878,10 @@ static void _omap4_enable_module(struct omap_hwmo=
d *oh)
  */
 static int _omap4_wait_target_disable(struct omap_hwmod *oh)
 {
-	if (!oh || !oh->clkdm)
+	if (!oh)
 		return -EINVAL;
=20
-	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
+	if (oh->_int_flags & _HWMOD_NO_MPU_PORT || !oh->clkdm)
 		return 0;
=20
 	if (oh->flags & HWMOD_NO_IDLEST)
@@ -2531,10 +2531,10 @@ static int _omap2_wait_target_ready(struct omap=
_hwmod *oh)
  */
 static int _omap4_wait_target_ready(struct omap_hwmod *oh)
 {
-	if (!oh || !oh->clkdm)
+	if (!oh)
 		return -EINVAL;
=20
-	if (oh->flags & HWMOD_NO_IDLEST)
+	if (oh->flags & HWMOD_NO_IDLEST || !oh->clkdm)
 		return 0;
=20
 	if (!_find_mpu_rt_port(oh))


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
