From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] ARM: OMAP2: add type cast from 'unsigned' to 'signed'
Date: Wed, 21 Aug 2013 16:26:28 +0800
Message-ID: <521479B4.8030604@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:63031 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab3HUI1a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Aug 2013 04:27:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Need add type cast, or can not notice the failure. The related warning
(allmodconfig, "EXTRA_CFLAGS=-W"):

  arch/arm/mach-omap2/gpmc.c:728:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-omap2/gpmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index f3fdd6a..62377b5 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -725,7 +725,7 @@ static int gpmc_setup_irq(void)
 		return -EINVAL;
 
 	gpmc_irq_start = irq_alloc_descs(-1, 0, GPMC_NR_IRQ, 0);
-	if (gpmc_irq_start < 0) {
+	if ((signed)gpmc_irq_start < 0) {
 		pr_err("irq_alloc_descs failed\n");
 		return gpmc_irq_start;
 	}
-- 
1.7.7.6
