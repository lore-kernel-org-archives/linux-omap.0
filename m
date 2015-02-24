From: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Subject: [PATCH 1/8 v2] ARM OMAP2+ GPMC: don't undef DEBUG
Date: Tue, 24 Feb 2015 21:05:24 +0100
Message-ID: <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerq@ti.com, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
List-Id: linux-omap@vger.kernel.org

OMAP2+ GPMC driver undefines DEBUG, which makes it unnecessarily
hard to turn DEBUG on. Remove the offending lines.

Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
---
 drivers/memory/omap-gpmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 24696f5..5cabac8 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -12,8 +12,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#undef DEBUG
-
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-- 
2.3.0
