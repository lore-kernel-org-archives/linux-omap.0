From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/11] ARM: OMAP3: Clean up spurious interrupt check logic
Date: Tue, 14 Apr 2009 15:02:27 -0700
Message-ID: <20090414220227.9878.31321.stgit@localhost>
References: <20090414214638.9878.17987.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51256 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbZDNWC3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 18:02:29 -0400
In-Reply-To: <20090414214638.9878.17987.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Roger Quadros <ext-roger.quadros@nokia.com>

From: Roger Quadros <ext-roger.quadros@nokia.com>

SPURIOUSIRQ is contained in bits 31:7 of INTC_SIR, so
INTC_SIR must be right shifted by 7, not 6.

No change in logic, only changes for better readability.
Refer to register definition of INTCPS_SIR_IRQ in OMAP3 Manual.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 9ba20d9..998c5c4 100644
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

