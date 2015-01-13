From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/7] ARM: OMAP2+: Fix error handling for omap2_clk_enable_init_clocks
Date: Tue, 13 Jan 2015 15:13:52 -0800
Message-ID: <1421190837-4692-3-git-send-email-tony@atomide.com>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29120 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751691AbbAMXRy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 18:17:54 -0500
In-Reply-To: <1421190837-4692-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>

We need to check if we got the clock before trying to do anything
with it. Otherwise we will get something like this:

Unable to handle kernel paging request at virtual address fffffffe
...
[<c04bef78>] (clk_prepare) from [<c00338a4>] (omap2_clk_enable_init_clocks+0x50/0x8)
[<c00338a4>] (omap2_clk_enable_init_clocks) from [<c0876838>] (dm816x_dt_clk_init+0)
...

Let's add check for the clock and WARN if the init clock was not
found.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 6ad5b4d..89a0732 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -620,6 +620,11 @@ void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
 
 	for (i = 0; i < num_clocks; i++) {
 		init_clk = clk_get(NULL, clk_names[i]);
+		if (IS_ERR(init_clk)) {
+			WARN(1, "omap clock: could not find init clock %s\n",
+			     clk_names[i]);
+			continue;
+		}
 		clk_prepare_enable(init_clk);
 	}
 }
-- 
2.1.4

