From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 4/8] Add kfifo_get_to_user to copy data to userland directly
Date: Mon, 30 Jul 2007 14:04:01 +0300
Message-ID: <11857934533223-git-send-email-Hiroshi.DOYU@nokia.com>
References: <11857934452717-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934482616-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934501598-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11857934501598-git-send-email-Hiroshi.DOYU@nokia.com>
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
 include/linux/kfifo.h |   35 ++++++++++++++++++++++++++++++
 kernel/kfifo.c        |   57 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 404f446..2dd610d 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -43,6 +43,9 @@ extern unsigned int __kfifo_put(struct kfifo *fifo,
 				unsigned char *buffer, unsigned int len);
 extern unsigned int __kfifo_get(struct kfifo *fifo,
 				unsigned char *buffer, unsigned int len);
+extern unsigned int __kfifo_get_to_user(struct kfifo *fifo,
+					unsigned char __user *buffer,
+					unsigned int len);
 
 /**
  * __kfifo_reset - removes the entire FIFO contents, no locking version
@@ -151,6 +154,38 @@ static inline unsigned int kfifo_len(struct kfifo *fifo)
 	return ret;
 }
 
+/**
+ * kfifo_get_to_user - gets some data from the FIFO
+ * @fifo: the fifo to be used.
+ * @buffer: where the data must be copied. user buffer
+ * @len: the size of the destination buffer.
+ *
+ * This function copies at most @len bytes from the FIFO into the
+ * user @buffer and returns the number of copied bytes.
+ */
+static inline unsigned int kfifo_get_to_user(struct kfifo *fifo,
+					     unsigned char __user *buffer,
+					     unsigned int len)
+{
+	unsigned long flags;
+	unsigned int ret;
+
+	spin_lock_irqsave(fifo->lock, flags);
+
+	ret = __kfifo_get_to_user(fifo, buffer, len);
+
+	/*
+	 * optimization: if the FIFO is empty, set the indices to 0
+	 * so we don't wrap the next time
+	 */
+	if (fifo->in == fifo->out)
+		fifo->in = fifo->out = 0;
+
+	spin_unlock_irqrestore(fifo->lock, flags);
+
+	return ret;
+}
+
 #else
 #warning "don't include kernel headers in userspace"
 #endif /* __KERNEL__ */
diff --git a/kernel/kfifo.c b/kernel/kfifo.c
index cee4191..abc62c3 100644
--- a/kernel/kfifo.c
+++ b/kernel/kfifo.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/kfifo.h>
+#include <linux/uaccess.h>
 
 /**
  * kfifo_init - allocates a new FIFO using a preallocated buffer
@@ -194,3 +195,59 @@ unsigned int __kfifo_get(struct kfifo *fifo,
 	return len;
 }
 EXPORT_SYMBOL(__kfifo_get);
+
+/**
+ * __kfifo_get_to_user - gets some data from the FIFO, no locking version
+ * @fifo: the fifo to be used.
+ * @buffer: where the data must be copied. user buffer.
+ * @len: the size of the destination buffer.
+ *
+ * This function copies at most @len bytes from the FIFO into the
+ * user @buffer and returns the number of copied bytes.
+ *
+ * Note that with only one concurrent reader and one concurrent
+ * writer, you don't need extra locking to use these functions.
+ */
+unsigned int __kfifo_get_to_user(struct kfifo *fifo,
+				 unsigned char __user *buffer,
+				 unsigned int len)
+{
+	unsigned int n1, n2;
+	int ret;
+
+	len = min(len, fifo->in - fifo->out);
+
+	/*
+	 * Ensure that we sample the fifo->in index -before- we
+	 * start removing bytes from the kfifo.
+	 */
+
+	smp_rmb();
+
+	/* first get the data from fifo->out until the end of the buffer */
+	n1 = min(len, fifo->size - (fifo->out & (fifo->size - 1)));
+	n2 = len -n1;
+	ret = copy_to_user(buffer,
+			   fifo->buffer + (fifo->out & (fifo->size - 1)), n1);
+	if (ret) {
+		len = n1 - ret;
+		goto out;
+	}
+
+	/* then get the rest (if any) from the beginning of the buffer */
+	ret = copy_to_user(buffer + n1, fifo->buffer, n2);
+	if (ret)
+		len = n1 + n2 - ret;
+
+	/*
+	 * Ensure that we remove the bytes from the kfifo -before-
+	 * we update the fifo->out index.
+	 */
+out:
+	smp_mb();
+
+	fifo->out += len;
+
+	return len;
+}
+EXPORT_SYMBOL(__kfifo_get_to_user);
-- 
1.5.3.rc3.24.g83b3d
