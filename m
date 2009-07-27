From: talvala@stanford.edu
Subject: [PATCH] OMAP3: EVM: Remove TWL4030 USB Transceiver Driver from defconfig
Date: Mon, 27 Jul 2009 16:10:59 -0700
Message-ID: <1248736259-3392-1-git-send-email-talvala@stanford.edu>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.Stanford.EDU ([171.67.219.85]:53774 "EHLO
	smtp5.stanford.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbZG0XK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jul 2009 19:10:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eino-Ville Talvala <talvala@stanford.edu>

From: Eino-Ville Talvala <talvala@stanford.edu>

Intended to be applied on top of Ajay Gupta's MUSB cleanup patch:
'musb: cleanup the nop registration for OMAP3EVM' from 7/3/2009.

The OMAP3 EVM defconfig compiles in the TWL4030 USB transceiver driver, 
which conflicts with registering the NOP transceiver.  Remove the 
unneeded TWL4030 driver from defconfig.

Signed-off-by: Eino-Ville Talvala <talvala@stanford.edu>
---
 arch/arm/configs/omap3_evm_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index 28be17f..0ea8bd7 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -1107,7 +1107,7 @@ CONFIG_USB_ZERO=m
 CONFIG_USB_OTG_UTILS=y
 # CONFIG_USB_GPIO_VBUS is not set
 # CONFIG_ISP1301_OMAP is not set
-CONFIG_TWL4030_USB=y
+CONFIG_TWL4030_USB=n
 # CONFIG_NOP_USB_XCEIV is not set
 CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
-- 
1.5.4.3

