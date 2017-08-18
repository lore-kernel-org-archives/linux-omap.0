From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 05/18] PCI: endpoint: functions/pci-epf-test: Add "volatile" to pci_epf_test_reg
Date: Fri, 18 Aug 2017 20:27:57 +0530
Message-ID: <20170818145810.17649-6-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, kishon@ti.com, nsekhar@ti.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

struct pci_epf_test_reg is the MEMSPACE of pci-epf-test function driver
that will be accessed by the "host" for programming the pci-epf-test
device. So this structure shouldn't be subjected to compiler optimization
in pci_epf_test_cmd_handler() since the values can be changed by code
outside the scope of current code at any time.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 53fff8030337..5cbc05a0762d 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -267,7 +267,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 						     cmd_handler.work);
 	struct pci_epf *epf = epf_test->epf;
 	struct pci_epc *epc = epf->epc;
-	struct pci_epf_test_reg *reg = epf_test->reg[0];
+	volatile struct pci_epf_test_reg *reg = epf_test->reg[0];
 
 	if (!reg->command)
 		goto reset_handler;
-- 
2.11.0
