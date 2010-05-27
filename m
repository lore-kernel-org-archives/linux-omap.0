From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/5] OMAP: hwmod: if IDLEST fields are not set, use module defaults
Date: Thu, 27 May 2010 14:13:33 -0700
Message-ID: <1274994816-30335-3-git-send-email-khilman@deeprootsystems.com>
References: <1274994816-30335-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45584 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756733Ab0E0VNn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 17:13:43 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so248809pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 14:13:43 -0700 (PDT)
In-Reply-To: <1274994816-30335-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

In the _setup() hook, check for valid IDLEST fields.  If not set, use
the module defaults since they are the same as the module defaults
for most hwmods.

Problem found because _wait_target_ready() will fail if IDLEST
fields are not valid.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index a127c9b..77fef90 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1036,6 +1036,12 @@ static int _setup(struct omap_hwmod *oh)
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
 
+	/* if IDLEST values are not set, use module defaults */
+	if (!oh->prcm.omap2.idlest_reg_id)
+		oh->prcm.omap2.idlest_reg_id = oh->prcm.omap2.prcm_reg_id;
+	if (!oh->prcm.omap2.idlest_idle_bit)
+		oh->prcm.omap2.idlest_idle_bit = oh->prcm.omap2.module_bit;
+
 	r = _enable(oh);
 	if (r) {
 		pr_warning("omap_hwmod: %s: cannot be enabled (%d)\n",
-- 
1.7.0.2

