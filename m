From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 19/22] OMAP3 clock: add support for setting the divider for
	sys_clkout2 using clk_set_rate
Date: Tue, 18 May 2010 20:19:00 -0600
Message-ID: <20100519021859.19716.88093.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39830 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935Ab0ESCVF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 22:21:05 -0400
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Laine Walker-Avina <lwalkera@ieee.org>

From: Laine Walker-Avina <lwalkera@ieee.org>

Add clock framework support for changing the rate of sys_clkout2.

Signed-off-by: Laine Walker-Avina <lwalkera@ieee.org>
[paul@pwsan.com: added commit message, added .round_rate pointer]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 5ab44b0..833be48 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -1033,6 +1033,8 @@ static struct clk sys_clkout2 = {
 	.clksel_mask	= OMAP3430_CLKOUT2_DIV_MASK,
 	.clksel		= sys_clkout2_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* CM OUTPUT CLOCKS */


