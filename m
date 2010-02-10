From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH] DSPBRIDGE: Avoid inserting wrong elements to STRM list
Date: Wed, 10 Feb 2010 02:34:33 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA725DC7@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56767 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253Ab0BJIei convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 03:34:38 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From 09260a0211d088d840d09c04380c8c9448c01ec4 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 10 Feb 2010 02:33:54 -0600
Subject: [PATCH] DSPBRIDGE: Avoid inserting wrong elements to STRM list

This fixes a bug where in error case and after deleting a
strm element (if allocated), the strm is still inserted as
part of the process context allocated resources, this pointer
is not valid and shouldn't be considered as part of valid
resources.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/rmgr/strm.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 1bb4670..e004205 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -634,12 +634,12 @@ func_cont:
 				  status);
 		}
 	}
-	if (DSP_SUCCEEDED(status))
+	if (DSP_SUCCEEDED(status)) {
 		*phStrm = pStrm;
-	else
+		DRV_ProcInsertSTRMResElement(*phStrm, &hSTRMRes, pr_ctxt);
+	} else {
 		(void)DeleteStrm(pStrm);
-
-	DRV_ProcInsertSTRMResElement(*phStrm, &hSTRMRes, pr_ctxt);
+	}
 
 	 /* ensure we return a documented error code */
 	DBC_Ensure((DSP_SUCCEEDED(status) &&
-- 
1.6.0.4

