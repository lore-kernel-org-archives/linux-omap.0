From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP: hwmod: if IDLEST fields are not set, use module defaults
Date: Thu, 20 May 2010 16:59:30 -0700
Message-ID: <1274399970-21732-2-git-send-email-khilman@deeprootsystems.com>
References: <1274399970-21732-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f185.google.com ([209.85.222.185]:58147 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516Ab0ETX7e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 19:59:34 -0400
Received: by mail-pz0-f185.google.com with SMTP id 15so206250pzk.15
        for <linux-omap@vger.kernel.org>; Thu, 20 May 2010 16:59:34 -0700 (PDT)
In-Reply-To: <1274399970-21732-1-git-send-email-khilman@deeprootsystems.com>
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
RFC: is this an OK solution, or is the preferred solution to ensure
that all the hwmod data is filled with valid fields.

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

