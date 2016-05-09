From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC PATCH 2/3] lib: devres: Add exec and exec_nocache versions of
 devm_ioremap
Date: Mon, 9 May 2016 16:41:50 -0500
Message-ID: <1462830111-28172-3-git-send-email-d-gerlach@ti.com>
References: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russ Dill <Russ.Dill@ti.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Russ Dill <russ.dill@ti.com>

Now that there are _exec and _exec_nocache versions of ioremap, add devm
support for them.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 include/linux/io.h |  5 +++++
 lib/devres.c       | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/linux/io.h b/include/linux/io.h
index e2c8419278c1..1c0442e5d72c 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -79,6 +79,11 @@ void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
 void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
+void __iomem *devm_ioremap_exec(struct device *dev, resource_size_t offset,
+				unsigned long size);
+void __iomem *devm_ioremap_exec_nocache(struct device *dev,
+					resource_size_t offset,
+					unsigned long size);
 void devm_iounmap(struct device *dev, void __iomem *addr);
 int check_signature(const volatile void __iomem *io_addr,
 			const unsigned char *signature, int length);
diff --git a/lib/devres.c b/lib/devres.c
index cb1464c411a2..1181a739fd49 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -100,6 +100,64 @@ void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
 EXPORT_SYMBOL(devm_ioremap_wc);
 
 /**
+ * devm_ioremap_exec - Managed ioremap_exec()
+ * @dev: Generic device to remap IO address for
+ * @offset: BUS offset to map
+ * @size: Size of map
+ *
+ * Managed ioremap_exec().  Map is automatically unmapped on driver detach.
+ */
+void __iomem *devm_ioremap_exec(struct device *dev, resource_size_t offset,
+				unsigned long size)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = ioremap_exec(offset, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_ioremap_exec);
+
+/**
+ * devm_ioremap_exec_nocache - Managed ioremap_exec_nocache()
+ * @dev: Generic device to remap IO address for
+ * @offset: BUS offset to map
+ * @size: Size of map
+ *
+ * Managed ioremap_exec_nocache().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem *devm_ioremap_exec_nocache(struct device *dev,
+					resource_size_t offset,
+					unsigned long size)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = ioremap_exec_nocache(offset, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_ioremap_exec_nocache);
+
+/**
  * devm_iounmap - Managed iounmap()
  * @dev: Generic device to unmap for
  * @addr: Address to unmap
-- 
2.7.3
