From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH V3 8/8] OMAP: cpufreq: minor file header updates
Date: Wed, 25 May 2011 16:38:53 -0700
Message-ID: <1306366733-8439-9-git-send-email-nm@ti.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:41992 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932218Ab1EYXj2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 19:39:28 -0400
Received: by mail-gx0-f173.google.com with SMTP id 26so90540gxk.4
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 16:39:28 -0700 (PDT)
In-Reply-To: <1306366733-8439-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Minor file header updates to reflect 2011 for omap2-cpufreq code
and remove misleading OMAP3 reference in omap1 cpufreq code.

Should probably be squashed to:
"OMAP: cpufreq: Split OMAP1 and OMAP2PLUS CPUfreq drivers."

Reported-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap1/omap1-cpufreq.c     |    1 -
 arch/arm/mach-omap2/omap2plus-cpufreq.c |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/omap1-cpufreq.c b/arch/arm/mach-omap1/omap1-cpufreq.c
index 682cdc8..7c5216e 100644
--- a/arch/arm/mach-omap1/omap1-cpufreq.c
+++ b/arch/arm/mach-omap1/omap1-cpufreq.c
@@ -9,7 +9,6 @@
  *  Based on cpu-sa1110.c, Copyright (C) 2001 Russell King
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Updated to support OMAP3
  * Rajendra Nayak <rnayak@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 594100e..2482c71 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -8,7 +8,7 @@
  *
  *  Based on cpu-sa1110.c, Copyright (C) 2001 Russell King
  *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-20011 Texas Instruments, Inc.
  * Updated to support OMAP3
  * Rajendra Nayak <rnayak@ti.com>
  *
-- 
1.7.1

