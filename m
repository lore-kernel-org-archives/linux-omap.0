From: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Subject: [PATCH 05/13] DSPBRIDGE: Remove mem_init and mem_exit functions
Date: Thu, 8 Apr 2010 19:01:28 -0500
Message-ID: <818EF96F5A7CC84789DD014773DB09548E64D150@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59722 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758215Ab0DIAD6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 20:03:58 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ameya.Palande@nokia.com" <Ameya.Palande@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From a6517d9767565b48f09ef8ed4e27fe362ebdadf6 Mon Sep 17 00:00:00 2001
From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Date: Wed, 24 Mar 2010 12:24:37 -0600
Subject: [PATCH 05/13] DSPBRIDGE: Remove mem_init and mem_exit functions

These functions do nothing. So they are removed from mem.c file.

Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/mem.h |   27 ---------------------------
 drivers/dsp/bridge/services/mem.c          |   21 ---------------------
 drivers/dsp/bridge/services/services.c     |   10 ++--------
 3 files changed, 2 insertions(+), 56 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
index 9f713b9..f321f3f 100644
--- a/arch/arm/plat-omap/include/dspbridge/mem.h
+++ b/arch/arm/plat-omap/include/dspbridge/mem.h
@@ -90,20 +90,6 @@ extern void *mem_alloc(IN u32 byte_size, IN enum mem_poolattrs type);
 extern void *mem_calloc(IN u32 byte_size, IN enum mem_poolattrs type);
 
 /*
- *  ======== mem_exit ========
- *  Purpose:
- *      Discontinue usage of module; free resources when reference count
- *      reaches 0.
- *  Parameters:
- *  Returns:
- *  Requires:
- *      MEM is initialized.
- *  Ensures:
- *      Resources used by module are freed when cRef reaches zero.
- */
-extern void mem_exit(void);
-
-/*
  *  ======== MEM_FREE_OBJECT ========
  *  Purpose:
  *      Utility macro to invalidate an object's signature, and deallocate it.
@@ -138,19 +124,6 @@ extern void mem_exit(void);
 extern s32 mem_get_num_pages(IN void *paddr, IN u32 byte_size);
 
 /*
- *  ======== services_mem_init ========
- *  Purpose:
- *      Initializes private state of MEM module.
- *  Parameters:
- *  Returns:
- *      TRUE if initialized; FALSE if error occured.
- *  Requires:
- *  Ensures:
- *      MEM initialized.
- */
-extern bool services_mem_init(void);
-
-/*
  *  ======== MEM_IS_VALID_HANDLE ========
  *  Purpose:
  *      Validate the object handle.
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 6e8834a..cf33e89 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -96,24 +96,3 @@ void *mem_calloc(u32 byte_size, enum mem_poolattrs type)
 
 	return mem;
 }
-
-/*
- *  ======== mem_exit ========
- *  Purpose:
- *      Discontinue usage of the MEM module.
- */
-void mem_exit(void)
-{
-}
-
-
-
-/*
- *  ======== services_mem_init ========
- *  Purpose:
- *      Initialize MEM module private state.
- */
-bool services_mem_init(void)
-{
-	return true;
-}
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index df3de5f..49a0a89 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -48,7 +48,6 @@ void services_exit(void)
 	clk_exit();
 	reg_exit();
 	cfg_exit();
-	mem_exit();
 }
 
 /*
@@ -59,16 +58,15 @@ void services_exit(void)
 bool services_init(void)
 {
 	bool ret = true;
-	bool fcfg, fmem;
+	bool fcfg;
 	bool freg, fclk;
 
 	/* Perform required initialization of SERVICES modules. */
-	fmem = services_mem_init();
 	freg = reg_init();
 	fcfg = cfg_init();
 	fclk = services_clk_init();
 
-	ret = fcfg && fmem && freg && fclk;
+	ret = fcfg && freg && fclk;
 
 	if (!ret) {
 
@@ -80,10 +78,6 @@ bool services_init(void)
 
 		if (fcfg)
 			cfg_exit();
-
-		if (fmem)
-			mem_exit();
-
 	}
 
 	return ret;
-- 
1.7.0.3
