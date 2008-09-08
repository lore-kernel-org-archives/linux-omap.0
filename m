From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] Fixed CPU type check for OMAP3
Date: Mon,  8 Sep 2008 19:33:49 +0300
Message-ID: <1220891629-26093-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32529 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbYIHOoe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 10:44:34 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m88EiCAb005846
	for <linux-omap@vger.kernel.org>; Mon, 8 Sep 2008 17:44:31 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m88EhG0r011508
	for <linux-omap@vger.kernel.org>; Mon, 8 Sep 2008 17:43:16 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

ES version definitions were incorrect, also GP/EMU/SEC etc. types were not
detected at all.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/id.c              |    9 ++++++++-
 arch/arm/plat-omap/include/mach/cpu.h |    2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index a526c0f..290b88c 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -53,6 +53,13 @@ static struct omap_id omap_ids[] __initdata = {
 	{ .hawkeye = 0xb68a, .dev = 0x0, .type = 0x24300000 },
 };
 
+static const char omap3_revs[][4] = {
+	"1.0",
+	"2.0",
+	"2.1",
+	"3.0"
+};
+
 static struct omap_chip_id omap_chip;
 
 /**
@@ -224,7 +231,7 @@ void __init omap2_check_revision(void)
 	 * Note that rev cannot be used directly as ES1.0 uses value 0.
 	 */
 	if (hawkeye == 0xb7ae) {
-		system_rev = 0x34300000 | ((1 + rev) << 12);
+		_set_system_rev(0x34300000 | (rev << 12), rev);
 		pr_info("OMAP%04x ES2.%i\n", system_rev >> 16, rev);
 		_set_omap_chip();
 		return;
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index e046418..e170d29 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -357,7 +357,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP3430_REV_ES1_0	0x34300000
 #define OMAP3430_REV_ES2_0	0x34301000
 #define OMAP3430_REV_ES2_1	0x34302000
-#define OMAP3430_REV_ES2_2	0x34303000
+#define OMAP3430_REV_ES3_0	0x34303000
 
 /*
  * omap_chip bits
-- 
1.5.4.3

