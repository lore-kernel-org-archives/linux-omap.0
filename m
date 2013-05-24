From: Jean-Philippe Francois <jp.francois@cynove.com>
Subject: [PATCH 1/1] ARM : omap3 : fix wrong container_of in clock36xx.c
Date: Fri, 24 May 2013 09:33:05 +0200
Message-ID: <1369380785-23374-1-git-send-email-jp.francois@cynove.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:44349 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756887Ab3EXHd2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 May 2013 03:33:28 -0400
Received: by mail-wi0-f180.google.com with SMTP id hn14so2526348wib.13
        for <linux-omap@vger.kernel.org>; Fri, 24 May 2013 00:33:27 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, mturquette@linaro.org, =?UTF-8?q?Jean-Philippe=20Fran=C3=A7ois?= <jp.francois@cynove.com>

omap36xx_pwrdn_clk_enable_with_hsdiv_restore expects the parent hw of t=
he clock
to be a clk_hw_omap. However, looking at cclock3xxx_data.c, all concern=
ed clock
have parent defined as clk_divider.
=46ix the function to use clk_divider.=20
Tested with  3.9 on dm3730.

Signed-off-by: Jean-Philippe Fran=C3=A7ois <jp.francois@cynove.com>

Index: b/arch/arm/mach-omap2/clock36xx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/arm/mach-omap2/clock36xx.c
+++ b/arch/arm/mach-omap2/clock36xx.c
@@ -20,11 +20,12 @@
=20
 #include <linux/kernel.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/io.h>
=20
 #include "clock.h"
 #include "clock36xx.h"
-
+#define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
=20
 /**
  * omap36xx_pwrdn_clk_enable_with_hsdiv_restore - enable clocks suffer=
ing
@@ -39,29 +40,28 @@
  */
 int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
 {
-	struct clk_hw_omap *parent;
+	struct clk_divider *parent;
 	struct clk_hw *parent_hw;
-	u32 dummy_v, orig_v, clksel_shift;
+	u32 dummy_v, orig_v;
 	int ret;
=20
 	/* Clear PWRDN bit of HSDIVIDER */
 	ret =3D omap2_dflt_clk_enable(clk);
=20
 	parent_hw =3D __clk_get_hw(__clk_get_parent(clk->clk));
-	parent =3D to_clk_hw_omap(parent_hw);
+	parent =3D to_clk_divider(parent_hw);
=20
 	/* Restore the dividers */
 	if (!ret) {
-		clksel_shift =3D __ffs(parent->clksel_mask);
-		orig_v =3D __raw_readl(parent->clksel_reg);
+		orig_v =3D __raw_readl(parent->reg);
 		dummy_v =3D orig_v;
=20
 		/* Write any other value different from the Read value */
-		dummy_v ^=3D (1 << clksel_shift);
-		__raw_writel(dummy_v, parent->clksel_reg);
+		dummy_v ^=3D (1 << parent->shift);
+		__raw_writel(dummy_v, parent->reg);
=20
 		/* Write the original divider */
-		__raw_writel(orig_v, parent->clksel_reg);
+		__raw_writel(orig_v, parent->reg);
 	}
=20
 	return ret;
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
