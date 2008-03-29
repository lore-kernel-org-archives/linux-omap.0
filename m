From: Andrzej Zaborowski <balrogg@gmail.com>
Subject: [PATCH] Fix TUSB6010 ID register offsets.
Date: Sat, 29 Mar 2008 18:52:16 +0100
Message-ID: <12068131361588-git-send-email-balrogg@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:44886 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827AbYC2QsX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 Mar 2008 12:48:23 -0400
Received: from borg (cnb216.neoplus.adsl.tpnet.pl [83.31.155.216])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pug.o-hand.com (Postfix) with ESMTP id CDFE4E2B26F
	for <linux-omap@vger.kernel.org>; Sat, 29 Mar 2008 12:48:21 -0400 (EDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Andrzej Zaborowski <balrog@zabor.org>

[Sorry, the previous patch was a copy/paste mistake, this one should be
better]

I have no access to the docs for this chip but I'm pretty sure the current
address of the two DIDR1 registers is wrong because it's outside the
TUSB-specific register space.  The modified address in turn has a good
chance to be correct.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
---
 drivers/usb/musb/tusb6010.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/tusb6010.h b/drivers/usb/musb/tusb6010.h
index bb25c3b..f2036ef 100644
--- a/drivers/usb/musb/tusb6010.h
+++ b/drivers/usb/musb/tusb6010.h
@@ -225,8 +225,8 @@ extern void tusb_allow_idle(struct musb *musb, u32 wakeup_enables);
 #define TUSB_PROD_TEST_RESET_VAL		0xa596
 #define TUSB_EP_FIFO(ep)			(TUSB_FIFO_BASE + (ep) * 0x20)
 
-#define TUSB_DIDR1_LO				0x1f8
-#define TUSB_DIDR1_HI				0x1fc
+#define TUSB_DIDR1_LO				(TUSB_SYS_REG_BASE + 0x1f8)
+#define TUSB_DIDR1_HI				(TUSB_SYS_REG_BASE + 0x1fc)
 #define		TUSB_DIDR1_HI_CHIP_REV(v)		(((v) >> 17) & 0xf)
 #define			TUSB_DIDR1_HI_REV_20		0
 #define			TUSB_DIDR1_HI_REV_30		1
-- 
1.5.3.4

