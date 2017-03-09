From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 22/23] MAINTAINERS: add PCI EP maintainer
Date: Thu, 9 Mar 2017 13:27:33 +0530
Message-ID: <1489046254-19919-23-git-send-email-kishon@ti.com>
References: <1489046254-19919-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489046254-19919-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: hch@infradead.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Add maintainer for the newly introduced PCI EP framework.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c265a5f..3c1b947 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9581,6 +9581,15 @@ F:	include/linux/pci*
 F:	arch/x86/pci/
 F:	arch/x86/kernel/quirks.c
 
+PCI EP SUBSYSTEM
+M:	Kishon Vijay Abraham I <kishon@ti.com>
+L:	linux-pci@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git
+S:	Supported
+F:	drivers/pci/endpoint/
+F:	drivers/misc/pci_endpoint_test.c
+F:	tools/pci/
+
 PCI DRIVER FOR ALTERA PCIE IP
 M:	Ley Foon Tan <lftan@altera.com>
 L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
-- 
1.7.9.5
