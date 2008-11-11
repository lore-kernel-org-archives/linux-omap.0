From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH v2 4/6] OMAP: Fix twl4030 keypad bug.
Date: Tue, 11 Nov 2008 19:50:56 +0800
Message-ID: <1226404258-13027-5-git-send-email-stanley.miao@windriver.com>
References: <1226404258-13027-1-git-send-email-stanley.miao@windriver.com>
 <1226404258-13027-2-git-send-email-stanley.miao@windriver.com>
 <1226404258-13027-3-git-send-email-stanley.miao@windriver.com>
 <1226404258-13027-4-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63296 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755352AbYKKLpb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2008 06:45:31 -0500
In-Reply-To: <1226404258-13027-4-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: johnpol@2ka.mipt.ru

The n_cols number has beed set to the right value in the board specific file,
so in the twl4030 driver, the n_cols doesn't need to plus 1.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 drivers/input/keyboard/omap-twl4030keypad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/omap-twl4030keypad.c b/drivers/input/keyboard/omap-twl4030keypad.c
index 13c9c0a..21f922d 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -173,7 +173,7 @@ static void twl4030_kp_scan(struct omap_keypad *kp, int release_all)
 		if (!changed)
 			continue;
 
-		for (col = 0; col < kp->n_cols + 1; col++) {
+		for (col = 0; col < kp->n_cols; col++) {
 			int key;
 
 			if (!(changed & (1 << col)))
-- 
1.5.6.3

