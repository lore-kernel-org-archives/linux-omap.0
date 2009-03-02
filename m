From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH] OMAP3: PM: Update correct ONLP/RET values
Date: Mon, 2 Mar 2009 13:01:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAD03A7B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42425 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbZCBHbU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 02:31:20 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n227VCC4021896
	for <linux-omap@vger.kernel.org>; Mon, 2 Mar 2009 01:31:18 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n227VBeO005927
	for <linux-omap@vger.kernel.org>; Mon, 2 Mar 2009 13:01:11 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Populates the correct ONLP/RET cmd values for VDD1 and VDD2.
Also removes the unneccesary bitshift logic.
Applies on the latest pm branch, validated on a 3430SDP.

0x30 = 1.2V
0x1E = .975V
0x2C = 1.15V

Formula used to calulate the hex values
Value(in decimals)*12.5 + 600 mV.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2009-03-02 11:42:13.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2009-03-02 12:07:19.653034656 +0530
@@ -1036,16 +1036,16 @@ err2:
 }
 
 /* PRM_VC_CMD_VAL_0 specific bits */
-#define OMAP3430_VC_CMD_VAL0_ON				(0x3 << 4)
-#define OMAP3430_VC_CMD_VAL0_ONLP			(0xf << 3)
-#define OMAP3430_VC_CMD_VAL0_RET			(0xf << 3)
-#define OMAP3430_VC_CMD_VAL0_OFF			(0x3 << 4)
+#define OMAP3430_VC_CMD_VAL0_ON		0x30
+#define OMAP3430_VC_CMD_VAL0_ONLP	0x1E
+#define OMAP3430_VC_CMD_VAL0_RET	0x1E
+#define OMAP3430_VC_CMD_VAL0_OFF	0x30
 
 /* PRM_VC_CMD_VAL_1 specific bits */
-#define OMAP3430_VC_CMD_VAL1_ON				(0xB << 2)
-#define OMAP3430_VC_CMD_VAL1_ONLP			(0xf << 3)
-#define OMAP3430_VC_CMD_VAL1_RET			(0xf << 3)
-#define OMAP3430_VC_CMD_VAL1_OFF			(0xB << 2)
+#define OMAP3430_VC_CMD_VAL1_ON		0x2C
+#define OMAP3430_VC_CMD_VAL1_ONLP	0x1E
+#define OMAP3430_VC_CMD_VAL1_RET	0x1E
+#define OMAP3430_VC_CMD_VAL1_OFF	0x2C
 
 static void __init configure_vc(void)
 {