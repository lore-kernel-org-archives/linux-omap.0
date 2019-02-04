From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 13/14] rpmsg: virtio_rpmsg_bus: move back rpmsg_hdr into a public header
Date: Mon, 4 Feb 2019 16:22:46 +0200
Message-ID: <1549290167-876-14-git-send-email-rogerq@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549290167-876-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ohad@wizery.com, bjorn.andersson@linaro.org
Cc: s-anna@ti.com, david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Commit e88dae5da46d ("rpmsg: Move virtio specifics from public header")
has moved the struct rpmsg_hdr definition from the public rpmsg.h and
made it private to virtio_rpmsg_bus module. This structure is a common
header used in all virtio rpmsg messages, and used by various virtio
rpmsg bus drivers. So, move this back into the virtio_rpmsg specific
public header to make it visible to various rpmsg drivers.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c   | 21 +--------------------
 include/linux/rpmsg/virtio_rpmsg.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/rpmsg/virtio_rpmsg.h

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 664f957..f654923 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -26,6 +26,7 @@
 #include <linux/rpmsg.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
+#include <linux/rpmsg/virtio_rpmsg.h>
 
 #include "rpmsg_internal.h"
 
@@ -73,26 +74,6 @@ struct virtproc_info {
 #define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
 
 /**
- * struct rpmsg_hdr - common header for all rpmsg messages
- * @src: source address
- * @dst: destination address
- * @reserved: reserved for future use
- * @len: length of payload (in bytes)
- * @flags: message flags
- * @data: @len bytes of message payload data
- *
- * Every message sent(/received) on the rpmsg bus begins with this header.
- */
-struct rpmsg_hdr {
-	u32 src;
-	u32 dst;
-	u32 reserved;
-	u16 len;
-	u16 flags;
-	u8 data[0];
-} __packed;
-
-/**
  * struct rpmsg_ns_msg - dynamic name service announcement message
  * @name: name of remote service that is published
  * @addr: address of remote service that is published
diff --git a/include/linux/rpmsg/virtio_rpmsg.h b/include/linux/rpmsg/virtio_rpmsg.h
new file mode 100644
index 0000000..cf5f820
--- /dev/null
+++ b/include/linux/rpmsg/virtio_rpmsg.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_RPMSG_VIRTIO_RPMSG_H
+#define _LINUX_RPMSG_VIRTIO_RPMSG_H
+
+/**
+ * struct rpmsg_hdr - common header for all virtio rpmsg messages
+ * @src: source address
+ * @dst: destination address
+ * @reserved: reserved for future use
+ * @len: length of payload (in bytes)
+ * @flags: message flags
+ * @data: @len bytes of message payload data
+ *
+ * Every message sent(/received) on the rpmsg bus begins with this header.
+ */
+struct rpmsg_hdr {
+	u32 src;
+	u32 dst;
+	u32 reserved;
+	u16 len;
+	u16 flags;
+	u8 data[0];
+} __packed;
+
+#endif
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
