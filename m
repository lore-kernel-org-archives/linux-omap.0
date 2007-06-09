From: Vivien Chappelier <vivien.chappelier@free.fr>
Subject: [PATCH 3/12] Add an option to disable debug UART.
Date: Sat, 09 Jun 2007 19:22:11 +0200
Message-ID: <466AE1C3.8090506@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This patch adds an option to boot without any debug UART.

Signed-off-by: Vivien Chappelier <vivien.chappelier@free.fr>

---
 arch/arm/plat-omap/Kconfig              |    3 +++
 include/asm-arm/arch-omap/debug-macro.S |   10 +++++++++-
 include/asm-arm/arch-omap/uncompress.h  |    2 +-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 6facd96..a02e954 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -178,6 +178,9 @@ choice
     depends on ARCH_OMAP
     default OMAP_LL_DEBUG_UART1
 
+config OMAP_LL_DEBUG_NONE
+    bool "NONE"
+
 config OMAP_LL_DEBUG_UART1
     bool "UART1"
 
diff --git a/include/asm-arm/arch-omap/debug-macro.S 
b/include/asm-arm/arch-omap/debug-macro.S
index ca4f577..4051420 100644
--- a/include/asm-arm/arch-omap/debug-macro.S
+++ b/include/asm-arm/arch-omap/debug-macro.S
@@ -38,6 +38,13 @@
 #endif
         .endm
 
+#ifdef CONFIG_OMAP_LL_DEBUG_NONE
+        .macro    senduart,rd,rx
+        .endm
+    
+        .macro    busyuart,rd,rx
+        .endm
+#else
         .macro    senduart,rd,rx
         strb    \rd, [\rx]
         .endm
@@ -53,6 +60,7 @@
         bne    1001b
 1002:
         .endm
-
+#endif
+    
         .macro    waituart,rd,rx
         .endm
diff --git a/include/asm-arm/arch-omap/uncompress.h 
b/include/asm-arm/arch-omap/uncompress.h
index aca0adf..409af7e 100644
--- a/include/asm-arm/arch-omap/uncompress.h
+++ b/include/asm-arm/arch-omap/uncompress.h
@@ -34,7 +34,7 @@ static void putc(int c)
     volatile u8 * uart = 0;
     int shift = 2;
 
-#ifdef CONFIG_MACH_OMAP_PALMTE
+#if defined(CONFIG_MACH_OMAP_PALMTE) || defined(CONFIG_MACH_TYPHOON)
     return;
 #endif
 
-- 
1.5.1.3
