From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [omapzoom][PATCH 3/4] DSPBRIDGE: Mapping sidetone registers
Date: Thu, 20 Nov 2008 03:12:03 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F1A398EE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60476 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbYKTJMO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 04:12:14 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hari Kanigeri <h-kanigeri2@ti.com>
Date: Mon, 17 Nov 2008 16:20:06 -0600
Subject: [PATCH] DSPBRIDGE: Mapping sidetone registers

New 3430 HW feature integrated into McBSP2
and McBSP3, enabling a sidetone process, for DASF.
Bridge has to handle this new configuration.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/wmd/_tiomap.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index ed1bff9..5267eb2 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -161,6 +161,11 @@ struct MAP_L4PERIPHERAL {
 #define PM_GRPSEL_BASE 			0x48307000
 #define DSPVA_GRPSEL_BASE 		0x11821000
 
+#define L4_PERIPHERAL_SIDETONE_MCBSP2        0x49028000
+#define DSPVA_PERIPHERAL_SIDETONE_MCBSP2 0x11824000
+#define L4_PERIPHERAL_SIDETONE_MCBSP3        0x4902a000
+#define DSPVA_PERIPHERAL_SIDETONE_MCBSP3 0x11825000
+
 /* define a static array with L4 mappings */
 static const struct MAP_L4PERIPHERAL L4PeripheralTable[] = {
 	{L4_PERIPHERAL_MBOX, DSPVA_PERIPHERAL_MBOX},
@@ -196,6 +201,8 @@ static const struct MAP_L4PERIPHERAL L4PeripheralTable[] = {
 	{L4_PERIPHERAL_CM, DSPVA_PERIPHERAL_CM},
 	{L4_PERIPHERAL_PER, DSPVA_PERIPHERAL_PER},
 	{PM_GRPSEL_BASE, DSPVA_GRPSEL_BASE},
+	{L4_PERIPHERAL_SIDETONE_MCBSP2, DSPVA_PERIPHERAL_SIDETONE_MCBSP2},
+	{L4_PERIPHERAL_SIDETONE_MCBSP3, DSPVA_PERIPHERAL_SIDETONE_MCBSP3},
 	{L4_PERIPHERAL_NULL, DSPVA_PERIPHERAL_NULL}
 };
 
-- 
1.6.0

