From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 35/37] MAINTAINERS: add PCI EP maintainer
Date: Thu, 12 Jan 2017 15:56:24 +0530
Message-ID: <1484216786-17292-36-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Add maintainer for the newly introduced PCI EP framework.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8672f18..021f676 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9407,6 +9407,15 @@ F:	include/linux/pci*
 F:	arch/x86/pci/
 F:	arch/x86/kernel/quirks.c
 
+PCI EP SUBSYSTEM
+M:	Kishon Vijay Abraham I <kishon@ti.com>
+L:	linux-pci@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
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
