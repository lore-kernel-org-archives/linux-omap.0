From: Artem Bityutskiy <dedekind@infradead.org>
Subject: [PATCH] OMAP3: lessen amount of noisy messages
Date: Thu, 09 Apr 2009 17:41:12 +0300
Message-ID: <1239288072.3390.8.camel@localhost.localdomain>
Reply-To: dedekind@infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17838 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbZDIOlV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Apr 2009 10:41:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgen <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

=46rom: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Date: Thu, 9 Apr 2009 17:15:47 +0300
Subject: [PATCH] OMAP3: lessen amount of noisy messages

On our system we see the following messages:

Disabling unused clock "gpt2_ick"
Disabling unused clock "gpt3_ick"
Disabling unused clock "gpt4_ick"
Disabling unused clock "gpt5_ick"
Disabling unused clock "gpt6_ick"
Disabling unused clock "gpt7_ick"
Disabling unused clock "gpt8_ick"
Disabling unused clock "gpt9_ick"
Disabling unused clock "gpio2_dbck"
Disabling unused clock "gpio3_dbck"
Disabling unused clock "gpio4_dbck"
Disabling unused clock "gpio5_dbck"
Disabling unused clock "gpio6_dbck"
Disabling unused clock "gpt9_fck"
Disabling unused clock "gpt8_fck"
Disabling unused clock "gpt7_fck"
Disabling unused clock "gpt6_fck"
Disabling unused clock "gpt5_fck"
Disabling unused clock "gpt4_fck"
Disabling unused clock "gpt3_fck"
Disabling unused clock "gpt2_fck"
Disabling unused clock "wdt2_ick"
Disabling unused clock "wdt2_fck"
Disabling unused clock "gpio1_dbck"
Disabling unused clock "rng_ick"
Disabling unused clock "ssi_ick"
Disabling unused clock "gpt10_ick"
Disabling unused clock "gpt11_ick"
Disabling unused clock "uart1_ick"
Disabling unused clock "uart2_ick"
Disabling unused clock "usbtll_ick"
Disabling unused clock "ssi_ssr_fck"
Disabling unused clock "uart1_fck"
Disabling unused clock "uart2_fck"
Disabling unused clock "usbtll_fck"
Disabling unused clock "ts_fck"
Disabling unused clock "cpefuse_fck"
Disabling unused clock "gpt11_fck"
Disabling unused clock "gpt10_fck"
Disabling unused clock "dpll5_ck"
Disabling unused clock "dpll4_m6x2_ck"
Disabling unused clock "dpll4_m5x2_ck"
Disabling unused clock "dpll3_m3x2_ck"
Disabling unused clock "sys_clkout1"

The messages have KERN_INFO level and if you have serial
console, they normally go there. I do not think it is good
idea to print that much stuff there. Moreover, messages
are not properly prefixed and for mortals it is not
immeadietly clear where they come from.

Let's give them debugging level instead.

Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
---
 arch/arm/mach-omap2/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 4247a15..2f254bf 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -1035,7 +1035,7 @@ void omap2_clk_disable_unused(struct clk *clk)
 	if ((regval32 & (1 << clk->enable_bit)) =3D=3D v)
 		return;
=20
-	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
+	pr_debug("Disabling unused clock \"%s\"\n", clk->name);
 	if (cpu_is_omap34xx()) {
 		omap2_clk_enable(clk);
 		omap2_clk_disable(clk);
--=20
1.6.0.6

--=20
Best regards,
Artem Bityutskiy (=D0=91=D0=B8=D1=82=D1=8E=D1=86=D0=BA=D0=B8=D0=B9 =D0=90=
=D1=80=D1=82=D1=91=D0=BC)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
