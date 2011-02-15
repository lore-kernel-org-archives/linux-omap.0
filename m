From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 04/15] cbus: retu: drop unused PFX macro
Date: Tue, 15 Feb 2011 10:45:51 +0200
Message-ID: <1297759562-25682-5-git-send-email-balbi@ti.com>
References: <1297759562-25682-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:53348 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751178Ab1BOIqf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 03:46:35 -0500
Received: by mail-gx0-f174.google.com with SMTP id 9so2584307gxk.33
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 00:46:34 -0800 (PST)
In-Reply-To: <1297759562-25682-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

That's not used anywhere in the code,
so simply drop it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 82d22b8..b1c8e57 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -50,7 +50,6 @@
 #include "retu.h"
 
 #define RETU_ID			0x01
-#define PFX			"retu: "
 
 struct retu {
 	/* Device lock */
-- 
1.7.4.rc2

