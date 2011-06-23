From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 5/6] OMAP2+: hwmod: Remove _populate_mpu_rt_base warning
Date: Thu, 23 Jun 2011 23:00:41 +0200
Message-ID: <1308862842-3933-6-git-send-email-b-cousson@ti.com>
References: <1308862842-3933-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40569 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990Ab1FWVBN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 17:01:13 -0400
In-Reply-To: <1308862842-3933-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

It is perfectly valid for some hwmod to not have any
register target address for sysconfig. This is especially
true for interconnect hwmods.
Remove the warning.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 3800084..f401417 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1704,9 +1704,6 @@ static int __init _populate_mpu_rt_base(struct omap_hwmod *oh, void *data)
 		return 0;
 
 	oh->_mpu_rt_va = _find_mpu_rt_base(oh, oh->_mpu_port_index);
-	if (!oh->_mpu_rt_va)
-		pr_warning("omap_hwmod: %s found no _mpu_rt_va for %s\n",
-				__func__, oh->name);
 
 	return 0;
 }
-- 
1.7.0.4

