From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 1/1] ARM: Removed duplicated omap Kconfig entry
Date: Mon,  5 Mar 2007 15:07:38 +0200
Message-ID: <11731000582964-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>


Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/video/Kconfig |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e37bf87..be824c0 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1635,10 +1635,6 @@ config FB_PS3_DEFAULT_SIZE_M
 	  The default value can be overridden on the kernel command line
 	  using the "ps3fb" option (e.g. "ps3fb=9M");
 
-if ARCH_OMAP
-	source "drivers/video/omap/Kconfig"
-endif
-
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
-- 
1.5.0.3.271.g5ced
