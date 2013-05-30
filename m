From: Jean-Philippe Francois <jp.francois@cynove.com>
Subject: [PATCH v2 1/1] ARM : omap3 : fix wrong container_of in clock36xx.c
Date: Thu, 30 May 2013 10:50:27 +0200
Message-ID: <1369903827-2025-1-git-send-email-jp.francois@cynove.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:49839 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967252Ab3E3Iut (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 04:50:49 -0400
Received: by mail-we0-f169.google.com with SMTP id q55so7213504wes.14
        for <linux-omap@vger.kernel.org>; Thu, 30 May 2013 01:50:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, =?UTF-8?q?Jean-Philippe=20Fran=C3=A7ois?= <jp.francois@cynove.com>

omap36xx_pwrdn_clk_enable_with_hsdiv_restore expects the parent hw of t=
he clock
to be a clk_hw_omap. However, looking at cclock3xxx_data.c, all concern=
ed clock
have parent defined as clk_divider. Instead of using container_of to ev=
entually get
to the register and directly mess with the divider, change freq via clk=
_set_rate,=20
and let the clock framework toggle the divider value.
Tested with  3.9 on dm3730.

Signed-off-by: Jean-Philippe Fran=C3=A7ois <jp.francois@cynove.com>

Index: b/arch/arm/mach-omap2/clock36xx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/arm/mach-omap2/clock36xx.c
+++ b/arch/arm/mach-omap2/clock36xx.c
@@ -39,30 +39,25 @@
  */
 int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
 {
-	struct clk_hw_omap *parent;
-	struct clk_hw *parent_hw;
-	u32 dummy_v, orig_v, clksel_shift;
 	int ret;
=20
 	/* Clear PWRDN bit of HSDIVIDER */
 	ret =3D omap2_dflt_clk_enable(clk);
=20
-	parent_hw =3D __clk_get_hw(__clk_get_parent(clk->clk));
-	parent =3D to_clk_hw_omap(parent_hw);
-
-	/* Restore the dividers */
+	/* kick parent's clksel register after toggling PWRDN bit */
 	if (!ret) {
-		clksel_shift =3D __ffs(parent->clksel_mask);
-		orig_v =3D __raw_readl(parent->clksel_reg);
-		dummy_v =3D orig_v;
-
-		/* Write any other value different from the Read value */
-		dummy_v ^=3D (1 << clksel_shift);
-		__raw_writel(dummy_v, parent->clksel_reg);
-
-		/* Write the original divider */
-		__raw_writel(orig_v, parent->clksel_reg);
+		struct clk *parent =3D clk_get_parent(clk->clk);
+		unsigned long parent_rate =3D clk_get_rate(parent);
+		ret =3D clk_set_rate(parent, parent_rate/2);
+		if(ret)
+			goto badfreq;
+		ret =3D clk_set_rate(parent, parent_rate);
+		if(ret)
+			goto badfreq;
 	}
+	return ret;
=20
+ badfreq :
+	omap2_dflt_clk_disable(clk);
 	return ret;
 }
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
