From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 1/1] PRM: Fixed comments on global PRM register usage.
Date: Tue,  6 May 2008 10:33:01 +0300
Message-ID: <1210059181-18192-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25754 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYEFHdq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 03:33:46 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m467XOQn017034
	for <linux-omap@vger.kernel.org>; Tue, 6 May 2008 10:33:43 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/prm.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 125d1e2..6715d6f 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -33,7 +33,7 @@
 
 /*
  * Architecture-specific global PRM registers
- * Use prm_{read,write}_reg() with these registers.
+ * Use __raw_{read,write}l() with these registers.
  *
  * With a few exceptions, these are the register names beginning with
  * PRCM_* on 24xx, and PRM_* on 34xx.  (The exceptions are the
-- 
1.5.4.3

