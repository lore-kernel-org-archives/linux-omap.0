From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: mach-omap2: voltage: debugfs: fix memory leak
Date: Fri, 28 Jan 2011 18:24:11 +0200
Message-ID: <1296231851-20632-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:21780 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393Ab1A1QVm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 11:21:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

The temporary string holding the directory name to be created should
be released.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/voltage.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index ed6079c..12be525 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -471,6 +471,7 @@ static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
 	strcat(name, vdd->voltdm.name);
 
 	vdd->debug_dir = debugfs_create_dir(name, voltage_dir);
+	kfree(name);
 	if (IS_ERR(vdd->debug_dir)) {
 		pr_warning("%s: Unable to create debugfs directory for"
 			" vdd_%s\n", __func__, vdd->voltdm.name);
-- 
1.5.6.5

