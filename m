From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/11] ARM: OMAP: Fixed comments on global PRM register usage
Date: Thu,  8 May 2008 15:49:35 -0700
Message-ID: <1210286975-29506-12-git-send-email-tony@atomide.com>
References: omap-fixes-2008-05-08-154932
 <1210286975-29506-1-git-send-email-tony@atomide.com>
 <1210286975-29506-2-git-send-email-tony@atomide.com>
 <1210286975-29506-3-git-send-email-tony@atomide.com>
 <1210286975-29506-4-git-send-email-tony@atomide.com>
 <1210286975-29506-5-git-send-email-tony@atomide.com>
 <1210286975-29506-6-git-send-email-tony@atomide.com>
 <1210286975-29506-7-git-send-email-tony@atomide.com>
 <1210286975-29506-8-git-send-email-tony@atomide.com>
 <1210286975-29506-9-git-send-email-tony@atomide.com>
 <1210286975-29506-10-git-send-email-tony@atomide.com>
 <1210286975-29506-11-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61593 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762162AbYEHWtz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 18:49:55 -0400
In-Reply-To: <1210286975-29506-11-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, Tony Lindgren <tony@atomide.com>

From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

Fixed comments on global PRM register usage.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/prm.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index ab7649a..618f811 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -30,7 +30,7 @@
 
 /*
  * Architecture-specific global PRM registers
- * Use prm_{read,write}_reg() with these registers.
+ * Use __raw_{read,write}l() with these registers.
  *
  * With a few exceptions, these are the register names beginning with
  * PRCM_* on 24xx, and PRM_* on 34xx.  (The exceptions are the
-- 
1.5.3.6

