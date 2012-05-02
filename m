From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH v3 09/10] omap2plus: Add support for omap4iss camera
Date: Wed,  2 May 2012 10:15:48 -0500
Message-ID: <1335971749-21258-10-git-send-email-saaguirre@ti.com>
References: <1335971749-21258-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:57090 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754573Ab2EBPQ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 11:16:27 -0400
Received: by obbwd20 with SMTP id wd20so1445924obb.32
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 08:16:26 -0700 (PDT)
In-Reply-To: <1335971749-21258-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

Also add support for following sensors:
- OV5640
- OV5650

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index d5f00d7..ea7e8e9 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -23,6 +23,8 @@ CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_ARCH_OMAP=y
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_MUX_DEBUG=y
+CONFIG_MACH_OMAP_4430SDP_CAMERA_SUPPORT=y
+CONFIG_MACH_OMAP4_PANDA_CAMERA_SUPPORT=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_411920=y
 CONFIG_NO_HZ=y
-- 
1.7.5.4

