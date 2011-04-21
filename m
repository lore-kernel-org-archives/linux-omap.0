From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] OMAP2+: powerdomain: fix typo: lose context --> loose context
Date: Wed, 20 Apr 2011 17:25:31 -0700
Message-ID: <1303345531-8435-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36431 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751971Ab1DUAXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Apr 2011 20:23:40 -0400
Received: by mail-pw0-f49.google.com with SMTP id 8so763871pwi.8
        for <linux-omap@vger.kernel.org>; Wed, 20 Apr 2011 17:23:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsely <paul@pwsan.com>, charu@ti.com

Before we get any users of this function, fix the name (and comments)
to use loose instead of lose.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies to v2.6.39-rc4

 arch/arm/mach-omap2/powerdomain.c |    6 +++---
 arch/arm/mach-omap2/powerdomain.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 9af0847..ec3423f 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -960,18 +960,18 @@ u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
 }
 
 /**
- * pwrdm_can_ever_lose_context - can this powerdomain ever lose context?
+ * pwrdm_can_ever_loose_context - can this powerdomain ever loose context?
  * @pwrdm: struct powerdomain *
  *
  * Given a struct powerdomain * @pwrdm, returns 1 if the powerdomain
- * can lose either memory or logic context or if @pwrdm is invalid, or
+ * can loose either memory or logic context or if @pwrdm is invalid, or
  * returns 0 otherwise.  This function is not concerned with how the
  * powerdomain registers are programmed (i.e., to go off or not); it's
  * concerned with whether it's ever possible for this powerdomain to
  * go off while some other part of the chip is active.  This function
  * assumes that every powerdomain can go to either ON or INACTIVE.
  */
-bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm)
+bool pwrdm_can_ever_loose_context(struct powerdomain *pwrdm)
 {
 	int i;
 
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index d23d979..95d5b9e 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -208,7 +208,7 @@ int pwrdm_pre_transition(void);
 int pwrdm_post_transition(void);
 int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
 u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
-bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
+bool pwrdm_can_ever_loose_context(struct powerdomain *pwrdm);
 
 extern void omap2xxx_powerdomains_init(void);
 extern void omap3xxx_powerdomains_init(void);
-- 
1.7.4

