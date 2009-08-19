From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] arch: arm: omap: terminate ifndef
Date: Wed, 19 Aug 2009 13:32:18 +0300
Message-ID: <1250677938-27955-1-git-send-email-felipe.balbi@nokia.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DCD67D97@dbde02.ent.ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56935 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbZHSKeE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Aug 2009 06:34:04 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7JAXCxF008437
	for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2009 05:33:39 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DCD67D97@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

There was a missing endif on cpu.h

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/include/mach/cpu.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 61dbe90..7a5f9e8 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -422,3 +422,5 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 int omap_chip_is(struct omap_chip_id oci);
 void omap2_check_revision(void);
+
+#endif /* __ASM_ARCH_OMAP_CPU_H */
-- 
1.6.3.3.385.g60647

