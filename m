From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH] Temporary fix to boot OMAP1 based boards
Date: Tue, 23 Sep 2008 20:53:09 +0530
Message-ID: <dfeb90390809230823l7c37d15au49c5726c7510718c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:14884 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbYIWPXK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 11:23:10 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2216766rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 23 Sep 2008 08:23:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This patch is a temporary fix for a kernel panic causing at omap1_clk_init

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/plat-omap/include/mach/clock.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/clock.h
b/arch/arm/plat-omap/include/mach/clock.h
index f26ad8c..b9c471e 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -67,7 +67,11 @@ struct clk {
 	struct clk		*parent;
 	unsigned long		rate;
 	__u32			flags;
+#if defined(CONFIG_ARCH_OMAP1)
+	void __iomem            *enable_reg;
+#elif
 	u16			enable_reg;
+#endif
 	__u8			enable_bit;
 	__s8			usecount;
 	u8			idlest_bit;
-- 
1.5.3.4
