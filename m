From: Christoph Egger <siccegge@cs.fau.de>
Subject: [PATCH 18/33] Removing dead OMAP_ARM_96MHZ
Date: Wed, 30 Jun 2010 17:59:45 +0200
Message-ID: <8304abb0dbda307c488b6fe2b3cc8df3c9909eb6.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:39898 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755696Ab0F3P7r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jun 2010 11:59:47 -0400
Content-Disposition: inline
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel
Cc: vamos@i4.informatik.uni-erlangen.de

OMAP_ARM_96MHZ doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/mach-omap1/opp_data.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/opp_data.c b/arch/arm/mach-omap1/opp_data.c
index 75a5465..060df86 100644
--- a/arch/arm/mach-omap1/opp_data.c
+++ b/arch/arm/mach-omap1/opp_data.c
@@ -45,9 +45,6 @@ struct mpu_rate omap1_rate_table[] = {
 #if defined(CONFIG_OMAP_ARM_120MHZ)
 	{ 120000000, 12000000, 120000000, 0x010a, 0x2510 }, /* 1/1/1/2/4/4 */
 #endif
-#if defined(CONFIG_OMAP_ARM_96MHZ)
-	{  96000000, 12000000,  96000000, 0x0005, 0x2410 }, /* 1/1/1/1/2/2 */
-#endif
 #if defined(CONFIG_OMAP_ARM_60MHZ)
 	{  60000000, 12000000,  60000000, 0x0005, 0x2290 }, /* 1/1/1/1/2/2 */
 #endif
-- 
1.7.0.4

