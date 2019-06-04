From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 23/30] of/platform: Export of_platform_device_create_pdata()
Date: Tue, 4 Jun 2019 18:45:09 +0530
Message-ID: <20190604131516.13596-24-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Export of_platform_device_create_pdata() to be used by drivers to
create child devices with the given platform data. This can be used
by platform specific driver to send platform data core driver. For e.g.,
this will be used by TI's J721E SoC specific PCIe driver to send
->start_link() ops and ->is_link_up() ops to Cadence core PCIe driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/of/platform.c       | 9 ++++-----
 include/linux/of_platform.h | 3 +++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 04ad312fd85b..94e0f733461a 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -169,11 +169,9 @@ EXPORT_SYMBOL(of_device_alloc);
  * Returns pointer to created platform device, or NULL if a device was not
  * registered.  Unavailable devices will not get registered.
  */
-static struct platform_device *of_platform_device_create_pdata(
-					struct device_node *np,
-					const char *bus_id,
-					void *platform_data,
-					struct device *parent)
+struct platform_device *
+of_platform_device_create_pdata(struct device_node *np, const char *bus_id,
+				void *platform_data, struct device *parent)
 {
 	struct platform_device *dev;
 
@@ -203,6 +201,7 @@ static struct platform_device *of_platform_device_create_pdata(
 	of_node_clear_flag(np, OF_POPULATED);
 	return NULL;
 }
+EXPORT_SYMBOL(of_platform_device_create_pdata);
 
 /**
  * of_platform_device_create - Alloc, initialize and register an of_device
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 84a966623e78..0f1f58775086 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -70,6 +70,9 @@ extern int of_platform_device_destroy(struct device *dev, void *data);
 extern int of_platform_bus_probe(struct device_node *root,
 				 const struct of_device_id *matches,
 				 struct device *parent);
+extern struct platform_device *
+of_platform_device_create_pdata(struct device_node *np, const char *bus_id,
+				void *platform_data, struct device *parent);
 #ifdef CONFIG_OF_ADDRESS
 extern int of_platform_populate(struct device_node *root,
 				const struct of_device_id *matches,
-- 
2.17.1
