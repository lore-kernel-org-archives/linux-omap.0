From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] ARM: OMAP: fix uninitialized warning
Date: Thu,  9 Oct 2008 14:38:00 +0300
Message-ID: <1223552280-14373-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17765 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667AbYJILiS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 07:38:18 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m99BcERm006813
	for <linux-omap@vger.kernel.org>; Thu, 9 Oct 2008 14:38:16 +0300
Received: from oreo.research.nokia.com (esdhcp04066.research.nokia.com [172.21.40.66])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m99Bc1G1019688
	for <linux-omap@vger.kernel.org>; Thu, 9 Oct 2008 14:38:01 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

warning: 'rev_name' may be used uninitialized in this function

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/id.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 7a7ad18..c002076 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -147,7 +147,7 @@ void __init omap34xx_check_revision(void)
 	u32 cpuid, idcode;
 	u16 hawkeye;
 	u8 rev;
-	char *rev_name;
+	char *rev_name = "ES1.0";
 
 	/*
 	 * We cannot access revision registers on ES1.0.
@@ -157,7 +157,6 @@ void __init omap34xx_check_revision(void)
 	cpuid = read_cpuid(CPUID_ID);
 	if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) == 0x0)) {
 		system_rev = OMAP3430_REV_ES1_0;
-		rev_name = "ES1.0";
 		goto out;
 	}
 
-- 
1.6.0.2.229.g1293c

