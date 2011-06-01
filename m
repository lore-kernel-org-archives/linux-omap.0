From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 2/3] OMAP2+: fix compilation warnings.
Date: Wed, 1 Jun 2011 11:28:56 +0530
Message-ID: <1306907936-28841-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57267 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab1FAF7G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 01:59:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>

Fix below compilation warnings.

arch/arm/mach-omap2/omap_hwmod.c: In function 'omap_hwmod_for_each':
arch/arm/mach-omap2/omap_hwmod.c:1631: warning: 'ret' may be used uninitialized in this function

arch/arm/mach-omap2/mux.c: In function 'omap_mux_get_gpio':
arch/arm/mach-omap2/mux.c:917: warning: 'm' may be used uninitialized in this function

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/mux.c        |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index a4ab1e3..b4f9066 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -906,7 +906,7 @@ static struct omap_mux *omap_mux_get_by_gpio(
 u16 omap_mux_get_gpio(int gpio)
 {
 	struct omap_mux_partition *partition;
-	struct omap_mux *m;
+	struct omap_mux *m = NULL;
 
 	list_for_each_entry(partition, &mux_partitions, node) {
 		m = omap_mux_get_by_gpio(partition, gpio);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e034294..293fa6c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1628,7 +1628,7 @@ int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data)
 {
 	struct omap_hwmod *temp_oh;
-	int ret;
+	int ret = 0;
 
 	if (!fn)
 		return -EINVAL;
-- 
1.7.0.4

