From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 9/9] musb_hdrc: Rename debug.h to musb_debug.h
Date: Mon, 20 Aug 2007 02:10:27 -0700
Message-ID: <11876010502535-git-send-email-tony@atomide.com>
References: <11876010273160-git-send-email-tony@atomide.com>
	<11876010292224-git-send-email-tony@atomide.com>
	<11876010322255-git-send-email-tony@atomide.com>
	<11876010342086-git-send-email-tony@atomide.com>
	<1187601037732-git-send-email-tony@atomide.com>
	<11876010403850-git-send-email-tony@atomide.com>
	<11876010423282-git-send-email-tony@atomide.com>
	<11876010442230-git-send-email-tony@atomide.com>
	<11876010472398-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11876010472398-git-send-email-tony@atomide.com>
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
List-Id: linux-omap@vger.kernel.org

Rename debug.h to musb_debug.h

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/debug.h      |   66 -----------------------------------------
 drivers/usb/musb/musb_core.h  |    2 +-
 drivers/usb/musb/musb_debug.h |   66 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 67 deletions(-)
 delete mode 100644 drivers/usb/musb/debug.h
 create mode 100644 drivers/usb/musb/musb_debug.h

diff --git a/drivers/usb/musb/debug.h b/drivers/usb/musb/debug.h
deleted file mode 100644
index 5eff56e..0000000
--- a/drivers/usb/musb/debug.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * MUSB OTG driver debug defines
- *
- * Copyright 2005 Mentor Graphics Corporation
- * Copyright (C) 2005-2006 by Texas Instruments
- * Copyright (C) 2006-2007 Nokia Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- */
-
-#ifndef __MUSB_LINUX_DEBUG_H__
-#define __MUSB_LINUX_DEBUG_H__
-
-#define yprintk(facility, format, args...) \
-	do { printk(facility "%s %d: " format , \
-	__FUNCTION__, __LINE__ , ## args); } while (0)
-#define WARN(fmt, args...) yprintk(KERN_WARNING,fmt, ## args)
-#define INFO(fmt,args...) yprintk(KERN_INFO,fmt, ## args)
-#define ERR(fmt,args...) yprintk(KERN_ERR,fmt, ## args)
-
-#define xprintk(level, facility, format, args...) do { \
-	if ( _dbg_level(level) ) { \
-		printk(facility "%s %d: " format , \
-				__FUNCTION__, __LINE__ , ## args); \
-	} } while (0)
-
-#if MUSB_DEBUG > 0
-extern unsigned debug;
-#else
-#define debug	0
-#endif
-
-static inline int _dbg_level(unsigned l)
-{
-	return debug >= l;
-}
-
-#define DBG(level,fmt,args...) xprintk(level,KERN_DEBUG,fmt, ## args)
-
-extern const char *otg_state_string(struct musb *);
-
-#endif				//  __MUSB_LINUX_DEBUG_H__
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 56f8fbb..29239a0 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -53,7 +53,7 @@ struct musb_hw_ep;
 struct musb_ep;
 
 
-#include "debug.h"
+#include "musb_debug.h"
 #include "musb_dma.h"
 
 #ifdef CONFIG_USB_MUSB_SOC
diff --git a/drivers/usb/musb/musb_debug.h b/drivers/usb/musb/musb_debug.h
new file mode 100644
index 0000000..5eff56e
--- /dev/null
+++ b/drivers/usb/musb/musb_debug.h
@@ -0,0 +1,66 @@
+/*
+ * MUSB OTG driver debug defines
+ *
+ * Copyright 2005 Mentor Graphics Corporation
+ * Copyright (C) 2005-2006 by Texas Instruments
+ * Copyright (C) 2006-2007 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+#ifndef __MUSB_LINUX_DEBUG_H__
+#define __MUSB_LINUX_DEBUG_H__
+
+#define yprintk(facility, format, args...) \
+	do { printk(facility "%s %d: " format , \
+	__FUNCTION__, __LINE__ , ## args); } while (0)
+#define WARN(fmt, args...) yprintk(KERN_WARNING,fmt, ## args)
+#define INFO(fmt,args...) yprintk(KERN_INFO,fmt, ## args)
+#define ERR(fmt,args...) yprintk(KERN_ERR,fmt, ## args)
+
+#define xprintk(level, facility, format, args...) do { \
+	if ( _dbg_level(level) ) { \
+		printk(facility "%s %d: " format , \
+				__FUNCTION__, __LINE__ , ## args); \
+	} } while (0)
+
+#if MUSB_DEBUG > 0
+extern unsigned debug;
+#else
+#define debug	0
+#endif
+
+static inline int _dbg_level(unsigned l)
+{
+	return debug >= l;
+}
+
+#define DBG(level,fmt,args...) xprintk(level,KERN_DEBUG,fmt, ## args)
+
+extern const char *otg_state_string(struct musb *);
+
+#endif				//  __MUSB_LINUX_DEBUG_H__
-- 
1.5.2.3
