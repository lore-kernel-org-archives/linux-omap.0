From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v2 07/10] TWL CORE: Fix sparse warning
Date: Tue, 21 Sep 2010 15:31:17 +0530
Message-ID: <1285063280-4057-8-git-send-email-manjugk@ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43452 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756997Ab0IUKCJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 06:02:09 -0400
In-Reply-To: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

Fixes below sparse warning.

drivers/mfd/twl-core.c:258:20: warning: symbol 'twl_map' was not declared. Should it be static?

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Samuel Ortiz <sameo@linux.intel.com>
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

