From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 03/04] PM counters: fix initialization race condition
Date: Wed, 29 Oct 2008 13:31:23 +0200
Message-ID: <1225279884-30668-4-git-send-email-tero.kristo@nokia.com>
References: <>
 <1225279884-30668-1-git-send-email-tero.kristo@nokia.com>
 <1225279884-30668-2-git-send-email-tero.kristo@nokia.com>
 <1225279884-30668-3-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:41718 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbYJ2JsF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 05:48:05 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9T9loVR028124
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 04:48:02 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m9T9lc6W021465
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 11:47:43 +0200
In-Reply-To: <1225279884-30668-3-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clockdomain.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index b0b5885..b27afc0 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -481,6 +481,8 @@ void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
 			    v << __ffs(clkdm->clktrctrl_mask),
 			    clkdm->pwrdm.ptr->prcm_offs,
 			    CM_CLKSTCTRL);
+
+	pwrdm_clkdm_state_switch(clkdm);
 }
 
 /**
-- 
1.5.4.3

