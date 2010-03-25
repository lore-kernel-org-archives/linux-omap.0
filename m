From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 1/3] DSPBRIDGE: remove ntfy_init/exit functions
Date: Wed, 24 Mar 2010 22:52:54 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CADC2FF2@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53511 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016Ab0CYDxF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 23:53:05 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

>From 06b665342b8c96d36eb3211e50b7d24a196182fb Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 24 Mar 2010 12:28:06 -0600
Subject: [PATCH] DSPBRIDGE: remove ntfy_init/exit functions

This patches removes ntfy_init/exit funcitons which are
doing nothing.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/ntfy.h |   27 ---------------------------
 drivers/dsp/bridge/services/ntfy.c          |   20 --------------------
 drivers/dsp/bridge/services/services.c      |    6 +-----
 3 files changed, 1 insertions(+), 52 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/ntfy.h b/arch/arm/plat-omap/include/dspbridge/ntfy.h
index 11fa4b6..53f6cbd 100644
--- a/arch/arm/plat-omap/include/dspbridge/ntfy.h
+++ b/arch/arm/plat-omap/include/dspbridge/ntfy.h
@@ -31,7 +31,6 @@ struct ntfy_object;
  *      DSP_SOK:        Success.
  *      DSP_EMEMORY:    Memory allocation failure.
  *  Requires:
- *      ntfy_init(void) called.
  *      phNtfy != NULL.
  *  Ensures:
  *      DSP_SUCCEEDED(status) <==>  IS_VALID(*phNtfy).
@@ -46,36 +45,12 @@ extern dsp_status ntfy_create(OUT struct ntfy_object **phNtfy);
  *      ntfy_obj:  Handle returned from ntfy_create().
  *  Returns:
  *  Requires:
- *      ntfy_init(void) called.
  *      IS_VALID(ntfy_obj).
  *  Ensures:
  */
 extern void ntfy_delete(IN struct ntfy_object *ntfy_obj);
 
 /*
- *  ======== ntfy_exit ========
- *  Purpose:
- *      Discontinue usage of NTFY module.
- *  Parameters:
- *  Returns:
- *  Requires:
- *      ntfy_init(void) successfully called before.
- *  Ensures:
- */
-extern void ntfy_exit(void);
-
-/*
- *  ======== ntfy_init ========
- *  Purpose:
- *      Initialize the NTFY module.
- *  Parameters:
- *  Returns:
- *      TRUE if initialization succeeded, FALSE otherwise.
- *  Ensures:
- */
-extern bool ntfy_init(void);
-
-/*
  *  ======== ntfy_notify ========
  *  Purpose:
  *      Execute notify function (signal event or post message) for every
@@ -86,7 +61,6 @@ extern bool ntfy_init(void);
  *      event_mask: The type of event that has occurred.
  *  Returns:
  *  Requires:
- *      ntfy_init(void) called.
  *      IS_VALID(ntfy_obj).
  *  Ensures:
  */
@@ -112,7 +86,6 @@ extern void ntfy_notify(IN struct ntfy_object *ntfy_obj, IN u32 event_mask);
  *      DSP_EHANDLE:        NULL hnotification, hnotification event name
  *                          too long, or hnotification event name NULL.
  *  Requires:
- *      ntfy_init(void) called.
  *      IS_VALID(ntfy_obj).
  *      hnotification != NULL.
  *      notify_type is DSP_SIGNALEVENT
diff --git a/drivers/dsp/bridge/services/ntfy.c b/drivers/dsp/bridge/services/ntfy.c
index b7da988..6d7d815 100644
--- a/drivers/dsp/bridge/services/ntfy.c
+++ b/drivers/dsp/bridge/services/ntfy.c
@@ -132,26 +132,6 @@ void ntfy_delete(struct ntfy_object *ntfy_obj)
 }
 
 /*
- *  ======== ntfy_exit ========
- *  Purpose:
- *      Discontinue usage of NTFY module.
- */
-void ntfy_exit(void)
-{
-	/* Do nothing */
-}
-
-/*
- *  ======== ntfy_init ========
- *  Purpose:
- *      Initialize the NTFY module.
- */
-bool ntfy_init(void)
-{
-	return true;
-}
-
-/*
  *  ======== ntfy_notify ========
  *  Purpose:
  *      Execute notify function (signal event) for every
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index ccc4e93..df3de5f 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -45,7 +45,6 @@
 void services_exit(void)
 {
 	/* Uninitialize all SERVICES modules here */
-	ntfy_exit();
 	clk_exit();
 	reg_exit();
 	cfg_exit();
@@ -61,20 +60,17 @@ bool services_init(void)
 {
 	bool ret = true;
 	bool fcfg, fmem;
-	bool freg, fclk, fntfy;
+	bool freg, fclk;
 
 	/* Perform required initialization of SERVICES modules. */
 	fmem = services_mem_init();
 	freg = reg_init();
 	fcfg = cfg_init();
 	fclk = services_clk_init();
-	fntfy = ntfy_init();
 
 	ret = fcfg && fmem && freg && fclk;
 
 	if (!ret) {
-		if (fntfy)
-			ntfy_exit();
 
 		if (fclk)
 			clk_exit();
-- 
1.6.0.4

