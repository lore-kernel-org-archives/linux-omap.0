From: Omar Ramirez Luna <x00omar@ti.com>
Subject: [PATCH] OMAP: clock: export notifier register functions
Date: Thu, 21 May 2009 01:18:46 -0500
Message-ID: <1242886726-19761-1-git-send-email-x00omar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57495 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbZEUGO4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2009 02:14:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Gupta, Ramesh" <grgupta@ti.com>

From: Gupta, Ramesh <grgupta@ti.com>

Hi,

The following patch is required to export some symbols to be used
by bridge driver, it was merged in 2.6.28 but seems like it was dropped
for later kernels, is it ok to put it back in for linux-omap-pm 2.6.29 and/or
linux-omap master?

Regards,

- omar

From: Gupta, Ramesh <grgupta@ti.com>
Subject: [PATCH] OMAP: clock: export notifier register functions


This Patch exports symbols clk_notifier_register/unregister
function for other kernel modules usage.

Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 arch/arm/plat-omap/clock.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index eb354ec..a1a09ef 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -738,6 +738,7 @@ cnr_out:
 
 	return r;
 }
+EXPORT_SYMBOL(clk_notifier_register);
 
 /**
  * clk_notifier_unregister - remove a clock change notifier
@@ -788,6 +789,7 @@ cnu_out:
 
 	return r;
 }
+EXPORT_SYMBOL(clk_notifier_unregister);
 
 
 
-- 
1.6.2.4

