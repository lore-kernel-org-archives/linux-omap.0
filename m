From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: mach-omap2: mux: free allocated memory on error exit
Date: Fri, 28 Jan 2011 16:50:55 +0200
Message-ID: <1296226255-5694-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:34769 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753278Ab1A1OsX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 09:48:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

Free allocated memory on error exit.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/mux.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index df8d2f2..18aea0c 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -1000,6 +1000,7 @@ int __init omap_mux_init(const char *name, u32 flags,
 	if (!partition->base) {
 		pr_err("%s: Could not ioremap mux partition at 0x%08x\n",
 			__func__, partition->phys);
+		kfree(partition);
 		return -ENODEV;
 	}
 
-- 
1.5.6.5

