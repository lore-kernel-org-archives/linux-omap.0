From: Tomas Novotny <tomas@novotny.cz>
Subject: [PATCH] mfd: twl-core: Fix accessibility of some twl4030 audio
 registers
Date: Mon, 10 Mar 2014 19:12:50 +0100
Message-ID: <20140310191250.34f1410e@tomas.local.tbs-biometrics.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kazi.fit.vutbr.cz ([147.229.8.12]:18295 "EHLO kazi.fit.vutbr.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbaCJSXX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Mar 2014 14:23:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com

There are some unused registers in twl4030 at I2C address 0x49 and function
twl4030_49_nop_reg() is used to check accessibility of that registers. These
registers are written in decimal format but the values are correct in
hexadecimal format. (It can be checked few lines above the patched code -
these registers are marked as unused there.)

As a consequence three registers of audio submodule are treated as
inaccessible (preamplifier carkit right and both handsfree registers).

CC: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tomas Novotny <tomas@novotny.cz>
---
 drivers/mfd/twl-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index ed71832..e87140b 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -282,11 +282,11 @@ static struct reg_default twl4030_49_defaults[] = {
 static bool twl4030_49_nop_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case 0:
-	case 3:
-	case 40:
-	case 41:
-	case 42:
+	case 0x00:
+	case 0x03:
+	case 0x40:
+	case 0x41:
+	case 0x42:
 		return false;
 	default:
 		return true;
-- 
1.8.4.5

