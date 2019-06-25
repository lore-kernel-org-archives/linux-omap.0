From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH V3 10/15] ARM: orion5x: cleanup cppcheck shifting errors
Date: Tue, 25 Jun 2019 11:03:51 +0700
Message-ID: <20190625040356.27473-11-tranmanphong@gmail.com>
References: <20190624135105.15579-1-tranmanphong@gmail.com>
 <20190625040356.27473-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625040356.27473-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tranmanphong@gmail.com
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@armlinux.org.uk, liviu.dudau@arm.com, lkundrak@v3.sk
List-Id: linux-omap@vger.kernel.org

There is error from cppcheck tool
"Shifting signed 32-bit value by 31 bits is undefined behaviour errors"
change to use BIT() marco for improvement.

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-orion5x/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 76951bfbacf5..f47668530d5e 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -200,13 +200,13 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 /*
  * PCI_MODE bits
  */
-#define PCI_MODE_64BIT			(1 << 2)
-#define PCI_MODE_PCIX			((1 << 4) | (1 << 5))
+#define PCI_MODE_64BIT			BIT(2)
+#define PCI_MODE_PCIX			(BIT(4) | BIT(5))
 
 /*
  * PCI_CMD bits
  */
-#define PCI_CMD_HOST_REORDER		(1 << 29)
+#define PCI_CMD_HOST_REORDER		BIT(29)
 
 /*
  * PCI_P2P_CONF bits
@@ -223,7 +223,7 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 #define PCI_CONF_FUNC(func)		(((func) & 0x3) << 8)
 #define PCI_CONF_DEV(dev)		(((dev) & 0x1f) << 11)
 #define PCI_CONF_BUS(bus)		(((bus) & 0xff) << 16)
-#define PCI_CONF_ADDR_EN		(1 << 31)
+#define PCI_CONF_ADDR_EN		BIT(31)
 
 /*
  * Internal configuration space
-- 
2.11.0
