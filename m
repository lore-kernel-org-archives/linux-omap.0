From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 09/11] TWL CORE: Fix sparse warning
Date: Fri, 27 Aug 2010 02:26:47 +0530
Message-ID: <1282856209-15645-10-git-send-email-manjugk@ti.com>
References: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41792 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103Ab0HZU6T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Aug 2010 16:58:19 -0400
In-Reply-To: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

From: Manjunatha GK <manjugk@ti.com>

Fixes below sparse warning.

drivers/mfd/twl-core.c:258:20: warning: symbol 'twl_map' was not declared. Should it be static?

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
---
 drivers/mfd/twl-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 720e099..53c371a 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -255,7 +255,7 @@ struct twl_mapping {
 	unsigned char sid;	/* Slave ID */
 	unsigned char base;	/* base address */
 };
-struct twl_mapping *twl_map;
+static struct twl_mapping *twl_map;
 
 static struct twl_mapping twl4030_map[TWL4030_MODULE_LAST + 1] = {
 	/*
-- 
1.7.0.4

