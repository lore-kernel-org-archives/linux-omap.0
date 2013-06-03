From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/1] ARM : omap3 : fix wrong container_of in
 clock36xx.c
Date: Mon, 3 Jun 2013 09:36:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306030932520.4435@utopia.booyaka.com>
References: <1369903827-2025-1-git-send-email-jp.francois@cynove.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1325465883-1370252216=:4435"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40572 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab3FCJg6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jun 2013 05:36:58 -0400
In-Reply-To: <1369903827-2025-1-git-send-email-jp.francois@cynove.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Philippe Francois <jp.francois@cynove.com>
Cc: tony@atomide.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1325465883-1370252216=:4435
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 30 May 2013, Jean-Philippe Francois wrote:

> omap36xx_pwrdn_clk_enable_with_hsdiv_restore expects the parent hw of the=
 clock
> to be a clk_hw_omap. However, looking at cclock3xxx_data.c, all concerned=
 clock
> have parent defined as clk_divider. Instead of using container_of to even=
tually get
> to the register and directly mess with the divider, change freq via clk_s=
et_rate,=20
> and let the clock framework toggle the divider value.
> Tested with  3.9 on dm3730.
>=20
> Signed-off-by: Jean-Philippe Fran??ois <jp.francois@cynove.com>

Queued for 3.10-rc fixes with Mike's ack, after fixing the checkpatch.pl=20
errors listed below.  Please don't forget to run scripts/checkpatch.pl on=
=20
future patches -- Documentation/SubmittingPatches has more info about=20
this.


ERROR: space required before the open parenthesis '('
#59: FILE: arch/arm/mach-omap2/clock36xx.c:52:
+=09=09if(ret)

ERROR: space required before the open parenthesis '('
#62: FILE: arch/arm/mach-omap2/clock36xx.c:55:
+=09=09if(ret)

WARNING: please, no spaces at the start of a line
#67: FILE: arch/arm/mach-omap2/clock36xx.c:60:
+ badfreq :$

ERROR: space prohibited before that ':' (ctx:WxE)
#67: FILE: arch/arm/mach-omap2/clock36xx.c:60:
+ badfreq :
          ^

Updated patch follows.


- Paul

From: Jean-Philippe Francois <jp.francois@cynove.com>
Date: Thu, 30 May 2013 10:50:27 +0200
Subject: [PATCH] ARM: omap3: clock: fix wrong container_of in clock36xx.c
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

omap36xx_pwrdn_clk_enable_with_hsdiv_restore expects the parent hw of
the clock to be a clk_hw_omap. However, looking at cclock3xxx_data.c,
all concerned clock have parent defined as clk_divider. Instead of
using container_of to eventually get to the register and directly mess
with the divider, change freq via clk_set_rate, and let the clock
framework toggle the divider value.
Tested with 3.9 on dm3730.

Signed-off-by: Jean-Philippe Fran=E7ois <jp.francois@cynove.com>
Acked-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock36xx.c |   29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/clock36xx.c b/arch/arm/mach-omap2/clock36x=
x.c
index 8f3bf4e..7f69fbb 100644
--- a/arch/arm/mach-omap2/clock36xx.c
+++ b/arch/arm/mach-omap2/clock36xx.c
@@ -39,30 +39,25 @@
  */
 int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
 {
-=09struct clk_hw_omap *parent;
-=09struct clk_hw *parent_hw;
-=09u32 dummy_v, orig_v, clksel_shift;
 =09int ret;
=20
 =09/* Clear PWRDN bit of HSDIVIDER */
 =09ret =3D omap2_dflt_clk_enable(clk);
=20
-=09parent_hw =3D __clk_get_hw(__clk_get_parent(clk->clk));
-=09parent =3D to_clk_hw_omap(parent_hw);
-
-=09/* Restore the dividers */
+=09/* kick parent's clksel register after toggling PWRDN bit */
 =09if (!ret) {
-=09=09clksel_shift =3D __ffs(parent->clksel_mask);
-=09=09orig_v =3D __raw_readl(parent->clksel_reg);
-=09=09dummy_v =3D orig_v;
-
-=09=09/* Write any other value different from the Read value */
-=09=09dummy_v ^=3D (1 << clksel_shift);
-=09=09__raw_writel(dummy_v, parent->clksel_reg);
-
-=09=09/* Write the original divider */
-=09=09__raw_writel(orig_v, parent->clksel_reg);
+=09=09struct clk *parent =3D clk_get_parent(clk->clk);
+=09=09unsigned long parent_rate =3D clk_get_rate(parent);
+=09=09ret =3D clk_set_rate(parent, parent_rate/2);
+=09=09if (ret)
+=09=09=09goto badfreq;
+=09=09ret =3D clk_set_rate(parent, parent_rate);
+=09=09if (ret)
+=09=09=09goto badfreq;
 =09}
+=09return ret;
=20
+badfreq:
+=09omap2_dflt_clk_disable(clk);
 =09return ret;
 }
--=20
1.7.10.4

--843723315-1325465883-1370252216=:4435--
