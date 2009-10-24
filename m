From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 1/1] input: lm8323: setting correct value to size_y
Date: Sat, 24 Oct 2009 16:18:31 -0400
Message-ID: <4AE36117.8090601@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58641 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbZJXUSe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Oct 2009 16:18:34 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9OKIa4f030125
	for <linux-omap@vger.kernel.org>; Sat, 24 Oct 2009 23:18:37 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

This simple patch fixes the correct value to plataform parameter size_y.

Fix needed to make N810 keyboard work properly.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 arch/arm/mach-omap2/board-n800.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index cb32b61..0a50fd3 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -115,7 +115,7 @@ static struct lm8323_platform_data lm8323_pdata = {
 	.repeat		= 0, /* Repeat is handled in userspace for now. */
 	.keymap		= rx44_keymap,
 	.size_x		= 8,
-	.size_y		= 8,
+	.size_y		= 12,
 	.debounce_time	= 12,
 	.active_time	= 500,
 
-- 1.5.4.3

