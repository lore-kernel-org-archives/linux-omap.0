From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] Fixed OMAP3 version check
Date: Tue, 16 Sep 2008 16:46:37 +0300
Message-ID: <1221572797-15949-2-git-send-email-tero.kristo@nokia.com>
References: <>
 <1221572797-15949-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21629 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbYIPL5l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 07:57:41 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8GBvSIO021484
	for <linux-omap@vger.kernel.org>; Tue, 16 Sep 2008 14:57:39 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8GBv7i8007031
	for <linux-omap@vger.kernel.org>; Tue, 16 Sep 2008 14:57:08 +0300
In-Reply-To: <1221572797-15949-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

CPU version was reported incorrectly (e.g. ES3.0 instead of ES2.1.)
Also added a piece of optimization for CPU type check (omap_type()).

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/id.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index ab7a6e9..4e2b449 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -37,7 +37,10 @@ EXPORT_SYMBOL(omap_chip_is);
 
 int omap_type(void)
 {
-	u32 val = 0;
+	static u32 val;
+
+	if (val != 0)
+		return val;
 
 	if (cpu_is_omap24xx()) {
 		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
@@ -169,7 +172,7 @@ void __init omap34xx_check_revision(void)
 	rev = (idcode >> 28) & 0xff;
 
 	if (hawkeye == 0xb7ae)
-		system_rev = 0x34300034 | ((1 + rev) << 12);
+		system_rev = 0x34300034 | (rev << 12);
 
 out:
 	switch (system_rev) {
-- 
1.5.4.3

