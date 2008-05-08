From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/11] ARM: OMAP: Fix 34xx to use correct shift values for gpio2-6 fclks
Date: Thu,  8 May 2008 15:49:31 -0700
Message-ID: <1210286975-29506-8-git-send-email-tony@atomide.com>
References: omap-fixes-2008-05-08-154932
 <1210286975-29506-1-git-send-email-tony@atomide.com>
 <1210286975-29506-2-git-send-email-tony@atomide.com>
 <1210286975-29506-3-git-send-email-tony@atomide.com>
 <1210286975-29506-4-git-send-email-tony@atomide.com>
 <1210286975-29506-5-git-send-email-tony@atomide.com>
 <1210286975-29506-6-git-send-email-tony@atomide.com>
 <1210286975-29506-7-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61507 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762054AbYEHWtt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 18:49:49 -0400
In-Reply-To: <1210286975-29506-7-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, =?utf-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@nokia.com>, Tony Lindgren <tony@atomide.com>

=46rom: Jouni H=C3=B6gander <jouni.hogander@nokia.com>

Wrong shift values were used for gpio2-6  fclks (gpt2-6 shift).

Signed-off-by: Jouni H=C3=B6gander <jouni.hogander@nokia.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock34xx.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/cloc=
k34xx.h
index cf4644a..a728117 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2344,7 +2344,7 @@ static struct clk gpio6_fck =3D {
 	.name		=3D "gpio6_fck",
 	.parent		=3D &per_32k_alwon_fck,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	=3D OMAP3430_EN_GPT6_SHIFT,
+	.enable_bit	=3D OMAP3430_EN_GPIO6_SHIFT,
 	.flags		=3D CLOCK_IN_OMAP343X,
 	.recalc		=3D &followparent_recalc,
 };
@@ -2353,7 +2353,7 @@ static struct clk gpio5_fck =3D {
 	.name		=3D "gpio5_fck",
 	.parent		=3D &per_32k_alwon_fck,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	=3D OMAP3430_EN_GPT5_SHIFT,
+	.enable_bit	=3D OMAP3430_EN_GPIO5_SHIFT,
 	.flags		=3D CLOCK_IN_OMAP343X,
 	.recalc		=3D &followparent_recalc,
 };
@@ -2362,7 +2362,7 @@ static struct clk gpio4_fck =3D {
 	.name		=3D "gpio4_fck",
 	.parent		=3D &per_32k_alwon_fck,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	=3D OMAP3430_EN_GPT4_SHIFT,
+	.enable_bit	=3D OMAP3430_EN_GPIO4_SHIFT,
 	.flags		=3D CLOCK_IN_OMAP343X,
 	.recalc		=3D &followparent_recalc,
 };
@@ -2371,7 +2371,7 @@ static struct clk gpio3_fck =3D {
 	.name		=3D "gpio3_fck",
 	.parent		=3D &per_32k_alwon_fck,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	=3D OMAP3430_EN_GPT3_SHIFT,
+	.enable_bit	=3D OMAP3430_EN_GPIO3_SHIFT,
 	.flags		=3D CLOCK_IN_OMAP343X,
 	.recalc		=3D &followparent_recalc,
 };
@@ -2380,7 +2380,7 @@ static struct clk gpio2_fck =3D {
 	.name		=3D "gpio2_fck",
 	.parent		=3D &per_32k_alwon_fck,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
-	.enable_bit	=3D OMAP3430_EN_GPT2_SHIFT,
+	.enable_bit	=3D OMAP3430_EN_GPIO2_SHIFT,
 	.flags		=3D CLOCK_IN_OMAP343X,
 	.recalc		=3D &followparent_recalc,
 };
--=20
1.5.3.6

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
