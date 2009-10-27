From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP PM SRF: fix authorship, initial comment
Date: Tue, 27 Oct 2009 14:30:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0910271429160.28412@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60741 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075AbZJ0UaI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Oct 2009 16:30:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, khilman@deeprootsystems.com


This patch applies against the PM branch.

While this code is derived from other code that I wrote, I believe this code
was originally written by Rajendra Nayak.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/omap-pm-srf.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-pm-srf.c
index ef1d235..751d9b3 100644
--- a/arch/arm/plat-omap/omap-pm-srf.c
+++ b/arch/arm/plat-omap/omap-pm-srf.c
@@ -2,14 +2,11 @@
  * omap-pm-srf.c - OMAP power management interface implemented
  * using Shared resource framework
  *
- * This code implements the OMAP power management interface to
- * drivers, CPUIdle, CPUFreq, and DSP Bridge.  It is strictly for
- * debug/demonstration use, as it does nothing but printk() whenever a
- * function is called (when DEBUG is defined, below)
+ * Copyright (C) 2008-2009 Texas Instruments, Inc.
+ * Copyright (C) 2008-2009 Nokia Corporation
+ * Rajendra Nayak
  *
- * Copyright (C) 2008 Texas Instruments, Inc.
- * Copyright (C) 2008 Nokia Corporation
- * Paul Walmsley
+ * This code is based on plat-omap/omap-pm-noop.c.
  *
  * Interface developed by (in alphabetical order):
  * Karthik Dasu, Tony Lindgren, Rajendra Nayak, Sakari Poussa, Veeramanikandan
-- 
1.6.5.GIT

