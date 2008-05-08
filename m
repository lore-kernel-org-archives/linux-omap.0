From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 9/11] ARM: OMAP: PRCM fixes to ssi clock handling
Date: Thu,  8 May 2008 15:49:33 -0700
Message-ID: <1210286975-29506-10-git-send-email-tony@atomide.com>
References: omap-fixes-2008-05-08-154932
 <1210286975-29506-1-git-send-email-tony@atomide.com>
 <1210286975-29506-2-git-send-email-tony@atomide.com>
 <1210286975-29506-3-git-send-email-tony@atomide.com>
 <1210286975-29506-4-git-send-email-tony@atomide.com>
 <1210286975-29506-5-git-send-email-tony@atomide.com>
 <1210286975-29506-6-git-send-email-tony@atomide.com>
 <1210286975-29506-7-git-send-email-tony@atomide.com>
 <1210286975-29506-8-git-send-email-tony@atomide.com>
 <1210286975-29506-9-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:52121 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762162AbYEHWtw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 18:49:52 -0400
In-Reply-To: <1210286975-29506-9-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, =?utf-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@nokia.com>, Tony Lindgren <tony@atomide.com>

=46rom: Jouni H=C3=B6gander <jouni.hogander@nokia.com>

ssi_l4_ick should have PARENT_CONTROLS_CLOCK flag.
ST_SSI_STDBY bit in idlest register cannot be used in  omap2_clk_wait_r=
eady

Signed-off-by: Jouni H=C3=B6gander <jouni.hogander@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock.c     |    4 +++-
 arch/arm/mach-omap2/clock34xx.h |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index b57ffb5..ab9fc57 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -205,7 +205,9 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	/* REVISIT: What are the appropriate exclusions for 34XX? */
 	/* OMAP3: ignore DSS-mod clocks */
 	if (cpu_is_omap34xx() &&
-	    (((u32)reg & ~0xff) =3D=3D (u32)OMAP_CM_REGADDR(OMAP3430_DSS_MOD,=
 0)))
+	    (((u32)reg & ~0xff) =3D=3D (u32)OMAP_CM_REGADDR(OMAP3430_DSS_MOD,=
 0) ||
+	     ((((u32)reg & ~0xff) =3D=3D (u32)OMAP_CM_REGADDR(CORE_MOD, 0)) &=
&
+	     clk->enable_bit =3D=3D OMAP3430_EN_SSI_SHIFT)))
 		return;
=20
 	/* Check if both functional and interface clocks
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/cloc=
k34xx.h
index 3f133a0..f8bdcc1 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1837,7 +1837,8 @@ static struct clk omapctrl_ick =3D {
 static struct clk ssi_l4_ick =3D {
 	.name		=3D "ssi_l4_ick",
 	.parent		=3D &l4_ick,
-	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		=3D &followparent_recalc,
 };
=20
--=20
1.5.3.6

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
