From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] ARM: OMAP3: Clean up spurious interrupt check logic
Date: Thu, 02 Apr 2009 17:20:40 +0300
Message-ID: <49D4C9B8.10806@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49752 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111AbZDBOVp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Apr 2009 10:21:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

From: Roger Quadros <ext-roger.quadros@nokia.com>
Date: Thu, 2 Apr 2009 16:41:00 +0300
Subject: [PATCH] ARM: OMAP3: Clean up spurious interrupt check logic

SPURIOUSIRQ is contained in bits 31:7 of INTC_SIR, so
INTC_SIR must be right shifted by 7, not 6.

No change in logic, only changes for better readability.
Refer to register definition of INTCPS_SIR_IRQ in OMAP3 Manual.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 2842fe8..296ab86 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -73,9 +73,9 @@ static int omap_check_spurious(unsigned int irq)
 	u32 sir, spurious;
 
 	sir = intc_bank_read_reg(&irq_banks[0], INTC_SIR);
-	spurious = sir >> 6;
+	spurious = sir >> 7;
 
-	if (spurious > 1) {
+	if (spurious) {
 		printk(KERN_WARNING "Spurious irq %i: 0x%08x, please flush "
 					"posted write for irq %i\n",
 					irq, sir, previous_irq);
-- 
1.5.6.5


