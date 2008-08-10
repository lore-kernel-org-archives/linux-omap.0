From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: [PATCH] usb: musb: get rid of MUSB_LOGLEVEL and use parameter
Date: Sun, 10 Aug 2008 15:20:46 +0300
Message-ID: <1218370846-9312-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

We can change debugging level on the fly via
/sys/module/musb_hdrc/parameters/debug, there's no
need for an extra command in the proc entry.

We can also get rid of the LOGLEVEL facility in Kconfig
and rely only in module parameter.

Cc: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/Kconfig       |   13 ++++++-------
 drivers/usb/musb/Makefile      |   21 ++++-----------------
 drivers/usb/musb/musb_core.c   |   17 ++++-------------
 drivers/usb/musb/musb_core.h   |    2 +-
 drivers/usb/musb/musb_debug.h  |    4 ----
 drivers/usb/musb/musb_procfs.c |   35 -----------------------------------
 6 files changed, 15 insertions(+), 77 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index a485a86..1da5fc2 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -166,12 +166,11 @@ config USB_TUSB_OMAP_DMA
 	help
 	  Enable DMA transfers on TUSB 6010 when OMAP DMA is available.
 
-config	USB_MUSB_LOGLEVEL
+config	USB_MUSB_DEBUG
 	depends on USB_MUSB_HDRC
-	int  'Logging Level (0 - none / 3 - annoying / ... )'
-	default 0
+	bool "Enable debugging messages"
+	default n
 	help
-	  Set the logging level. 0 disables the debugging altogether,
-	  although when USB_DEBUG is set the value is at least 1.
-	  Starting at level 3, per-transfer (urb, usb_request, packet,
-	  or dma transfer) tracing may kick in.
+	  This enables musb debugging. To set the logging level use the debug
+	  module parameter. Starting at level 3, per-transfer (urb, usb_request,
+	  packet, or dma transfer) tracing may kick in.
diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index 88eb67d..7fe5ddf 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -64,23 +64,10 @@ endif
 
 # Debugging
 
-MUSB_DEBUG:=$(CONFIG_USB_MUSB_LOGLEVEL)
-
-ifeq ("$(strip $(MUSB_DEBUG))","")
-    ifdef CONFIG_USB_DEBUG
-	MUSB_DEBUG:=1
-    else
-	MUSB_DEBUG:=0
-    endif
-endif
-
-ifneq ($(MUSB_DEBUG),0)
-    EXTRA_CFLAGS += -DDEBUG
-
-    ifeq ($(CONFIG_PROC_FS),y)
+ifeq ($(CONFIG_PROC_FS),y)
 	musb_hdrc-objs		+= musb_procfs.o
-    endif
-
 endif
 
-EXTRA_CFLAGS += -DMUSB_DEBUG=$(MUSB_DEBUG)
+ifeq ($(CONFIG_USB_MUSB_DEBUG),y)
+	EXTRA_CFLAGS += -DDEBUG
+endif
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 1404a10..bcbcbbb 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -114,23 +114,14 @@
 
 
 
-#if MUSB_DEBUG > 0
-unsigned debug = MUSB_DEBUG;
-module_param(debug, uint, 0);
-MODULE_PARM_DESC(debug, "initial debug message level");
-
-#define MUSB_VERSION_SUFFIX	"/dbg"
-#endif
+unsigned debug = 0;
+module_param(debug, uint, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(debug, "Debug message level. Default = 0");
 
 #define DRIVER_AUTHOR "Mentor Graphics, Texas Instruments, Nokia"
 #define DRIVER_DESC "Inventra Dual-Role USB Controller Driver"
 
-#define MUSB_VERSION_BASE "6.0"
-
-#ifndef MUSB_VERSION_SUFFIX
-#define MUSB_VERSION_SUFFIX	""
-#endif
-#define MUSB_VERSION	MUSB_VERSION_BASE MUSB_VERSION_SUFFIX
+#define MUSB_VERSION "6.0"
 
 #define DRIVER_INFO DRIVER_DESC ", v" MUSB_VERSION
 
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index c2cd5a9..3de124f 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -498,7 +498,7 @@ extern int musb_platform_exit(struct musb *musb);
 
 struct proc_dir_entry;
 
-#if (MUSB_DEBUG > 0) && defined(MUSB_CONFIG_PROC_FS)
+#ifdef CONFIG_PROC_FS
 extern struct proc_dir_entry *musb_debug_create(char *name, struct musb *data);
 extern void musb_debug_delete(char *name, struct musb *data);
 
diff --git a/drivers/usb/musb/musb_debug.h b/drivers/usb/musb/musb_debug.h
index 3bdb311..4d27944 100644
--- a/drivers/usb/musb/musb_debug.h
+++ b/drivers/usb/musb/musb_debug.h
@@ -48,11 +48,7 @@
 				__func__, __LINE__ , ## args); \
 	} } while (0)
 
-#if MUSB_DEBUG > 0
 extern unsigned debug;
-#else
-#define debug	0
-#endif
 
 static inline int _dbg_level(unsigned l)
 {
diff --git a/drivers/usb/musb/musb_procfs.c b/drivers/usb/musb/musb_procfs.c
index 6184941..2d58475 100644
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -620,7 +620,6 @@ done:
  * H request host mode
  * h cancel host request
  * T start sending TEST_PACKET
- * D<num> set/query the debug level
  */
 static int musb_proc_write(struct file *file, const char __user *buffer,
 			unsigned long count, void *data)
@@ -700,38 +699,6 @@ static int musb_proc_write(struct file *file, const char __user *buffer,
 		}
 		break;
 
-#if (MUSB_DEBUG > 0)
-		/* set/read debug level */
-	case 'D':{
-			if (count > 1) {
-				char digits[8], *p = digits;
-				int i = 0, level = 0, sign = 1;
-				int len = min(count - 1, (unsigned long)8);
-
-				if (copy_from_user(&digits, &buffer[1], len))
-					return -EFAULT;
-
-				/* optional sign */
-				if (*p == '-') {
-					len -= 1;
-					sign = -sign;
-					p++;
-				}
-
-				/* read it */
-				while (i++ < len && *p > '0' && *p < '9') {
-					level = level * 10 + (*p - '0');
-					p++;
-				}
-
-				level *= sign;
-				DBG(1, "debug level %d\n", level);
-				debug = level;
-			}
-		}
-		break;
-
