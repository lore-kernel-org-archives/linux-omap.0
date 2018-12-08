From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] PM / AVS: SmartReflex: Switch to SPDX Licence ID
Date: Sat, 8 Dec 2018 10:00:42 -0600
Message-ID: <20181208160042.32587-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Fix up licensing to be inline with Linux conventions.

Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/power/avs/smartreflex.c   | 5 +----
 include/linux/power/smartreflex.h | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index 536d99dc0008..82fda4d050ce 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * OMAP SmartReflex Voltage Control
  *
@@ -11,10 +12,6 @@
  *
  * Copyright (C) 2007 Texas Instruments, Inc.
  * Lesly A M <x0080970@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/module.h>
diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
index a586976f4784..d0b37e937037 100644
--- a/include/linux/power/smartreflex.h
+++ b/include/linux/power/smartreflex.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * OMAP Smartreflex Defines and Routines
  *
@@ -11,10 +12,6 @@
  *
  * Copyright (C) 2007 Texas Instruments, Inc.
  * Lesly A M <x0080970@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __POWER_SMARTREFLEX_H
-- 
2.19.0.271.gfe8321ec057f
