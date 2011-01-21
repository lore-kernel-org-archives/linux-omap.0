From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 12/13] OMAP2PLUS: Enable various options in defconfig
Date: Fri, 21 Jan 2011 19:31:04 +0530
Message-ID: <1295618465-15234-13-git-send-email-vishwanath.bs@ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52509 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733Ab1AUN5r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 08:57:47 -0500
In-Reply-To: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: patches@linaro.org, Thara Gopinath <thara@ti.com>

From: Thara Gopinath <thara@ti.com>

This patch enables Smartreflex and Cpu Freq in the
omap2plus defconfig.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index ccedde1..b7888ae 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -291,3 +291,7 @@ CONFIG_CRC_T10DIF=y
 CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
 CONFIG_LIBCRC32C=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_OMAP_SMARTREFLEX=y
+CONFIG_OMAP_SMARTREFLEX_CLASS3=y
-- 
1.7.0.4

