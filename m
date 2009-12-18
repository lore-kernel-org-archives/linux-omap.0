From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 7/8] OMAP3 clock: Add capability to change rate of dpll4_m5_ck
Date: Thu, 17 Dec 2009 21:20:22 -0700
Message-ID: <20091218042021.27280.93551.stgit@localhost.localdomain>
References: <20091218041912.27280.92152.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40411 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbZLREVv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 23:21:51 -0500
In-Reply-To: <20091218041912.27280.92152.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tuukka Toivonen <tuukka.o.toivonen@nokia.com>, Jouni =?utf-8?b?SMO2Z2FuZGVy?= <jouni.hogander@nokia.com>

=46rom: Tuukka Toivonen <tuukka.o.toivonen@nokia.com>

Add necessary definitions to clock framework to allow changing
dpll4_m5_ck rate.  This is used by the camera code.

Signed-off-by: Jouni H=C3=B6gander <jouni.hogander@nokia.com>
Signed-off-by: Tuukka Toivonen <tuukka.o.toivonen@nokia.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2=
/clock34xx_data.c
index 7eea9fb..c6031d7 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -776,6 +776,8 @@ static struct clk dpll4_m5_ck =3D {
 	.clksel_mask	=3D OMAP3430_CLKSEL_CAM_MASK,
 	.clksel		=3D div16_dpll4_clksel,
 	.clkdm_name	=3D "dpll4_clkdm",
+	.set_rate	=3D &omap2_clksel_set_rate,
+	.round_rate	=3D &omap2_clksel_round_rate,
 	.recalc		=3D &omap2_clksel_recalc,
 };
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
