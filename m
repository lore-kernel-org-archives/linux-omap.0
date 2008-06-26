From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/4] OMAP3 clock: OMAP3430ES2+ has SSI target idlest bit
Date: Thu, 26 Jun 2008 01:09:15 -0600
Message-ID: <20080626070913.16555.90593.stgit@localhost.localdomain>
References: <20080626070305.16555.96759.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42965 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbYFZHLm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 03:11:42 -0400
In-Reply-To: <20080626070305.16555.96759.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: gadiyar@ti.com, k.kooi@student.utwente.nl, dirk.behme@googlemail.com, igor.stoppa@nokia.com, r-woodruff2@ti.com, jouni.hogander@nokia.com

On OMAP3430ES2+, SSI has both an initiator standby CM_IDLEST bit, and a
target idle CM_IDLEST bit.  This is a departure from previous silicon,
which only had an initiator standby bit.

This means that omap2_clk_wait_ready() needs to wait for the SSI
module to indicate readiness after both SSI interface and functional
clocks are enabled.

Thanks to Igor Stoppa <igor.stoppa@nokia.com>, Richard Woodruff
<r-woodruff2@ti.com>, and Jouni H=C3=B6gander <jouni.hogander@nokia.com=
> for
help with this portion of the patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock.c           |   59 ++++++++++++++++++++-----=
--------
 arch/arm/mach-omap2/cm-regbits-34xx.h |    3 +-
 2 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 343477b..59b042f 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -246,28 +246,31 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	}
=20
 	/* REVISIT: What are the appropriate exclusions for 34XX? */
-	if (cpu_is_omap34xx() &&
-	    prcm_mod =3D=3D OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0)) {
+	if (cpu_is_omap34xx()) {
=20
-		/* 3430ES1 DSS has no target idlest bits */
-		if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0))
+		/* SSI */
+		if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0) &&
+		    prcm_mod =3D=3D OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
+		    (reg & 0x0f) =3D=3D 0 &&
+		    clk->enable_bit =3D=3D OMAP3430_EN_SSI_SHIFT)
 			return;
=20
-		/*
-		 * For 3430ES2+ DSS, only wait once (dss1_alwon_fclk,
-		 * dss_l3_iclk, dss_l4_iclk) are enabled
-		 */
-		if (clk->enable_bit !=3D OMAP3430_EN_DSS1_SHIFT)
-			return;
+		/* DSS */
+		if (prcm_mod =3D=3D OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0)) {
=20
-	}
+			/* 3430ES1 DSS has no target idlest bits */
+			if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0))
+				return;
=20
-	/* REVISIT: SSI has a target idlest bit on OMAP3 */
-	/* REVISIT: This could accidentally exclude other clocks also */
-	if (cpu_is_omap34xx() &&
-	    prcm_mod =3D=3D OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
-	    clk->enable_bit =3D=3D OMAP3430_EN_SSI_SHIFT)
-		return;
+			/*
+			 * For 3430ES2+ DSS, only wait once (dss1_alwon_fclk,
+			 * dss_l3_iclk, dss_l4_iclk) are enabled
+			 */
+			if (clk->enable_bit !=3D OMAP3430_EN_DSS1_SHIFT)
+				return;
+		}
+
+	}
=20
 	/* Check if both functional and interface clocks
 	 * are running. */
@@ -276,13 +279,23 @@ static void omap2_clk_wait_ready(struct clk *clk)
 		return;
=20
 	/*
-	 * OMAP3430ES2 DSS target idlest bit is at a different shift than
-	 * the corresponding {I,F}CLKEN bits
+	 * OMAP3430ES2+ has target idlest bits at unusual offsets for
+	 * modules with both initiator and target agents
 	 */
-	if (cpu_is_omap34xx() &&
-	    prcm_mod =3D=3D OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) &&
-	    clk->enable_bit =3D=3D OMAP3430_EN_DSS1_SHIFT)
-		bit =3D OMAP3430ES2_ST_DSS_IDLE;
+	if (cpu_is_omap34xx()) {
+
+		/* SSI */
+		if (prcm_mod =3D=3D OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
+		    (reg & 0x0f) =3D=3D 0 &&
+		    clk->enable_bit =3D=3D OMAP3430_EN_SSI_SHIFT)
+			bit =3D OMAP3430ES2_ST_SSI_IDLE;
+
+		/* DSS */
+		if (prcm_mod =3D=3D OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) &&
+		    clk->enable_bit =3D=3D OMAP3430_EN_DSS1_SHIFT)
+			bit =3D OMAP3430ES2_ST_DSS_IDLE;
+
+	}
=20
 	st_reg =3D ((other_reg & ~0xf0) | 0x20); /* CM_IDLEST* */
=20
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap=
2/cm-regbits-34xx.h
index 946c552..971b9ad 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -190,11 +190,12 @@
 #define OMAP3430_ST_MSPRO				(1 << 23)
 #define OMAP3430_ST_HDQ					(1 << 22)
 #define OMAP3430ES1_ST_FAC				(1 << 8)
+#define OMAP3430ES2_ST_SSI_IDLE				(1 << 8)
 #define OMAP3430ES1_ST_MAILBOXES			(1 << 7)
 #define OMAP3430_ST_OMAPCTRL				(1 << 6)
 #define OMAP3430_ST_SDMA				(1 << 2)
 #define OMAP3430_ST_SDRC				(1 << 1)
-#define OMAP3430_ST_SSI					(1 << 0)
+#define OMAP3430_ST_SSI_STDBY				(1 << 0)
=20
 /* CM_IDLEST2_CORE */
 #define OMAP3430_ST_PKA					(1 << 4)


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
