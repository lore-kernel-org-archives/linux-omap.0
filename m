From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] omap3: feature: fix OMAP3_IVA_MASK
Date: Fri,  5 Nov 2010 12:05:21 -0400
Message-ID: <1288973121-14073-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60210 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab0KEQFv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 12:05:51 -0400
Received: by gyh4 with SMTP id 4so2266987gyh.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 09:05:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Arno Steffen <arno.steffen@googlemail.com>

From: Arno Steffen <arno.steffen@googlemail.com>

OMAP3_IVA_MASK should use OMAP3_IVA_SHIFT instead of OMAP3_SGX_SHIFT

Signed-off-by: Arno Steffen <arno.steffen@googlemail.com>
---
Sending on behalf of Arno - he pointed at the change and everything
except for the patch ;)
Reported here:
http://marc.info/?l=linux-omap&m=128896969832702&w=2

 arch/arm/mach-omap2/control.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index b6c6b7c..5325297 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -309,7 +309,7 @@
 #define		FEAT_SGX_NONE		2
 
 #define OMAP3_IVA_SHIFT			12
-#define OMAP3_IVA_MASK			(1 << OMAP3_SGX_SHIFT)
+#define OMAP3_IVA_MASK			(1 << OMAP3_IVA_SHIFT)
 #define		FEAT_IVA		0
 #define		FEAT_IVA_NONE		1
 
-- 
1.7.1

