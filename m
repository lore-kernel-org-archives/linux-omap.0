From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 14/14] OMAP2PLUS: Enable various options in defconfig
Date: Fri, 29 Oct 2010 21:08:28 +0530
Message-ID: <1288366708-32302-15-git-send-email-thara@ti.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34626 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934034Ab0J2Pip (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Oct 2010 11:38:45 -0400
In-Reply-To: <1288366708-32302-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

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

