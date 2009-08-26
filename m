From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/2] DSPBRIDGE: fix build error for mboxsetting with debug
Date: Wed, 26 Aug 2009 09:42:14 +0300
Message-ID: <1251268935-1215-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17309 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576AbZHZGmV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Aug 2009 02:42:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ameya.palande@nokia.com, h-kanigeri2@ti.com, x0095840@ti.com, omar.ramirez@ti.com, nm@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/hw/hw_mbox.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/hw_mbox.c
index 5a87597..8591729 100644
--- a/drivers/dsp/bridge/hw/hw_mbox.c
+++ b/drivers/dsp/bridge/hw/hw_mbox.c
@@ -33,7 +33,7 @@
 /* width in bits of MBOX Id */
 #define HW_MBOX_ID_WIDTH	   2
 
-static struct MAILBOX_CONTEXT mboxsetting = {
+struct MAILBOX_CONTEXT mboxsetting = {
 	.sysconfig = 2 << 3 | 1, /* SMART/AUTO-IDLE */
 };
 
-- 
1.6.0.4

