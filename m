From: Artem Bityutskiy <dedekind@infradead.org>
Subject: Re: [PATCH] OMAP3: lessen amount of noisy messages
Date: Wed, 15 Apr 2009 18:42:41 +0300
Message-ID: <1239810161.3390.190.camel@localhost.localdomain>
References: <1239288072.3390.8.camel@localhost.localdomain>
	 <49E5D188.8060508@yandex.ru>
	 <alpine.DEB.2.00.0904150917520.3313@utopia.booyaka.com>
Reply-To: dedekind@infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34352 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbZDOPm6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2009 11:42:58 -0400
In-Reply-To: <alpine.DEB.2.00.0904150917520.3313@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Artem Bityutskiy <dedekind@yandex.ru>, Tony Lindgen <tony@atomide.com>, linux-omap@vger.kernel.org

Hi,

On Wed, 2009-04-15 at 09:22 -0600, Paul Walmsley wrote:
> stil thinking about it.  These messages have made it easy to catch bu=
gs=20
> with the PM code in the past (e.g., sad2d).  Making them debug-level =
will=20
> require booting a kernel with clock debugging specifically=20
> compiled in.  So I wonder if there might be a better way to deal with=
=20
> these...

Yeah, I see your concern. I'm your user, and from my perspective this i=
s
an excessive output to slow serial line.

If you do not want re-compilation, I may send a different patch
like this:

-	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
+	printk(KERN_DEBUG "Disabling unused clock \"%s\"\n", clk->name);

in which case you would not loose the messages, but the messages
would not go to the serial line.

And then you would be able to get them from:

a) dmesg
b) syslog
c) console, just like currently, if you add "ignore_loglevel" kernel
   boot option (Documentation/kernel-parameters.txt)

Would this be better? Here is the patch, just in case.
--

=46rom: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
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
index 4247a15..c4169ee 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -1035,7 +1035,7 @@ void omap2_clk_disable_unused(struct clk *clk)
 	if ((regval32 & (1 << clk->enable_bit)) =3D=3D v)
 		return;
=20
-	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
+	printk(KERN_DEBUG "Disabling unused clock \"%s\"\n", clk->name);
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
