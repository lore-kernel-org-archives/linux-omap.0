From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 3/3] ARM: OMAP: ocp2scp: create omap device for ocp2scp
Date: Mon, 8 Oct 2012 11:29:43 +0530
Message-ID: <1349675983-23803-4-git-send-email-kishon@ti.com>
References: <1349675983-23803-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1349675983-23803-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, kishon@ti.com, arnd@arndb.de, olof@lixom.net, rdunlap@xenotime.net, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Platfrom device for ocp2scp is created using omap_device_build in
devices file. This is used for both omap4(musb) and omap5(dwc3).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/devices.c |   76 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c8c2117..ac2bfce 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/omap4-keypad.h>
+#include <linux/platform_data/omap_ocp2scp.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -613,6 +614,80 @@ static void omap_init_vout(void)
 static inline void omap_init_vout(void) {}
 #endif
 
+#if defined(CONFIG_OMAP_OCP2SCP) || defined(CONFIG_OMAP_OCP2SCP_MODULE)
+static int count_ocp2scp_devices(struct omap_ocp2scp_dev *ocp2scp_dev)
+{
+	int cnt	= 0;
+
+	while (ocp2scp_dev->drv_name != NULL) {
+		cnt++;
+		ocp2scp_dev++;
+	}
+
+	return cnt;
+}
+
+static void omap_init_ocp2scp(void)
+{
+	struct omap_hwmod	*oh;
+	struct platform_device	*pdev;
+	int			bus_id = -1, dev_cnt = 0, i;
+	struct omap_ocp2scp_dev	*ocp2scp_dev;
+	const char		*oh_name, *name;
+	struct omap_ocp2scp_platform_data *pdata;
+
+	oh_name = "ocp2scp_usb_phy";
+	name	= "omap-ocp2scp";
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("%s: could not find omap_hwmod for %s\n", __func__,
+								oh_name);
+		return;
+	}
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("%s: No memory for ocp2scp pdata\n", __func__);
+		return;
+	}
+
+	ocp2scp_dev = oh->dev_attr;
+	dev_cnt = count_ocp2scp_devices(ocp2scp_dev);
+
+	if (!dev_cnt) {
+		pr_err("%s: No devices connected to ocp2scp\n", __func__);
+		kfree(pdata);
+		return;
+	}
+
+	pdata->devices = kzalloc(sizeof(struct omap_ocp2scp_dev *)
+					* dev_cnt, GFP_KERNEL);
+	if (!pdata->devices) {
+		pr_err("%s: No memory for ocp2scp pdata devices\n", __func__);
+		kfree(pdata);
+		return;
+	}
+
+	for (i = 0; i < dev_cnt; i++, ocp2scp_dev++)
+		pdata->devices[i] = ocp2scp_dev;
+
+	pdata->dev_cnt	= dev_cnt;
+
+	pdev = omap_device_build(name, bus_id, oh, pdata, sizeof(*pdata), NULL,
+								0, false);
+	if (IS_ERR(pdev)) {
+		pr_err("Could not build omap_device for %s %s\n",
+						name, oh_name);
+		kfree(pdata->devices);
+		kfree(pdata);
+		return;
+	}
+}
+#else
+static inline void omap_init_ocp2scp(void) { }
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 static int __init omap2_init_devices(void)
@@ -640,6 +715,7 @@ static int __init omap2_init_devices(void)
 	omap_init_sham();
 	omap_init_aes();
 	omap_init_vout();
+	omap_init_ocp2scp();
 
 	return 0;
 }
-- 
1.7.9.5
