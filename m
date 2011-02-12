From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/5] omap2plus: omap4: Set NR_CPU to 2 instead of default 4
Date: Sat, 12 Feb 2011 16:59:46 +0530
Message-ID: <1297510187-31547-5-git-send-email-santosh.shilimkar@ti.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46374 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988Ab1BLL36 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Feb 2011 06:29:58 -0500
In-Reply-To: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

The omap2plus_defconfig picks default NR_CPU value as 4 which isn't
correct for OMAP4430. Available CPUs are ony 2, so fix the same.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index ae890ca..019fb7c 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -58,6 +58,7 @@ CONFIG_ARM_ERRATA_411920=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_SMP=y
+CONFIG_NR_CPUS=2
 # CONFIG_LOCAL_TIMERS is not set
 CONFIG_AEABI=y
 CONFIG_LEDS=y
-- 
1.6.0.4

