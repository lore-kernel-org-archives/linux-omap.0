From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 05/11] OMAP3: PM: Enable system control module autoidle
Date: Fri, 23 Oct 2009 19:03:49 +0300
Message-ID: <1256313835-2391-6-git-send-email-tero.kristo@nokia.com>
References: <>
 <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-4-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-5-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21518 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbZJWQSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 12:18:47 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIc8s001696
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:18:49 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIPi9022176
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:18:31 +0300
In-Reply-To: <1256313835-2391-5-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

This saves some power.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 53544d3..492458e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -900,6 +900,8 @@ static void __init prcm_setup_regs(void)
 			CM_AUTOIDLE);
 	}
 
+	omap_ctrl_writel(OMAP3430_AUTOIDLE, OMAP2_CONTROL_SYSCONFIG);
+
 	/*
 	 * Set all plls to autoidle. This is needed until autoidle is
 	 * enabled by clockfw
-- 
1.5.4.3

