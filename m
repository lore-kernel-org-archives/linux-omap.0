From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH v2] ARM: configs: OMAP2+: Enable PREEMPT and crypto USER API config
Date: Mon, 25 Nov 2013 11:05:18 -0600
Message-ID: <1385399118-13632-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36657 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756758Ab3KYRF2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 12:05:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, rnayak@ti.com, Joel Fernandes <joelf@ti.com>

Enable PREEMPT config option as some in-kernel tests such as tcrypt produce RCU
sched stalls when the test is running.  Also enable options for crypto AF_ALG
users so that OpenSSL can uses the crypto HW accel drivers.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
Previous version was based on 3.12, in the v2- rebased now on 3.13-rc1. thanks

 arch/arm/configs/omap2plus_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 98a50c3..044dc04 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -283,6 +283,8 @@ CONFIG_PROVE_LOCKING=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_MICHAEL_MIC=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_CRYPTO_USER_API_SKCIPHER=y
 CONFIG_CRC_CCITT=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRC_ITU_T=y
@@ -291,3 +293,4 @@ CONFIG_LIBCRC32C=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
+CONFIG_PREEMPT=y
-- 
1.8.1.2

