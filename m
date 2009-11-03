From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: [PATCH 1/2] DSPBRIDGE: Lower power transtion timeout
Date: Tue, 3 Nov 2009 17:07:49 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A530426AACC4B@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57940 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbZKCXHp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 18:07:45 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3N7oKv002349
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:07:50 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id nA3N7n1F010501
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:07:50 -0600 (CST)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA3N7nHc011925
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:07:49 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP <linux-omap@vger.kernel.org>

Given system latency and low timer resolutions, device
driver timeout needs to be cut to report any error, while
transitioning to OFF mode.

In the best case scenario, the transition should be immediate,
but in the worst scenario it could take up to ~400 ms,
even tough the driver defines the waiting loop to be 200 ms.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/_tiomap_util.h   |    7 +++++--
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/_tiomap_util.h b/drivers/dsp/bridge/wmd/_tiomap_util.h
index 8f1e515..bd1b571 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_util.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_util.h
@@ -31,8 +31,11 @@
 /* Time out Values in uSeconds*/
 #define TIHELEN_ACKTIMEOUT  10000
 
-/* Time out for power state transition (in msecs) */
-#define PWRSTST_TIMEOUT		1500
+/*
+ * Time out for power state transition (in msecs), due to system
+ * latencies and HZ resolution this timer can vary.
+ */
+#define PWRSTST_TIMEOUT		200
 
 /*  Time delay for HOM->SAM transition. */
 #define  WAIT_SAM   1000000	/* in usec (1000 millisec) */
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 0c2f2fd..2eb379f 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -248,7 +248,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 			&pwrState);
 
 	/* Wait for DSP to move into target power state */
-	while ((pwrState != targetPwrState) && --timeout) {
+	while ((pwrState != targetPwrState) && timeout--) {
 		if (msleep_interruptible(10)) {
 			pr_err("Waiting for DSP to Suspend interrupted\n");
 			return DSP_EFAIL;
-- 
1.6.2.4
