From: yegorslists@googlemail.com
Subject: [PATCH v2] arm: make FORCE_MAX_ZONEORDER configurable for TI AM33XX
Date: Tue, 25 Sep 2012 10:26:30 +0200
Message-ID: <1348561590-13361-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:32826 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab2IYI1B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 04:27:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Yegor Yefremov <yegorslists@googlemail.com>, Dejan Gacnik <dejan.gacnik@gmail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

FORCE_MAX_ZONEORDER of 12 is needed to allocation more than 4MB
of consistent DMA memory (da8xx frame buffer driver).

Signed-off-by: Dejan Gacnik <dejan.gacnik@gmail.com>
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
Changes:
	v2: fix SA1111 breakage

 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2f88d8d..b5f242e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1766,8 +1766,8 @@ config HW_PERF_EVENTS
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
-	int "Maximum zone order" if ARCH_SHMOBILE
-	range 11 64 if ARCH_SHMOBILE
+	int "Maximum zone order" if ARCH_SHMOBILE || SOC_AM33XX
+	range 11 64 if ARCH_SHMOBILE || SOC_AM33XX
 	default "9" if SA1111
 	default "11"
 	help
-- 
1.7.7

