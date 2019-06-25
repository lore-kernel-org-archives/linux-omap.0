From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 3/5] bus: ti-sysc: Switch to SPDX license identifier
Date: Tue, 25 Jun 2019 18:33:13 -0500
Message-ID: <20190625233315.22301-4-s-anna@ti.com>
References: <20190625233315.22301-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625233315.22301-1-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Use the appropriate SPDX license identifier in the TI sysc
interconnect target driver source files and drop the previous
boilerplate license text. Also, add the the SPDX license
identifier in the associated ti-sysc header files.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/bus/ti-sysc.c                 | 10 +---------
 include/linux/platform_data/ti-sysc.h |  2 ++
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index e6deabd8305d..3030c9eadfb1 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1,14 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ti-sysc.c - Texas Instruments sysc interconnect target driver
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/io.h>
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
index 0c587d4fc718..7d009dc08a54 100644
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 #ifndef __TI_SYSC_DATA_H__
 #define __TI_SYSC_DATA_H__
 
-- 
2.21.0
