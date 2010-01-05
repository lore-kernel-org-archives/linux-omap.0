From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/10] OMAP powerdomain: remove pwrdm_clk_state_switch
Date: Tue, 05 Jan 2010 15:55:03 -0700
Message-ID: <20100105225502.16474.80466.stgit@localhost.localdomain>
References: <20100105225217.16474.44114.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49861 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab0AEW6Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 17:58:24 -0500
In-Reply-To: <20100105225217.16474.44114.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

Nothing calls pwrdm_clk_state_switch(), and the function that seems to be
its ideal use case calls pwrdm_clkdm_state_switch(clk->clkdm), so remove it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/powerdomain.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index df6446a..9d4b8f5 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -928,12 +928,6 @@ int pwrdm_clkdm_state_switch(struct clockdomain *clkdm)
 
 	return -EINVAL;
 }
-int pwrdm_clk_state_switch(struct clk *clk)
-{
-	if (clk != NULL && clk->clkdm != NULL)
-		return pwrdm_clkdm_state_switch(clk->clkdm);
-	return -EINVAL;
-}
 
 int pwrdm_pre_transition(void)
 {


