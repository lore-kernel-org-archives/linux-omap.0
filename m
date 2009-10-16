From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 10/17] OMAP3: PM: Enable system control module autoidle
Date: Fri, 16 Oct 2009 13:49:03 +0300
Message-ID: <1255690150-16853-11-git-send-email-tero.kristo@nokia.com>
References: <>
 <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-10-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32286 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758223AbZJPLEc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 07:04:32 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB31Q9012142
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:03:03 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB2fa4022261
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:02:54 +0300
In-Reply-To: <1255690150-16853-10-git-send-email-tero.kristo@nokia.com>
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
index 6a41811..47f5738 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1039,6 +1039,8 @@ static void __init prcm_setup_regs(void)
 			CM_AUTOIDLE);
 	}
 
+	omap_ctrl_writel(OMAP3430_AUTOIDLE, OMAP2_CONTROL_SYSCONFIG);
+
 	/*
 	 * Set all plls to autoidle. This is needed until autoidle is
 	 * enabled by clockfw
-- 
1.5.4.3

