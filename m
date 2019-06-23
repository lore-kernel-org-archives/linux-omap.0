From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH 10/15] ARM: orion5x: cleanup cppcheck shifting errors
Date: Sun, 23 Jun 2019 22:13:08 +0700
Message-ID: <20190623151313.970-11-tranmanphong@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190623151313.970-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mark.rutland@arm.com, kstewart@linuxfoundation.org, songliubraving@fb.com, andrew@lunn.ch, peterz@infradead.org, nsekhar@ti.com, ast@kernel.org, jolsa@redhat.com, netdev@vger.kernel.org, gerg@uclinux.org, lorenzo.pieralisi@arm.com, will@kernel.org, linux-samsung-soc@vger.kernel.org, daniel@iogearbox.net, tranmanphong@gmail.com, festevam@gmail.com, gregory.clement@bootlin.com, allison@lohutok.net, linux@armlinux.org.uk, krzk@kernel.org, haojian.zhuang@gmail.com, bgolaszewski@baylibre.com, tony@atomide.com, mingo@redhat.com, linux-imx@nxp.com, yhs@fb.com, sebastian.hesselbarth@gmail.com, illusionist.neo@gmail.com, jason@lakedaemon.net, liviu.dudau@arm.com, s.hauer@pengutronix.de, acme@kernel.org, lkundrak@v3.sk, robert.jarzmik@free.fr, dmg@turingmachine.org, swinslow@gmail.co
List-Id: linux-omap@vger.kernel.org

[arch/arm/mach-orion5x/pci.c:281]: (error) Shifting signed 32-bit value
by 31 bits is undefined behaviour
[arch/arm/mach-orion5x/pci.c:305]: (error) Shifting signed 32-bit value
by 31 bits is undefined behaviour

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 arch/arm/mach-orion5x/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 76951bfbacf5..1b2c077ee7b8 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -200,13 +200,13 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 /*
  * PCI_MODE bits
  */
-#define PCI_MODE_64BIT			(1 << 2)
-#define PCI_MODE_PCIX			((1 << 4) | (1 << 5))
+#define PCI_MODE_64BIT			(1U << 2)
+#define PCI_MODE_PCIX			((1U << 4) | (1U << 5))
 
 /*
  * PCI_CMD bits
  */
-#define PCI_CMD_HOST_REORDER		(1 << 29)
+#define PCI_CMD_HOST_REORDER		(1U << 29)
 
 /*
  * PCI_P2P_CONF bits
@@ -223,7 +223,7 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 #define PCI_CONF_FUNC(func)		(((func) & 0x3) << 8)
 #define PCI_CONF_DEV(dev)		(((dev) & 0x1f) << 11)
 #define PCI_CONF_BUS(bus)		(((bus) & 0xff) << 16)
-#define PCI_CONF_ADDR_EN		(1 << 31)
+#define PCI_CONF_ADDR_EN		(1U << 31)
 
 /*
  * Internal configuration space
-- 
2.11.0
