From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/3] OMAP2+: hwmod: Avoid setup if clock lookup failed
Date: Wed, 16 Feb 2011 17:41:23 +0530
Message-ID: <1297858285-7056-2-git-send-email-rnayak@ti.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50841 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759024Ab1BPMLe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 07:11:34 -0500
In-Reply-To: <1297858285-7056-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Add a hwmod state check in the _setup function
to avoid setting up hwmods' for which clock
lookup has failed.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e282e35..cd9dcde 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1362,6 +1362,12 @@ static int _setup(struct omap_hwmod *oh, void *data)
 	int i, r;
 	u8 postsetup_state;
 
+	if (oh->_state != _HWMOD_STATE_CLKS_INITED) {
+		WARN(1, "omap_hwmod: %s: _setup failed as one or more"
+		     "clock lookups' have failed\n", oh->name);
+		return -EINVAL;
+	}
+
 	/* Set iclk autoidle mode */
 	if (oh->slaves_cnt > 0) {
 		for (i = 0; i < oh->slaves_cnt; i++) {
-- 
1.7.0.4

