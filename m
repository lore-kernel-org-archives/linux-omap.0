From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/2] DSPBRIDGE: logic error fix for SleepDSP timeout value
Date: Thu, 18 Feb 2010 15:55:33 -0600
Message-ID: <1266530134-8186-2-git-send-email-omar.ramirez@ti.com>
References: <1266530134-8186-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55633 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758570Ab0BRVm6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 16:42:58 -0500
In-Reply-To: <1266530134-8186-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

When leaving the loop waiting for the dsp to transition
from its power state, timeout value will be negative, therefore
a print for "timeout waiting for the dsp" won't be displayed, as
the condition to check for is !timeout.

Reported-by: Berenice Herrera <berenice@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 084f406..96b942b 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -239,7 +239,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 			&pwrState);
 
 	/* Wait for DSP to move into target power state */
-	while ((pwrState != targetPwrState) && timeout--) {
+	while ((pwrState != targetPwrState) && --timeout) {
 		if (msleep_interruptible(10)) {
 			pr_err("Waiting for DSP to Suspend interrupted\n");
 			return DSP_EFAIL;
-- 
1.6.2.4

