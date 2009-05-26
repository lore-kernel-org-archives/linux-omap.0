From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/10] OMAP2 clock/powerdomain: off by 1 error in loop timeout
	comparisons
Date: Tue, 26 May 2009 16:12:37 -0600
Message-ID: <20090526221236.25381.46396.stgit@localhost.localdomain>
References: <20090526220517.25381.75976.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33610 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758660AbZEZWWh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 May 2009 18:22:37 -0400
In-Reply-To: <20090526220517.25381.75976.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roel Kluin <roel.kluin@gmail.com>, Paul Walmsley <paul@pwsan.com>

From: Roel Kluin <roel.kluin@gmail.com>

with while (i++ < MAX_CLOCK_ENABLE_WAIT); i can reach MAX_CLOCK_ENABLE_WAIT + 1
after the loop, so if (i == MAX_CLOCK_ENABLE_WAIT) that's still success.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c       |    2 +-
 arch/arm/mach-omap2/powerdomain.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 076f0a7..3c70c33 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -302,7 +302,7 @@ int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
 		udelay(1);
 	}
 
-	if (i < MAX_CLOCK_ENABLE_WAIT)
+	if (i <= MAX_CLOCK_ENABLE_WAIT)
 		pr_debug("Clock %s stable after %d loops\n", name, i);
 	else
 		printk(KERN_ERR "Clock %s didn't enable in %d tries\n",
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 73e2971..983f1cb 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1099,7 +1099,7 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
 	       (c++ < PWRDM_TRANSITION_BAILOUT))
 		udelay(1);
 
-	if (c >= PWRDM_TRANSITION_BAILOUT) {
+	if (c > PWRDM_TRANSITION_BAILOUT) {
 		printk(KERN_ERR "powerdomain: waited too long for "
 		       "powerdomain %s to complete transition\n", pwrdm->name);
 		return -EAGAIN;


