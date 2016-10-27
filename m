From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 3/3] misc: SRAM: Add option to map SRAM to allow code execution
Date: Thu, 27 Oct 2016 13:56:12 -0500
Message-ID: <20161027185612.22362-4-d-gerlach@ti.com>
References: <20161027185612.22362-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161027185612.22362-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Tony Lindgren <tony@atomide.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Allow option for mapping SRAM as executable. DT node can specify
"memory-exec" and "memory-exec-nocache" to also map it as non-cached.
This is useful for platforms using the sram driver that need to run
PM code from sram like several ARM platforms.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 Documentation/devicetree/bindings/sram/sram.txt | 2 ++
 drivers/misc/sram.c                             | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/sram.txt b/Documentation/devicetree/bindings/sram/sram.txt
index add48f09015e..8eac557204e5 100644
--- a/Documentation/devicetree/bindings/sram/sram.txt
+++ b/Documentation/devicetree/bindings/sram/sram.txt
@@ -29,6 +29,8 @@ Optional properties in the sram node:
 
 - no-memory-wc : the flag indicating, that SRAM memory region has not to
                  be remapped as write combining. WC is used by default.
+- memory-exec : map range to allow code execution
+- memory-exec-nocache : map range to allow code execution and also non-cached
 
 Required properties in the area nodes:
 
diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index f84b53d6ce50..a9ba1be115bb 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -362,6 +362,13 @@ static int sram_probe(struct platform_device *pdev)
 
 	if (of_property_read_bool(pdev->dev.of_node, "no-memory-wc"))
 		sram->virt_base = devm_ioremap(sram->dev, res->start, size);
+	else if (of_property_read_bool(pdev->dev.of_node, "memory-exec"))
+		sram->virt_base = devm_memremap(sram->dev, res->start, size,
+						MEMREMAP_EXEC);
+	else if (of_property_read_bool(pdev->dev.of_node,
+				       "memory-exec-nocache"))
+		sram->virt_base = devm_memremap(sram->dev, res->start, size,
+						MEMREMAP_EXEC_NOCACHE);
 	else
 		sram->virt_base = devm_ioremap_wc(sram->dev, res->start, size);
 	if (!sram->virt_base)
-- 
2.9.3
