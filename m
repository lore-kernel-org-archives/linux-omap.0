From: Michael Jones <michael.jones@matrix-vision.de>
Subject: [PATCH] OMAP3 clock: remove obsolete comment
Date: Thu, 26 Jul 2012 14:28:42 +0200
Message-ID: <1343305722-16721-1-git-send-email-michael.jones@matrix-vision.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail2.matrix-vision.com ([85.214.244.251]:45328 "EHLO
	mail2.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab2GZMbx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 08:31:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>


Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 1efdec2..025b5d9 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3223,7 +3223,6 @@ static struct clk dummy_apb_pclk = {
  * clkdev
  */
 
-/* XXX At some point we should rename this file to clock3xxx_data.c */
 static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"apb_pclk",	&dummy_apb_pclk,	CK_3XXX),
 	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_3XXX),
-- 
1.7.4.1


MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Erhard Meier
