From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 51/86] [ARM] OMAP: wait for pwrdm transition after clk_enable()
Date: Thu, 12 Mar 2009 11:28:01 -0700
Message-ID: <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757029AbZCLScX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:32:23 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:32:21 -0700 (PDT)
In-Reply-To: <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@nokia.com>

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
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clockdomain.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index e9b4f6c..c9c367c 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -568,6 +568,8 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_wakeup(clkdm);
 
+	pwrdm_wait_transition(clkdm->pwrdm.ptr);
+
 	return 0;
 }
 
-- 
1.6.1.2

