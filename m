From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP: powerdomain: remove unused func declaration
Date: Wed, 19 Jan 2011 19:52:40 +0530
Message-ID: <1295446960-24358-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50530 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994Ab1ASOWr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 09:22:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, Rajendra Nayak <rnayak@ti.com>

Trivial fix to remove the unused function declaration
from the powerdomain header.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomain.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index c66431e..0b7a357 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -165,7 +165,6 @@ struct pwrdm_ops {
 	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
 };
 
-void pwrdm_fw_init(void);
 void pwrdm_init(struct powerdomain **pwrdm_list, struct pwrdm_ops *custom_funcs);
 
 struct powerdomain *pwrdm_lookup(const char *name);
-- 
1.7.0.4

