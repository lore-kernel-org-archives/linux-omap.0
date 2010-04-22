From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv3 02/11] mfd: Add comments for the twl4030-power register and bit layout
Date: Thu, 22 Apr 2010 11:07:34 +0300
Message-ID: <1271923663-23668-3-git-send-email-eduardo.valentin@nokia.com>
References: <1271923663-23668-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23725 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab0DVIJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 04:09:02 -0400
In-Reply-To: <1271923663-23668-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Core-Review <core-review@ok.research.nokia.com>
Cc: "\\\"Hogander Jouni (Nokia-D/Tampere)\\\"" <jouni.hogander@nokia.com>, "\\\"Koskinen Aaro (Nokia-D/Helsinki)\\\"" <aaro.koskinen@nokia.com>, Amit Kucheria <amit.kucheria@verdurent.com>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

From: Amit Kucheria <amit.kucheria@verdurent.com>

Describe how the resource registers are laid out and the various bit-fields in
them.

Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/twl4030-power.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 8f82e22..2bec947 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -72,14 +72,22 @@ static u8 twl4030_start_script_address = 0x2b;
 #define R_KEY_1			0xC0
 #define R_KEY_2			0x0C
 
-/* resource configuration registers */
-
+/* resource configuration registers
+   <RESOURCE>_DEV_GRP   at address 'n+0'
+   <RESOURCE>_TYPE      at address 'n+1'
+   <RESOURCE>_REMAP     at address 'n+2'
+   <RESOURCE>_DEDICATED at address 'n+3'
+*/
 #define DEV_GRP_OFFSET		0
 #define TYPE_OFFSET		1
 
 /* Bit positions in the registers */
+
+/* <RESOURCE>_DEV_GRP */
 #define DEV_GRP_SHIFT		5
 #define DEV_GRP_MASK		(7 << DEV_GRP_SHIFT)
+
+/* <RESOURCE>_TYPE */
 #define TYPE_SHIFT		0
 #define TYPE_MASK		(7 << TYPE_SHIFT)
 #define TYPE2_SHIFT		3
-- 
1.7.0.4.361.g8b5fe.dirty

