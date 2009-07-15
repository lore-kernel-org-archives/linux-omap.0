From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 10/13] DSPBRIDGE: HACK: insert delay for DPLL stabilization
Date: Wed, 15 Jul 2009 17:56:33 +0300
Message-ID: <1247669795-23895-11-git-send-email-ameya.palande@nokia.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-4-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-5-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-6-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-7-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-8-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-9-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-10-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18137 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784AbZGOO5O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 10:57:14 -0400
In-Reply-To: <1247669795-23895-10-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, x0095840@ti.com, nm@ti.com, hiroshi.doyu@nokia.com

*HACK*: status register should be checked for this purpose.

[Hiroshi DOYU: split the original to logical ones]

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 7d389e3..02e2675 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -141,6 +141,13 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 		temp = (temp & 0xFFFFFF08) | 0x37;
 		*(REG_UWORD32 *)(resources.dwCmBase + 0x4) = temp;
 
+		/*
+		 * This delay is needed to avoid mailbox timed out
+		 * issue experienced while SmartReflex is ON.
+		 * TODO: Instead of 1 ms calculate proper value.
+		 */
+		mdelay(1);
+
 		/* Restore mailbox settings */
 		HW_MBOX_restoreSettings(resources.dwMboxBase);
 
-- 
1.6.2.4

