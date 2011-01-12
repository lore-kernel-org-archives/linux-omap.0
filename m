From: Thomas Weber <weber@corscience.de>
Subject: [PATCH] OMAP: Enable Sysrq on serial console
Date: Wed, 12 Jan 2011 10:10:32 +0100
Message-ID: <1294823432-3969-1-git-send-email-weber@corscience.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

SUPPORT_SYSRQ must be defined to enable handling of sysrq character.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 drivers/serial/omap-serial.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/omap-serial.c b/drivers/serial/omap-serial.c
index 1201eff..907be9b 100644
--- a/drivers/serial/omap-serial.c
+++ b/drivers/serial/omap-serial.c
@@ -20,6 +20,10 @@
  * this driver as required for the omap-platform.
  */
 
+#if defined(CONFIG_SERIAL_OMAP_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/console.h>
-- 
1.7.4.rc1
