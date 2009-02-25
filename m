From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] omap2: off by 1
Date: Wed, 25 Feb 2009 14:06:36 +0100
Message-ID: <49A5425C.9050405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:64507 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbZBYNGi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 08:06:38 -0500
Received: by qw-out-2122.google.com with SMTP id 5so17471qwi.37
        for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2009 05:06:36 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rmk+kernel@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

with while (i++ < MAX_CLOCK_ENABLE_WAIT); i can reach MAX_CLOCK_ENABLE_WAIT + 1
after the loop, so if (i == MAX_CLOCK_ENABLE_WAIT) that's still success.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/arm/mach-omap2/clock.c       |    2 +-
 arch/arm/mach-omap2/powerdomain.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index ce4d46a..da185ff 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -202,7 +202,7 @@ int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
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
