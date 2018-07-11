From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/2] mailbox/omap: switch to SPDX license identifier
Date: Wed, 11 Jul 2018 18:42:11 -0500
Message-ID: <20180711234212.7756-2-s-anna@ti.com>
References: <20180711234212.7756-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711234212.7756-1-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Use the appropriate SPDX license identifier in the OMAP Mailbox
driver source files and drop the previous boilerplate license text.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 10 +---------
 include/linux/omap-mailbox.h   |  5 +----
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index e1e2c085e68e..97c7d9b7f46f 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * OMAP mailbox driver
  *
@@ -6,15 +7,6 @@
  *
  * Contact: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
  *          Suman Anna <s-anna@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 
 #include <linux/interrupt.h>
diff --git a/include/linux/omap-mailbox.h b/include/linux/omap-mailbox.h
index c726bd833761..6dbcd2da0332 100644
--- a/include/linux/omap-mailbox.h
+++ b/include/linux/omap-mailbox.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * omap-mailbox: interprocessor communication module for OMAP
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef OMAP_MAILBOX_H
-- 
2.17.1
