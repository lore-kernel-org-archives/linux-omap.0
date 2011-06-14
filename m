From: green@linuxhacker.ru
Subject: [PATCH 2/3] Add tps65921 chip
Date: Tue, 14 Jun 2011 11:45:06 -0400
Message-ID: <1308066307-415-3-git-send-email-green@linuxhacker.ru>
References: <1308066307-415-1-git-send-email-green@linuxhacker.ru>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from c-71-228-165-73.hsd1.tn.comcast.net ([71.228.165.73]:38572 "EHLO
	fatbox1.localnet" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753323Ab1FNPqf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 11:46:35 -0400
In-Reply-To: <1308066307-415-1-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Oleg Drokin <green@linuxhacker.ru>, sameo@linux.intel.com

From: Oleg Drokin <green@linuxhacker.ru>

Very similar to TPS65920
List of differences: http://www.ti.com/litv/pdf/swcu066b

CC: sameo@linux.intel.com
Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
 drivers/mfd/twl-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index b8f2a4e..756f3eb 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1284,6 +1284,8 @@ static const struct i2c_device_id twl_ids[] = {
 	{ "tps65950", 0 },		/* catalog version of twl5030 */
 	{ "tps65930", TPS_SUBSET },	/* fewer LDOs and DACs; no charger */
 	{ "tps65920", TPS_SUBSET },	/* fewer LDOs; no codec or charger */
+	{ "tps65921", TPS_SUBSET },	/* fewer LDOs; no codec, no LED
+					   and vibrator. Charger in USB module*/
 	{ "twl6030", TWL6030_CLASS },	/* "Phoenix power chip" */
 	{ "twl6025", TWL6030_CLASS | TWL6025_SUBCLASS }, /* "Phoenix lite" */
 	{ /* end of list */ },
-- 
1.7.4.4

