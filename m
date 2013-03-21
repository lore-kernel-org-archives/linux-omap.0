From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 7/8] clk: use strncmp for matching con_id in clk_find
Date: Thu, 21 Mar 2013 19:35:46 +0200
Message-ID: <1363887347-4686-8-git-send-email-t-kristo@ti.com>
References: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45274 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab3CURhB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Mar 2013 13:37:01 -0400
In-Reply-To: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, khilman@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>

As clkdev register forces the con_id length down to a maximum of 15
characters and terminating null, replace the internal implementation
of clk_find to use strncmp instead of strcmp. This makes sure that
if a user registers a clkdev with con_id name which gets trimmed,
the same string used in the clk_lookup will still succeed despite
this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/clkdev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 442a313..05b01a1 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -120,7 +120,7 @@ static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
 			match += 2;
 		}
 		if (p->con_id) {
-			if (!con_id || strcmp(p->con_id, con_id))
+			if (!con_id || strncmp(p->con_id, con_id, 15))
 				continue;
 			match += 1;
 		}
-- 
1.7.4.1

