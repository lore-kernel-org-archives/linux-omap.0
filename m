From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH] OMAP: wait for pwrdm transition after clk_enable/disable()
Date: Thu, 11 Dec 2008 14:34:21 +0200
Message-ID: <1228998861-12086-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19338 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbYLKMe1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 07:34:27 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBBCYJAk014455
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 14:34:24 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Enabling clock in a disabled power domain causes the power domain to be
turned on. However, the power transition is not always finished when
clk_enable() returns and this randomly crashes the kernel when an
interrupt happens right after the clk_enable, and the kernel tries to
read the irq status register for that domain.

Why the irq status register is inaccessible, I don't know. Also it
doesn't seem to be related to the module being not powered up, but to
the transition itself.

The same could perhaps happen after clk_disable also, even if I have not
witnessed that.

The problem affects at least dss, cam and sgx clocks.

This change waits for the transition to be finished before returning
from omap2_clkdm_clk_enable/disable().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/mach-omap2/clockdomain.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index fa62f14..3ae9beb 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -567,6 +567,8 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_wakeup(clkdm);
 
+	pwrdm_wait_transition(clkdm->pwrdm.ptr);
+
 	return 0;
 }
 
@@ -618,6 +620,8 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_sleep(clkdm);
 
+	pwrdm_wait_transition(clkdm->pwrdm.ptr);
+
 	return 0;
 }
 
-- 
1.6.0.3

