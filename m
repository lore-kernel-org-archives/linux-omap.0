From: yegorslists@googlemail.com
Subject: [PATCH] arm: increase FORCE_MAX_ZONEORDER for TI AM33XX
Date: Tue, 25 Sep 2012 10:44:04 +0200
Message-ID: <1348562644-14447-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:40903 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744Ab2IYIo1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 04:44:27 -0400
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
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2f88d8d..06d489e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1768,6 +1768,7 @@ source "mm/Kconfig"
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order" if ARCH_SHMOBILE
 	range 11 64 if ARCH_SHMOBILE
+	default "12" if SOC_AM33XX
 	default "9" if SA1111
 	default "11"
 	help
-- 
1.7.7

