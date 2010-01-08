From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 06/13] OMAP3: CPUidle: Fixed timer resolution
Date: Fri,  8 Jan 2010 09:59:24 -0800
Message-ID: <1262973571-25796-7-git-send-email-khilman@deeprootsystems.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-3-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-4-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-5-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-6-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:51031 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab0AHR7q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:59:46 -0500
Received: by mail-px0-f174.google.com with SMTP id 4so2222956pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 09:59:45 -0800 (PST)
In-Reply-To: <1262973571-25796-6-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Previously used u32 as temporary data storage that wraps around at 4.294s.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index a26d6a0..12f0cbf 100644
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
1.6.6.rc2.1.g42108

