From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: omap1: clock: return 0 upon error from
 clk_round_rate()
Date: Tue, 10 Dec 2013 03:24:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312100323010.32309@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39301 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab3LJDYm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Dec 2013 22:24:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


clk_round_rate() should return 0 upon an error, rather than
returning a negative error code.  This is because clk_round_rate() is
being changed to return an unsigned return value rather than a signed
value, since some clock sources can generate rates higher than
(2^31)-1 Hz.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
Applies on v3.13-rc3.  See also:

http://marc.info/?l=linux-arm-kernel&m=138542591313620&w=2

 arch/arm/mach-omap1/clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 4f5fd4a084c0..ad9b620a4f30 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -250,7 +250,7 @@ long omap1_clk_round_rate_ckctl_arm(struct clk *clk, unsigned long rate)
 {
 	int dsor_exp = calc_dsor_exp(clk, rate);
 	if (dsor_exp < 0)
-		return dsor_exp;
+		return 0;
 	if (dsor_exp > 3)
 		dsor_exp = 3;
 	return clk->parent->rate / (1 << dsor_exp);
@@ -285,7 +285,7 @@ long omap1_round_to_table_rate(struct clk *clk, unsigned long rate)
 
 	ref_rate = ck_ref_p->rate;
 
-	highest_rate = -EINVAL;
+	highest_rate = 0;
 
 	for (ptr = omap1_rate_table; ptr->rate; ptr++) {
 		if (!(ptr->flags & cpu_mask))
-- 
1.8.4.4

