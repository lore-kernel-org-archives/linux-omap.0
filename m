From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 23/35] ARM: OMAP2+: id: cache omap_type value
Date: Wed, 25 Feb 2015 21:04:33 +0200
Message-ID: <1424891085-10392-24-git-send-email-t-kristo@ti.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51330 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbbBYTF0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 14:05:26 -0500
In-Reply-To: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

There is no need to read the register with every invocation of the function,
as the value is constant. Thus, cache the value in a static variable.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/id.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 2a2f4d5..1f5949f 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -52,7 +52,10 @@ EXPORT_SYMBOL(omap_rev);
 
 int omap_type(void)
 {
-	u32 val = 0;
+	static u32 val = OMAP2_DEVICETYPE_MASK + 1;
+
+	if (val < OMAP2_DEVICETYPE_MASK)
+		return val;
 
 	if (cpu_is_omap24xx()) {
 		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
-- 
1.7.9.5

