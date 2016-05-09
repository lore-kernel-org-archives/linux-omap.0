From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC PATCH 3/3] misc: SRAM: Add option to map SRAM to allow code execution
Date: Mon, 9 May 2016 16:41:51 -0500
Message-ID: <1462830111-28172-4-git-send-email-d-gerlach@ti.com>
References: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Russ Dill <russ.dill@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>, Tony Lindgren <tony@atomide.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Russ Dill <Russ.Dill@ti.com>
List-Id: linux-omap@vger.kernel.org

Allow option for mapping SRAM as executable. DT node can specify
"memory-exec" and "memory-exec-nocache" to also map it as non-cached.
This is useful for platforms using the sram driver that need to run
PM code from sram like several ARM platforms.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 Documentation/devicetree/bindings/sram/sram.txt | 2 ++
 drivers/misc/sram.c                             | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/sram.txt b/Documentation/devicetree/bindings/sram/sram.txt
index 227e3a341af1..1f1d0aa52703 100644
--- a/Documentation/devicetree/bindings/sram/sram.txt
+++ b/Documentation/devicetree/bindings/sram/sram.txt
@@ -29,6 +29,8 @@ Optional properties in the sram node:
 
 - no-memory-wc : the flag indicating, that SRAM memory region has not to
                  be remapped as write combining. WC is used by default.
+- memory-exec : map range to allow code execution
+- memory-exec-nocache : map range to allow code execution and also non-cached
 
 Required properties in the area nodes:
 
diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 69cdabea9c03..7f00ba574a83 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -362,6 +362,14 @@ static int sram_probe(struct platform_device *pdev)
 
 	if (of_property_read_bool(pdev->dev.of_node, "no-memory-wc"))
 		sram->virt_base = devm_ioremap(sram->dev, res->start, size);
+	else if (of_property_read_bool(pdev->dev.of_node, "memory-exec"))
+		sram->virt_base = devm_ioremap_exec(sram->dev, res->start,
+						    size);
+	else if (of_property_read_bool(pdev->dev.of_node,
+				       "memory-exec-nocache"))
+		sram->virt_base = devm_ioremap_exec_nocache(sram->dev,
+							    res->start,
+							    size);
 	else
 		sram->virt_base = devm_ioremap_wc(sram->dev, res->start, size);
 	if (IS_ERR(sram->virt_base))
-- 
2.7.3
