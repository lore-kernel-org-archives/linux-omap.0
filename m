From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/4] cpufreq: OMAP: remove unused <plat/omap-pm.h>
Date: Wed,  3 Oct 2012 16:00:27 -0700
Message-ID: <1349305229-28480-3-git-send-email-khilman@deeprootsystems.com>
References: <1349305229-28480-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:47064 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932441Ab2JCXAg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 19:00:36 -0400
Received: by dakn41 with SMTP id n41so1430950dak.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Oct 2012 16:00:36 -0700 (PDT)
In-Reply-To: <1349305229-28480-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

From: Kevin Hilman <khilman@ti.com>

The <plat/*.h> headers are going away, and this one is not used.  remove it.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 0fe395a..7d4d455 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -31,7 +31,6 @@
 #include <asm/cpu.h>
 
 #include <plat/clock.h>
-#include <plat/omap-pm.h>
 #include <plat/common.h>
 #include <plat/omap_device.h>
 
-- 
1.7.9.2

