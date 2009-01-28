From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH A 08/10] OMAP: Make dpll4_m4_ck programmable with
	clk_set_rate()
Date: Tue, 27 Jan 2009 19:13:12 -0700
Message-ID: <20090128021309.7244.65001.stgit@localhost.localdomain>
References: <20090128020447.7244.80496.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60113 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbZA1UWw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:22:52 -0500
In-Reply-To: <20090128020447.7244.80496.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: =?utf-8?b?TcOlbnM=?= =?utf-8?b?UnVsbGfDpXJk?= <mans@mansr.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

=46illing the set_rate and round_rate fields of dpll4_m4_ck makes
this clock programmable through clk_set_rate().  This is needed
to give omapfb control over the dss1_alwon_fck rate.

This patch includes a fix from Tomi Valkeinen <tomi.valkeinen@nokia.com=
>.

linux-omap source commits are e42218d45afbc3e654e289e021e6b80c657b16c2 =
and
9d211b761b3cdf7736602ecf7e68f8a298c13278.

Signed-off-by: M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock34xx.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/cloc=
k34xx.h
index d19558d..a01d8d9 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -816,6 +816,8 @@ static struct clk dpll4_m4_ck =3D {
 	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.recalc		=3D &omap2_clksel_recalc,
+	.set_rate	=3D &omap2_clksel_set_rate,
+	.round_rate	=3D &omap2_clksel_round_rate,
 };
=20
 /* The PWRDN bit is apparently only available on 3430ES2 and above */


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
