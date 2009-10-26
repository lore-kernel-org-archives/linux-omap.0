From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 2/2] OMAP3: CPUidle: Fixed timer resolution
Date: Mon, 26 Oct 2009 15:10:40 +0200
Message-ID: <1256562640-15242-3-git-send-email-tero.kristo@nokia.com>
References: <>
 <1256562640-15242-1-git-send-email-tero.kristo@nokia.com>
 <1256562640-15242-2-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:39968 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698AbZJZNZ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 09:25:56 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9QDPjhL006232
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 15:25:59 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9QDPWI3028570
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 15:25:35 +0200
In-Reply-To: <1256562640-15242-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Previously used u32 as temporary data storage that wraps around at 4.294s.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index a0d9f56..0ac3b63 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -137,7 +137,7 @@ return_sleep_time:
 	local_irq_enable();
 	local_fiq_enable();
 
-	return (u32)timespec_to_ns(&ts_idle)/1000;
+	return ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * USEC_PER_SEC;
 }
 
 /**
-- 
1.5.4.3

