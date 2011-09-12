From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 01/10] hwspinlock/core: simplify Kconfig
Date: Mon, 12 Sep 2011 19:46:56 +0300
Message-ID: <1315846025-11453-2-git-send-email-ohad@wizery.com>
References: <1315846025-11453-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315846025-11453-1-git-send-email-ohad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

Simplify hwspinlock's Kconfig by making the global CONFIG_HWSPINLOCK
entry invisible; users will just select it when needed.

This also prepares the ground for adding hwspinlock support for other
platforms (the 'depends on ARCH_OMAP4' was rather hideous, and while
we're at it, a dedicated menu is added).

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/hwspinlock/Kconfig |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index 1f29bab..c8e7bda 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -2,22 +2,20 @@
 # Generic HWSPINLOCK framework
 #
 
+# HWSPINLOCK always gets selected by whoever wants it.
 config HWSPINLOCK
-	tristate "Generic Hardware Spinlock framework"
-	depends on ARCH_OMAP4
-	help
-	  Say y here to support the generic hardware spinlock framework.
-	  You only need to enable this if you have hardware spinlock module
-	  on your system (usually only relevant if your system has remote slave
-	  coprocessors).
+	tristate
 
-	  If unsure, say N.
+menu "Hardware Spinlock drivers"
 
 config HWSPINLOCK_OMAP
 	tristate "OMAP Hardware Spinlock device"
-	depends on HWSPINLOCK && ARCH_OMAP4
+	depends on ARCH_OMAP4
+	select HWSPINLOCK
 	help
 	  Say y here to support the OMAP Hardware Spinlock device (firstly
 	  introduced in OMAP4).
 
 	  If unsure, say N.
+
+endmenu
-- 
1.7.4.1
