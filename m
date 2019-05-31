From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/3] hwspinlock/omap: Add support for TI K3 SoCs
Date: Thu, 30 May 2019 21:13:20 -0500
Message-ID: <20190531021321.14025-3-s-anna@ti.com>
References: <20190531021321.14025-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190531021321.14025-1-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

A HwSpinlock IP is also present on the newer TI K3 AM65x and J721E
family of SoCs within the Main NavSS sub-module. Reuse the existing
OMAP Hwspinlock driver to extend the support for this IP on K3 AM65x
SoCs as well. The IP has slightly different bit-fields in the
SYSCONFIG and SYSSTATUS registers.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/Kconfig           | 2 +-
 drivers/hwspinlock/omap_hwspinlock.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index 7869c67e5b6b..37740e992cfa 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -9,7 +9,7 @@ menuconfig HWSPINLOCK
 config HWSPINLOCK_OMAP
 	tristate "OMAP Hardware Spinlock device"
 	depends on HWSPINLOCK
-	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX || SOC_AM33XX || SOC_AM43XX
+	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX || SOC_AM33XX || SOC_AM43XX || ARCH_K3
 	help
 	  Say y here to support the OMAP Hardware Spinlock device (firstly
 	  introduced in OMAP4).
diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index 625844e0abef..a4d7a7bc863a 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -171,6 +171,7 @@ static int omap_hwspinlock_remove(struct platform_device *pdev)
 
 static const struct of_device_id omap_hwspinlock_of_match[] = {
 	{ .compatible = "ti,omap4-hwspinlock", },
+	{ .compatible = "ti,am654-hwspinlock", },
 	{ /* end */ },
 };
 MODULE_DEVICE_TABLE(of, omap_hwspinlock_of_match);
-- 
2.21.0
