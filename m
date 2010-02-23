From: Sriramakrishnan <srk@ti.com>
Subject: [PATCH 1/2] can:ti_hecc: Enable CAN support on AM3517.
Date: Tue, 23 Feb 2010 12:07:47 +0530
Message-ID: <1266907068-6210-2-git-send-email-srk@ti.com>
References: <1266907068-6210-1-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60984 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab0BWGhz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 01:37:55 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1N6bpXq002731
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 23 Feb 2010 00:37:54 -0600
In-Reply-To: <1266907068-6210-1-git-send-email-srk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: anantgole@ti.com, Sriramakrishnan <srk@ti.com>

Modify the default kernel configuration on AM3517 to enable CAN.

Signed-off-by: Sriramakrishnan <srk@ti.com>
Acked-by: Anant Gole <anantgole@ti.com>
---
 arch/arm/configs/am3517_evm_defconfig |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/am3517_evm_defconfig b/arch/arm/configs/am3517_evm_defconfig
index abe9966..d5e15ba 100644
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
-- 
1.6.2.4

