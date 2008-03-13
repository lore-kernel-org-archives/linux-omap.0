From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/6] ARM: OMAP1: Fix typo in OMAP1 MPU clock source initialization
Date: Thu, 13 Mar 2008 17:45:19 +0200
Message-ID: <1205423119-22292-7-git-send-email-tony@atomide.com>
References: omap-fixes-2008-03-13
 <1205423119-22292-1-git-send-email-tony@atomide.com>
 <1205423119-22292-2-git-send-email-tony@atomide.com>
 <1205423119-22292-3-git-send-email-tony@atomide.com>
 <1205423119-22292-4-git-send-email-tony@atomide.com>
 <1205423119-22292-5-git-send-email-tony@atomide.com>
 <1205423119-22292-6-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:59333 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612AbYCMPpw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 11:45:52 -0400
In-Reply-To: <1205423119-22292-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Will Newton <will.newton@gmail.com>

From: Will Newton <will.newton@gmail.com>

Fix typo in OMAP1 MPU clock source initialization.

Signed-off-by: Will Newton <will.newton@gmail.com>
---
 arch/arm/mach-omap1/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 572a2db..a4f8b20 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -171,7 +171,7 @@ static void omap_mpu_set_mode(enum clock_event_mode mode,
 
 static struct clock_event_device clockevent_mpu_timer1 = {
 	.name		= "mpu_timer1",
-	.features       = CLOCK_EVT_FEAT_PERIODIC, CLOCK_EVT_FEAT_ONESHOT,
+	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.shift		= 32,
 	.set_next_event	= omap_mpu_set_next_event,
 	.set_mode	= omap_mpu_set_mode,
-- 
1.5.3.6

