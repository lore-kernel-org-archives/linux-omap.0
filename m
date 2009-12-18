From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 2/2] DSPBRIDGE: remove unused things in clk.c and mem.c
Date: Fri, 18 Dec 2009 12:16:24 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602A9ADD24C@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48971 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932343AbZLRSQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 13:16:26 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBIIGP5Y001330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 12:16:25 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBIIGPvZ028790
	for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 12:16:25 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBIIGPma018954
	for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 12:16:25 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 70a2d5a2c8e59679f90e7e4fce084a7ea02ce0da Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Thu, 17 Dec 2009 11:57:11 -0600
Subject: [PATCH] DSPBRIDGE: remove unused things in clk.c and mem.c

This patch removes unused define from mem.c and unused
struct in clk.c.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/services/clk.c |    5 -----
 drivers/dsp/bridge/services/mem.c |    1 -
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 9a18e11..e7b282d 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -82,11 +82,6 @@ static struct SERVICES_Clk_t SERVICES_Clks[] = {
 	{NULL, ""}
 };
 
-/* Generic TIMER object: */
-struct TIMER_OBJECT {
-	struct timer_list timer;
-};
-
 /*  ----------------------------------- Globals */
 #if GT_TRACE
 static struct GT_Mask CLK_debugMask = { NULL, NULL };	/* GT trace variable */
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index f0dd9fc..d937c7c 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -33,7 +33,6 @@
 #include <dspbridge/list.h>
 
 /*  ----------------------------------- Defines */
-#define MEM_512MB   0x1fffffff
 #define memInfoSign 0x464E494D	/* "MINF" (in reverse). */
 
 #ifdef CONFIG_BRIDGE_DEBUG
-- 
1.6.0.4
