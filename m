From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/4] OMAP2xxx: clock data: clean up some comments
Date: Fri, 25 Feb 2011 17:20:10 -0700
Message-ID: <20110226002009.28142.93377.stgit@twilight.localdomain>
References: <20110226001601.28142.46636.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46821 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579Ab1BZAUt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 19:20:49 -0500
In-Reply-To: <20110226001601.28142.46636.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Minor cleanup of some clock data comments.  No functional changes.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock2420_data.c |   23 ++++++++++-------------
 arch/arm/mach-omap2/clock2430_data.c |   23 ++++++++++-------------
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 5e80d3d..b6f65d4 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1,12 +1,12 @@
 /*
- *  linux/arch/arm/mach-omap2/clock2420_data.c
+ * OMAP2420 clock data
  *
- *  Copyright (C) 2005-2009 Texas Instruments, Inc.
- *  Copyright (C) 2004-2011 Nokia Corporation
+ * Copyright (C) 2005-2009 Texas Instruments, Inc.
+ * Copyright (C) 2004-2011 Nokia Corporation
  *
- *  Contacts:
- *  Richard Woodruff <r-woodruff2@ti.com>
- *  Paul Walmsley
+ * Contacts:
+ * Richard Woodruff <r-woodruff2@ti.com>
+ * Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -34,18 +34,15 @@
 /*
  * 2420 clock tree.
  *
- * NOTE:In many cases here we are assigning a 'default' parent.	In many
- *	cases the parent is selectable.	The get/set parent calls will also
- *	switch sources.
- *
- *	Many some clocks say always_enabled, but they can be auto idled for
- *	power savings. They will always be available upon clock request.
+ * NOTE:In many cases here we are assigning a 'default' parent. In
+ *	many cases the parent is selectable. The set parent calls will
+ *	also switch sources.
  *
  *	Several sources are given initial rates which may be wrong, this will
  *	be fixed up in the init func.
  *
  *	Things are broadly separated below by clock domains. It is
- *	noteworthy that most periferals have dependencies on multiple clock
+ *	noteworthy that most peripherals have dependencies on multiple clock
  *	domains. Many get their interface clocks from the L4 domain, but get
  *	functional clocks from fixed sources or other core domain derived
  *	clocks.
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 8957fc6..5c2a075 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1,12 +1,12 @@
 /*
- *  linux/arch/arm/mach-omap2/clock2430_data.c
+ * OMAP2430 clock data
  *
- *  Copyright (C) 2005-2009 Texas Instruments, Inc.
- *  Copyright (C) 2004-2011 Nokia Corporation
+ * Copyright (C) 2005-2009 Texas Instruments, Inc.
+ * Copyright (C) 2004-2011 Nokia Corporation
  *
- *  Contacts:
- *  Richard Woodruff <r-woodruff2@ti.com>
- *  Paul Walmsley
+ * Contacts:
+ * Richard Woodruff <r-woodruff2@ti.com>
+ * Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -34,18 +34,15 @@
 /*
  * 2430 clock tree.
  *
- * NOTE:In many cases here we are assigning a 'default' parent.	In many
- *	cases the parent is selectable.	The get/set parent calls will also
- *	switch sources.
- *
- *	Many some clocks say always_enabled, but they can be auto idled for
- *	power savings. They will always be available upon clock request.
+ * NOTE:In many cases here we are assigning a 'default' parent. In
+ *	many cases the parent is selectable. The set parent calls will
+ *	also switch sources.
  *
  *	Several sources are given initial rates which may be wrong, this will
  *	be fixed up in the init func.
  *
  *	Things are broadly separated below by clock domains. It is
- *	noteworthy that most periferals have dependencies on multiple clock
+ *	noteworthy that most peripherals have dependencies on multiple clock
  *	domains. Many get their interface clocks from the L4 domain, but get
  *	functional clocks from fixed sources or other core domain derived
  *	clocks.


