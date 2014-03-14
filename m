From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: OMAP2+: hwmod: fix missing braces in _init()
Date: Fri, 14 Mar 2014 14:45:17 +0530
Message-ID: <1394788517-15014-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43442 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755497AbaCNJQh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Mar 2014 05:16:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, tony@atomide.com, Suman Anna <s-anna@ti.com>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>

From: Suman Anna <s-anna@ti.com>

Bug was introduced by commit 'f92d959: ARM: OMAP2+: hwmod:
Extract no-idle and no-reset info from DT'

There were 2 versions of the patch posted which resulted in the above
commit. While v1 [1] had the bug, v2 [2] had it fixed.
However v1 apparently seemed to have been pulled in by mistake
introducing the bug.

Given of_find_property() does return NULL when the node passed is
NULL, it did not introduce any functional issues as such, just the
fact that the second if check was executed unnecessarily.

[1] https://www.mail-archive.com/linux-omap@vger.kernel.org/msg94220.html
[2] http://www.spinics.net/lists/linux-omap/msg98490.html

Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 1f33f5d..66c60fe 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2546,11 +2546,12 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 		return -EINVAL;
 	}
 
-	if (np)
+	if (np) {
 		if (of_find_property(np, "ti,no-reset-on-init", NULL))
 			oh->flags |= HWMOD_INIT_NO_RESET;
 		if (of_find_property(np, "ti,no-idle-on-init", NULL))
 			oh->flags |= HWMOD_INIT_NO_IDLE;
+	}
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
 
-- 
1.7.9.5

