From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH] OMAP: wait for pwrdm transition after clk_enable()
Date: Fri, 12 Dec 2008 09:48:53 +0200
Message-ID: <1229068133-13933-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:44830 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756613AbYLLHtR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Dec 2008 02:49:17 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBC7mjin006208
	for <linux-omap@vger.kernel.org>; Fri, 12 Dec 2008 09:49:14 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Enabling clock in a disabled power domain causes the power domain to be
turned on. However, the power transition is not always finished when
clk_enable() returns and this randomly crashes the kernel when an
interrupt happens right after the clk_enable, and the kernel tries to
read the irq status register for that domain.

Why the irq status register is inaccessible, I don't know. Also it
doesn't seem to be related to the module being not powered up, but to
the transition itself.

The same could perhaps happen after clk_disable also, but I have not
witnessed that.

The problem affects at least dss, cam and sgx clocks.

This change waits for the transition to be finished before returning
from omap2_clkdm_clk_enable().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/mach-omap2/clockdomain.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index fa62f14..f713d0b 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -567,6 +567,8 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_wakeup(clkdm);
 
+	pwrdm_wait_transition(clkdm->pwrdm.ptr);
+
 	return 0;
 }
 
-- 
1.6.0.3

