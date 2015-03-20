From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 23/35] ARM: OMAP2+: id: cache omap_type value
Date: Fri, 20 Mar 2015 20:44:34 +0200
Message-ID: <1426877086-17131-24-git-send-email-t-kristo@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56926 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbbCTSqY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2015 14:46:24 -0400
In-Reply-To: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, sakari.ailus@iki.fi
Cc: linux-arm-kernel@lists.infradead.org

There is no need to read the register with every invocation of the function,
as the value is constant. Thus, cache the value in a static variable.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/id.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 2a2f4d5..f8121db 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -52,7 +52,10 @@ EXPORT_SYMBOL(omap_rev);
 
 int omap_type(void)
 {
-	u32 val = 0;
+	static u32 val = OMAP2_DEVICETYPE_MASK;
+
+	if (val < OMAP2_DEVICETYPE_MASK)
+		return val;
 
 	if (cpu_is_omap24xx()) {
 		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
-- 
1.7.9.5

