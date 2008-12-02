From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 2/2] Make sure omap cpufreq driver initializes after cpufreq framework and governors
Date: Tue,  2 Dec 2008 17:31:17 +0200
Message-ID: <1228231877-18114-3-git-send-email-peter.de-schrijver@nokia.com>
References: <1228231877-18114-1-git-send-email-peter.de-schrijver@nokia.com>
 <1228231877-18114-2-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63468 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606AbYLBPbd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 10:31:33 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mB2FV7mi019105
	for <linux-omap@vger.kernel.org>; Tue, 2 Dec 2008 17:31:30 +0200
In-Reply-To: <1228231877-18114-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/plat-omap/cpu-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 0a7ce46..a4b3392 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -184,7 +184,7 @@ static int __init omap_cpufreq_init(void)
 	return cpufreq_register_driver(&omap_driver);
 }
 
-arch_initcall(omap_cpufreq_init);
+late_initcall(omap_cpufreq_init);
 
 /*
  * if ever we want to remove this, upon cleanup call:
-- 
1.5.6.3

