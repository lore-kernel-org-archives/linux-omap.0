From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: do not block sleep patch
Date: Thu, 26 Jun 2008 16:32:55 +0300
Message-ID: <20080626133255.GA4593@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46850 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbYFZNd4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 09:33:56 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi all,

Resending the patch as it didn't get applied.

Searching on the archives would be painful :-p

-- 
	- Balbi

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="0001-ARCH-OMAP-MUSB-Do-not-block-sleep.diff"
Content-Transfer-Encoding: 8bit

>From d8f7f708e32ad7daadf9e48e7ba0ebecdf91094c Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Thu, 26 Jun 2008 16:31:44 +0300
Subject: [PATCH] ARCH: OMAP: MUSB: Do not block sleep
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Do not block sleep while musb clock is enabled
as it completely blocks dynamic sleep.

Thanks to Jouni Högander.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Jouni Högander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/usb-musb.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index cbd59f8..d495549 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -58,14 +58,12 @@ static int musb_set_clock(struct clk *clk, int state)
 		if (clk_on > 0)
 			return -ENODEV;
 
-		omap2_block_sleep();
 		clk_enable(clk);
 		clk_on = 1;
 	} else {
 		if (clk_on == 0)
 			return -ENODEV;
 
-		clk_disable(clk);
 		clk_on = 0;
 		omap2_allow_sleep();
 	}
-- 
1.5.6.49.g112db


--9amGYk9869ThD9tj--
