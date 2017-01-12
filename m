From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 3/3] misc: sram: Integrate protect-exec reserved sram area type
Date: Thu, 12 Jan 2017 14:52:20 -0600
Message-ID: <20170112205220.26325-4-d-gerlach@ti.com>
References: <20170112205220.26325-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170112205220.26325-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Russell King <linux@arm.linux.org.uk>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Introduce a new "protect-exec" reserved sram area type which is
makes use of the the existing functionality provided for the "pool"
sram region type for use with the genalloc framework and with the
added requirement that it be maintained as read-only and executable
while allowing for an arbitrary number of drivers to share the space.

This introduces a common way to maintain a region of sram as read-only
and executable and also introduces a helper function, sram_exec_copy,
which allows for copying data to this protected region while maintaining
locking to avoid conflicts between multiple users of the same space. A
region of memory that is marked with the "protect-exec" flag in the
device tree also has the requirement of providing a page aligned block
of memory so that the page attribute manipulation does not affect
surrounding regions.

Also, selectively enable this only for builds that support set_memory_*
calls, for now just ARM, through the use of Kconfig.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 Documentation/devicetree/bindings/sram/sram.txt |  6 ++++++
 drivers/misc/Kconfig                            |  4 ++++
 drivers/misc/Makefile                           |  1 +
 drivers/misc/sram.c                             | 21 +++++++++++++++++++--
 drivers/misc/sram.h                             |  1 +
 5 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sram/sram.txt b/Documentation/devicetree/bindings/sram/sram.txt
index 068c2c03c38f..267da4410aef 100644
--- a/Documentation/devicetree/bindings/sram/sram.txt
+++ b/Documentation/devicetree/bindings/sram/sram.txt
@@ -42,6 +42,12 @@ Optional properties in the area nodes:
          and in use by another device or devices
 - export : indicates that the reserved SRAM area may be accessed outside
            of the kernel, e.g. by bootloader or userspace
+- protect-exec : Same as 'pool' above but with the additional
+		 constraint that code wil be run from the region and
+		 that the memory is maintained as read-only, executable
+		 during code execution. NOTE: This region must be page
+		 aligned on start and end in order to properly allow
+		 manipulation of the page attributes.
 - label : the name for the reserved partition, if omitted, the label
           is taken from the node name excluding the unit address.
 
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 64971baf11fa..0444a8f9b094 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -474,11 +474,15 @@ config SRAM
 	bool "Generic on-chip SRAM driver"
 	depends on HAS_IOMEM
 	select GENERIC_ALLOCATOR
+	select SRAM_EXEC if ARM
 	help
 	  This driver allows you to declare a memory region to be managed by
 	  the genalloc API. It is supposed to be used for small on-chip SRAM
 	  areas found on many SoCs.
 
+config SRAM_EXEC
+	bool
+
 config VEXPRESS_SYSCFG
 	bool "Versatile Express System Configuration driver"
 	depends on VEXPRESS_CONFIG
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 31983366090a..7a3ea89339b4 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_INTEL_MEI)		+= mei/
 obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
 obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
 obj-$(CONFIG_SRAM)		+= sram.o
+obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
 obj-y				+= mic/
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 4ef5affd03d7..15792970edf6 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -122,6 +122,18 @@ static int sram_add_partition(struct sram_dev *sram, struct sram_reserve *block,
 		if (ret)
 			return ret;
 	}
+	if (block->protect_exec) {
+		ret = sram_check_protect_exec(sram, block, part);
+		if (ret)
+			return ret;
+
+		ret = sram_add_pool(sram, block, start, part);
+		if (ret)
+			return ret;
+
+		sram_add_protect_exec(part);
+	}
+
 	sram->partitions++;
 
 	return 0;
@@ -207,7 +219,11 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
 		if (of_find_property(child, "pool", NULL))
 			block->pool = true;
 
-		if ((block->export || block->pool) && block->size) {
+		if (of_find_property(child, "protect-exec", NULL))
+			block->protect_exec = true;
+
+		if ((block->export || block->pool || block->protect_exec) &&
+		    block->size) {
 			exports++;
 
 			label = NULL;
@@ -267,7 +283,8 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
 			goto err_chunks;
 		}
 
-		if ((block->export || block->pool) && block->size) {
+		if ((block->export || block->pool || block->protect_exec) &&
+		    block->size) {
 			ret = sram_add_partition(sram, block,
 						 res->start + block->start);
 			if (ret) {
diff --git a/drivers/misc/sram.h b/drivers/misc/sram.h
index b268cd3f55bb..c181ce4c8fca 100644
--- a/drivers/misc/sram.h
+++ b/drivers/misc/sram.h
@@ -34,6 +34,7 @@ struct sram_reserve {
 	u32 size;
 	bool export;
 	bool pool;
+	bool protect_exec;
 	const char *label;
 };
 
-- 
2.11.0
