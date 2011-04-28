From: green@linuxhacker.ru
Subject: [PATCH 2/2] Add tps65921 chip
Date: Thu, 28 Apr 2011 11:57:39 -0400
Message-ID: <1304006259-7939-3-git-send-email-green@linuxhacker.ru>
References: <1304006259-7939-1-git-send-email-green@linuxhacker.ru>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from c-71-228-165-73.hsd1.tn.comcast.net ([71.228.165.73]:38543 "EHLO
	fatbox1.localnet" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933304Ab1D1P55 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 11:57:57 -0400
In-Reply-To: <1304006259-7939-1-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Oleg Drokin <green@linuxhacker.ru>

From: Oleg Drokin <green@linuxhacker.ru>

---
 drivers/mfd/twl-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 960b5be..3daebcc 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1107,6 +1107,8 @@ static const struct i2c_device_id twl_ids[] = {
 	{ "tps65950", 0 },		/* catalog version of twl5030 */
 	{ "tps65930", TPS_SUBSET },	/* fewer LDOs and DACs; no charger */
 	{ "tps65920", TPS_SUBSET },	/* fewer LDOs; no codec or charger */
+	{ "tps65921", TPS_SUBSET },	/* fewer LDOs; no codec, no LED
+					   and vibrator. Charger in USB module*/
 	{ "twl6030", TWL6030_CLASS },	/* "Phoenix power chip" */
 	{ /* end of list */ },
 };
-- 
1.7.4.4

