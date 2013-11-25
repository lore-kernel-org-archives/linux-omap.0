From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH] ARM: configs: OMAP2+: Enable PREEMPT and crypto USER API config
Date: Mon, 25 Nov 2013 10:47:07 -0600
Message-ID: <1385398027-18137-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55231 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754708Ab3KYQrW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 11:47:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, rnayak@ti.com, Joel Fernandes <joelf@ti.com>

Enable PREEMPT config option as some in-kernel tests such as tcrypt produce RCU
sched stalls when the test is running.  Also enable options for crypto AF_ALG
users so that OpenSSL can uses the crypto HW accel drivers.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 254cf05..b6f39f6 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -295,6 +295,8 @@ CONFIG_DEBUG_INFO=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_MICHAEL_MIC=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_CRYPTO_USER_API_SKCIPHER=y
 CONFIG_CRC_CCITT=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRC_ITU_T=y
@@ -306,3 +308,4 @@ CONFIG_TI_DAVINCI_CPDMA=y
 CONFIG_TI_CPSW=y
 CONFIG_AT803X_PHY=y
 CONFIG_SOC_DRA7XX=y
+CONFIG_PREEMPT=y
-- 
1.8.1.2

