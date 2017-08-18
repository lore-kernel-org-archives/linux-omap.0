From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 18/18] tools: PCI: Add a missing option help line
Date: Fri, 18 Aug 2017 20:28:10 +0530
Message-ID: <20170818145810.17649-19-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, kishon@ti.com, nsekhar@ti.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Stan Drozd <drozdziak1@gmail.com>
List-Id: linux-omap@vger.kernel.org

From: Stan Drozd <drozdziak1@gmail.com>

Add a missing option help line for performing legacy interrupt
test.

Signed-off-by: Stan Drozd <drozdziak1@gmail.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 tools/pci/pcitest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index ad54a58d7dda..caf38c3959bf 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -173,6 +173,7 @@ int main(int argc, char **argv)
 			"\t-D <dev>		PCI endpoint test device {default: /dev/pci-endpoint-test.0}\n"
 			"\t-b <bar num>		BAR test (bar number between 0..5)\n"
 			"\t-m <msi num>		MSI test (msi number between 1..32)\n"
+			"\t-l			Legacy irq test\n"
 			"\t-r			Read buffer test\n"
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
-- 
2.11.0
