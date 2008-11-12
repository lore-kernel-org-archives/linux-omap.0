From: Dominic Curran <dcurran@ti.com>
Subject: [PATCH 2/3] [OMAPZOOM] INPUT: Fix twl4030 keypad bug.
Date: Wed, 12 Nov 2008 13:07:42 -0600
Message-ID: <200811121307.42331.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34511 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001AbYKLTHt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2008 14:07:49 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: stanley.miao@windriver.com

Fixes a bug in TWL4030 keypad where too many columns were being checked.
Code originally submitted by Stanley Miao to linux-omap tree.

Signed-off-by: Dominic Curran <dcurran@ti.com>
cc: Stanley.Miao <stanley.miao@windriver.com>
---
 drivers/input/keyboard/omap-twl4030keypad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/omap-twl4030keypad.c 
b/drivers/input/keyboard/omap-twl4030keypad.c
index 965b6a0..e8fd21c 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -176,7 +176,7 @@ static void twl4030_kp_scan(struct omap_keypad *kp, int release_all)
 		if (!changed)
 			continue;
 
-		for (col = 0; col < kp->n_cols + 1; col++) {
+		for (col = 0; col < kp->n_cols; col++) {
 			int key;
 
 			if (!(changed & (1 << col)))
-- 
1.5.4.1

