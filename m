From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/18] can:ti_hecc: Enable CAN support on AM3517
Date: Wed, 05 May 2010 12:33:00 -0700
Message-ID: <20100505193300.21568.71805.stgit@baageli.muru.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49629 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab0EETdC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 15:33:02 -0400
In-Reply-To: <20100505192957.21568.19569.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sriramakrishnan <srk@ti.com>, linux-omap@vger.kernel.org

From: Sriram <srk@ti.com>

Modify the default kernel configuration on AM3517 to enable CAN.

Signed-off-by: Sriramakrishnan <srk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/am3517_evm_defconfig |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/am3517_evm_defconfig b/arch/arm/configs/am3517_evm_defconfig
index 66a10b5..c151d6e 100644
--- a/arch/arm/configs/am3517_evm_defconfig
+++ b/arch/arm/configs/am3517_evm_defconfig
@@ -422,15 +422,29 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
-# CONFIG_CAN is not set
+CONFIG_CAN=y
+CONFIG_CAN_RAW=y
+CONFIG_CAN_BCM=y
+
+#
+# CAN Device Drivers
+#
+CONFIG_CAN_VCAN=y
+CONFIG_CAN_DEV=y
+CONFIG_CAN_CALC_BITTIMING=y
+CONFIG_CAN_TI_HECC=y
+# CONFIG_CAN_SJA1000 is not set
+
+#
+# CAN USB interfaces
+#
+# CONFIG_CAN_EMS_USB is not set
+CONFIG_CAN_DEBUG_DEVICES=y
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
 CONFIG_WIRELESS=y
 # CONFIG_CFG80211 is not set
-CONFIG_CFG80211_DEFAULT_PS_VALUE=0
-# CONFIG_WIRELESS_OLD_REGULATORY is not set
-# CONFIG_WIRELESS_EXT is not set
 # CONFIG_LIB80211 is not set
 
 #

