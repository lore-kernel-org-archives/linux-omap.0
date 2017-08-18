From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 03/18] PCI: endpoint: pci-epf-core: Make ->remove() callback optional
Date: Fri, 18 Aug 2017 20:27:55 +0530
Message-ID: <20170818145810.17649-4-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, kishon@ti.com, nsekhar@ti.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Make ->remove() callback optional so that endpoint function drivers
don't have to populate empty ->remove() callback functions.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 60ea0c51161e..ae6fac5995e3 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -333,11 +333,12 @@ static int pci_epf_device_probe(struct device *dev)
 
 static int pci_epf_device_remove(struct device *dev)
 {
-	int ret;
+	int ret = 0;
 	struct pci_epf *epf = to_pci_epf(dev);
 	struct pci_epf_driver *driver = to_pci_epf_driver(dev->driver);
 
-	ret = driver->remove(epf);
+	if (driver->remove)
+		ret = driver->remove(epf);
 	epf->driver = NULL;
 
 	return ret;
-- 
2.11.0
