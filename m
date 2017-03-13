From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 18/23] Documentation: misc-devices: Add Documentation for pci-endpoint-test driver
Date: Mon, 13 Mar 2017 19:52:54 +0530
Message-ID: <20170313142259.25397-19-kishon@ti.com>
References: <20170313142259.25397-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20170313142259.25397-1-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: hch@infradead.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Add Documentation for pci-endpoint-test driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/misc-devices/pci-endpoint-test.txt | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/misc-devices/pci-endpoint-test.txt

diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
new file mode 100644
index 000000000000..438571898d27
--- /dev/null
+++ b/Documentation/misc-devices/pci-endpoint-test.txt
@@ -0,0 +1,35 @@
+Driver for PCI Endpoint Test Function
+
+This driver should be used as a host side driver if the root complex is
+connected to a configurable pci endpoint running *pci_epf_test* function
+driver configured according to [1].
+
+The "pci_endpoint_test" driver can be used to perform the following tests.
+
+The PCI driver for the test device performs the following tests
+	*) verifying addresses programmed in BAR
+	*) raise legacy IRQ
+	*) raise MSI IRQ
+	*) read data
+	*) write data
+	*) copy data
+
+This misc driver creates /dev/pci-endpoint-test.<num> for every
+*pci_epf_test* function connected to the root complex and "ioctls"
+should be used to perform the above tests.
+
+ioctl
+-----
+ PCITEST_BAR: Tests the BAR. The number of the BAR that has to be tested
+	      should be passed as argument.
+ PCITEST_LEGACY_IRQ: Tests legacy IRQ
+ PCITEST_MSI: Tests message signalled interrupts. The MSI number that has
+	      to be tested should be passed as argument.
+ PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
+		as argument.
+ PCITEST_READ: Perform read tests. The size of the buffer should be passed
+	       as argument.
+ PCITEST_COPY: Perform read tests. The size of the buffer should be passed
+	       as argument.
+
+[1] -> Documentation/PCI/endpoint/function/binding/pci-test.txt
-- 
2.11.0
