From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 3/3] omap mailbox: print hardware revision
Date: Sat, 22 Nov 2008 02:28:37 +0200
Message-ID: <1227313717-26399-3-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1227313717-26399-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1227313717-26399-2-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30894 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbYKVA2z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 19:28:55 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAM0Sjrj001764
	for <linux-omap@vger.kernel.org>; Fri, 21 Nov 2008 18:28:53 -0600
Received: from oreo.research.nokia.com (esdhcp04130.research.nokia.com [172.21.41.30])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mAM0SbH1009800
	for <linux-omap@vger.kernel.org>; Sat, 22 Nov 2008 02:28:38 +0200
In-Reply-To: <1227313717-26399-2-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/mailbox.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index ce39aa1..3daa406 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -74,6 +74,9 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 	}
 	clk_enable(mbox_ick_handle);
 
+	l = mbox_read_reg(MAILBOX_REVISION);
+	pr_info("omap mailbox rev %x\n", l);
+
 	/* set smart-idle & autoidle */
 	l = mbox_read_reg(MAILBOX_SYSCONFIG);
 	l |= 0x00000011;
-- 
1.6.0.3.613.g9f8f13

