From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 16/22] OMAP4 clock: Support clk_set_parent
Date: Tue, 18 May 2010 20:18:56 -0600
Message-ID: <20100519021855.19716.35361.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39817 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882Ab0ESCVF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 22:21:05 -0400
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Remove the hack put in place while clock framework was still not in
place for OMAP4.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/clock.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index c9cd98a..7190cbd 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -138,11 +138,6 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	unsigned long flags;
 	int ret = -EINVAL;
 
-	if (cpu_is_omap44xx()) {
-		WARN(1, "clock: %s: not supported yet on OMAP4\n", __func__);
-		return 0;
-	}
-
 	if (clk == NULL || IS_ERR(clk) || parent == NULL || IS_ERR(parent))
 		return ret;
 


