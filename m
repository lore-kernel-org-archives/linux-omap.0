From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/4] ARM: OMAP2+: hwmod: add flag to prevent hwmod code from
 touching IP block during init
Date: Wed, 31 Oct 2012 04:43:14 -0600
Message-ID: <20121031104313.6557.6835.stgit@dusk.lan>
References: <20121031103607.6557.64591.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51171 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756730Ab2JaKqj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 06:46:39 -0400
In-Reply-To: <20121031103607.6557.64591.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Add HWMOD_EXT_OPT_MAIN_CLK flag to indicate that this IP block is
dependent on an off-chip functional clock that is not guaranteed to be
present during initialization.  IP blocks marked with this flag are
left in the INITIALIZED state during kernel init.

This is a workaround for a hardware problem.  It should be possible to
guarantee that at least one clock source will be present and active
for any IP block's main functional clock.  This ensures that the hwmod
code can enable and reset the IP block.  Resetting the IP block during
kernel init prevents any bogus bootloader, ROM code, or previous OS
configuration from affecting the kernel.  Hopefully a clock
multiplexer can be added on future SoCs.

N.B., at some point in the future, it should be possible to query the
clock framework for this type of information.  Then this flag should
no longer be needed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |    3 +++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index f9d8b2a..4529650 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2380,6 +2380,9 @@ static int __init _setup_reset(struct omap_hwmod =
*oh)
 	if (oh->_state !=3D _HWMOD_STATE_INITIALIZED)
 		return -EINVAL;
=20
+	if (oh->flags & HWMOD_EXT_OPT_MAIN_CLK)
+		return -EPERM;
+
 	if (oh->rst_lines_cnt =3D=3D 0) {
 		r =3D _enable(oh);
 		if (r) {
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index b3349f7..1db0294 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -443,6 +443,11 @@ struct omap_hwmod_omap4_prcm {
  *     in order to complete the reset. Optional clocks will be disable=
d
  *     again after the reset.
  * HWMOD_16BIT_REG: Module has 16bit registers
+ * HWMOD_EXT_OPT_MAIN_CLK: The only main functional clock source for
+ *     this IP block comes from an off-chip source and is not always
+ *     enabled.  This prevents the hwmod code from being able to
+ *     enable and reset the IP block early.  XXX Eventually it should
+ *     be possible to query the clock framework for this information.
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -453,6 +458,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_NO_IDLEST				(1 << 6)
 #define HWMOD_CONTROL_OPT_CLKS_IN_RESET		(1 << 7)
 #define HWMOD_16BIT_REG				(1 << 8)
+#define HWMOD_EXT_OPT_MAIN_CLK			(1 << 9)
=20
 /*
  * omap_hwmod._int_flags definitions


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
