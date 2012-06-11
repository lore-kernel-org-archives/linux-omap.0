From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCHv2 06/12] ARM: OMAP2+: hwmod: add flag to prevent hwmod code
 from touching IP block during init
Date: Sun, 10 Jun 2012 18:46:11 -0600
Message-ID: <20120611004608.20034.55965.stgit@dusk>
References: <20120611004502.20034.8840.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42569 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab2FKAwK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jun 2012 20:52:10 -0400
In-Reply-To: <20120611004502.20034.8840.stgit@dusk>
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
index d27bf48..e0b8131 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2140,6 +2140,9 @@ static int __init _setup_reset(struct omap_hwmod =
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
index 2c53648..b5f3efc 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -417,6 +417,11 @@ struct omap_hwmod_omap4_prcm {
  *     running on the chip (e.g., the MPU is in idle).  For such modul=
es,
  *     fine-grained PM runtime-based idle control is simply a waste of
  *     CPU cycles.
+ * HWMOD_EXT_OPT_MAIN_CLK: The only main functional clock source for
+ *     this IP block comes from an off-chip source and is not always
+ *     enabled.  This prevents the hwmod code from being able to
+ *     enable and reset the IP block early.  XXX Eventually it should
+ *     be possible to query the clock framework for this information.
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -428,6 +433,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_CONTROL_OPT_CLKS_IN_RESET		(1 << 7)
 #define HWMOD_16BIT_REG				(1 << 8)
 #define HWMOD_ALWAYS_FORCE_SIDLE		(1 << 9)
+#define HWMOD_EXT_OPT_MAIN_CLK			(1 << 10)
=20
 /*
  * omap_hwmod._int_flags definitions


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
