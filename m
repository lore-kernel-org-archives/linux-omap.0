From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/7] OMAP1: clock: Typo fix for clock in omap1
Date: Tue, 14 Apr 2009 12:23:31 -0600
Message-ID: <20090414182330.22344.1253.stgit@localhost.localdomain>
References: <20090414182039.22344.49790.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45721 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755986AbZDNS1O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 14:27:14 -0400
In-Reply-To: <20090414182039.22344.49790.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Arun KS <arunks@mistralsolutions.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

From: Arun KS <arunks@mistralsolutions.com>

Typo error when requesting for clock for dsp in omap1

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/mcbsp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index d040c3f..a2d7814 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -40,8 +40,8 @@ static void omap1_mcbsp_request(unsigned int id)
 	 */
 	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3) {
 		if (dsp_use++ == 0) {
-			api_clk = clk_get(NULL, "api_clk");
-			dsp_clk = clk_get(NULL, "dsp_clk");
+			api_clk = clk_get(NULL, "api_ck");
+			dsp_clk = clk_get(NULL, "dsp_ck");
 			if (!IS_ERR(api_clk) && !IS_ERR(dsp_clk)) {
 				clk_enable(api_clk);
 				clk_enable(dsp_clk);


