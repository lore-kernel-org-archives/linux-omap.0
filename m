From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: do not block sleep patch
Date: Thu, 26 Jun 2008 16:48:10 +0300
Message-ID: <20080626134810.GB4593@gandalf.research.nokia.com>
References: <20080626133255.GA4593@gandalf.research.nokia.com> <20080626133837.GH12992@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="z6Eq5LdranGa6ru8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49135 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758388AbYFZNtH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 09:49:07 -0400
Content-Disposition: inline
In-Reply-To: <20080626133837.GH12992@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2008 at 04:38:38PM +0300, Tony Lindgren wrote:
> Did you mean to remove omap2_allow_sleep() instead of clk_disable()?

Crap... yeah.. sorry, attached is new patch.

-- 
	- Balbi

--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="0001-ARCH-OMAP-MUSB-Do-not-block-sleep.diff"
Content-Transfer-Encoding: 8bit

>From d096d1c215e4c519d77ba27035ea4c57fb793362 Mon Sep 17 00:00:00 2001
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
index cbd59f8..bd3556b 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -58,7 +58,6 @@ static int musb_set_clock(struct clk *clk, int state)
 		if (clk_on > 0)
 			return -ENODEV;
 
-		omap2_block_sleep();
 		clk_enable(clk);
 		clk_on = 1;
 	} else {
@@ -67,7 +66,6 @@ static int musb_set_clock(struct clk *clk, int state)
 
 		clk_disable(clk);
 		clk_on = 0;
-		omap2_allow_sleep();
 	}
 
 	return 0;
-- 
1.5.6.49.g112db


--z6Eq5LdranGa6ru8--
