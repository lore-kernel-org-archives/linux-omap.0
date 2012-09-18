From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/3] ARM: OMAP2+: hwmod code: convert missing clockdomain
 warnings to debug messages
Date: Tue, 18 Sep 2012 15:12:54 -0600
Message-ID: <20120918211251.16484.18401.stgit@dusk.lan>
References: <20120918211146.16484.85893.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55042 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362Ab2IRVN2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 17:13:28 -0400
In-Reply-To: <20120918211146.16484.85893.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

The decision was made a few months ago to allow struct omap_hwmod
records and struct clk records to omit clockdomain information if the
clockdomain is not software-controllable.  See for example commit
868c157df9721675c19729eed2c96bac6c3f1d01 ("ARM: OMAP2+: hwmod: remove
prm_clkdm, cm_clkdm; allow hwmods to have no clockdomain").

So convert an existing pr_warning() to a pr_debug() (regarding missing
clockdomains in clocks), and add a pr_debug() for missing hwmod
clockdomains.  It's still useful to enable these messages for
debugging, since missing clockdomains can cause hard-to-debug problems
with power management; see for example commit
6c4a057bffe9823221eab547e11fac181dc18a2b ("ARM: OMAP4: clock data:
=46orce a DPLL clkdm/pwrdm ON before a relock").

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 80cea5b..e05228a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -685,8 +685,8 @@ static int _init_main_clk(struct omap_hwmod *oh)
 	}
=20
 	if (!oh->_clk->clkdm)
-		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
-			   oh->main_clk, oh->_clk->name);
+		pr_debug("omap_hwmod: %s: missing clockdomain for %s.\n",
+			 oh->main_clk, oh->_clk->name);
=20
 	return ret;
 }
@@ -1380,8 +1380,10 @@ static struct omap_hwmod *_lookup(const char *na=
me)
  */
 static int _init_clkdm(struct omap_hwmod *oh)
 {
-	if (!oh->clkdm_name)
+	if (!oh->clkdm_name) {
+		pr_debug("omap_hwmod: %s: missing clockdomain\n", oh->name);
 		return 0;
+	}
=20
 	oh->clkdm =3D clkdm_lookup(oh->clkdm_name);
 	if (!oh->clkdm) {


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
