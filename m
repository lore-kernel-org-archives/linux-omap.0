From: Suman Anna <s-anna@ti.com>
Subject: [PATCH] soc: ti: wkup_m3_ipc: switch to using remoteproc OF
 infrastructure
Date: Thu, 11 Aug 2016 19:35:29 -0500
Message-ID: <20160812003529.519-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, linux-remoteproc@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The remoteproc framework has been enhanced recently to provide new
OF API to retrieve a remoteproc handle by client drivers through a
standard 'rprocs' property in client nodes. The wkup_m3_ipc driver
has been using a custom 'ti,rproc' property until now, switch this
to use this new OF infrastructure. The wkup_m3_ipc driver has been
fixed up to provide backward compatibility for older DTBs by
replacing the older property with the standard newer property.

The wkup_m3_ipc binding has also been updated accordingly.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
This patch is based on the discussion [1] for introducing new standard
OF API in remoteproc core series [2] and the exporting of couple of
functions in OF base code [3].

With this in place, the remoteproc core need not be looking for the
TI specific property anymore. I will submit the DTS changes once this
makes it to mainline.

regards
Suman

[1] https://patchwork.kernel.org/patch/9237767/
[2] http://marc.info/?l=linux-kernel&m=146894341701010&w=2
[3] https://patchwork.kernel.org/patch/9276181/

 .../devicetree/bindings/soc/ti/wkup_m3_ipc.txt     |  9 ++++++--
 drivers/soc/ti/wkup_m3_ipc.c                       | 26 +++++++++++++++++++++-
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
index 401550487ed6..2ea7dd91acff 100644
--- a/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
+++ b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
@@ -23,12 +23,17 @@ Required properties:
 			with the Wakeup M3 processor
 - interrupts:		Contains the interrupt information for the wkup_m3
 			interrupt that signals the MPU.
-- ti,rproc:		phandle to the wkup_m3 rproc node so the IPC driver
+- rprocs:		phandle to the wkup_m3 rproc node so the IPC driver
 			can boot it.
 - mboxes:		phandles used by IPC framework to get correct mbox
 			channel for communication. Must point to appropriate
 			mbox_wkupm3 child node.
 
+Deprecated properties:
+----------------------
+- ti,rproc:		This property has been replaced with the "rprocs"
+			property.
+
 Example:
 --------
 /* AM33xx */
@@ -48,7 +53,7 @@ Example:
 				compatible = "ti,am3352-wkup-m3-ipc";
 				reg = <0x1324 0x24>;
 				interrupts = <78>;
-				ti,rproc = <&wkup_m3>;
+				rprocs = <&wkup_m3>;
 				mboxes = <&mailbox &mbox_wkupm3>;
 			};
 
diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 8823cc81ae45..86085f9bf6a8 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -1,7 +1,7 @@
 /*
  * AMx3 Wkup M3 IPC driver
  *
- * Copyright (C) 2015 Texas Instruments, Inc.
+ * Copyright (C) 2015-2016 Texas Instruments, Inc.
  *
  * Dave Gerlach <d-gerlach@ti.com>
  *
@@ -390,6 +390,8 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct task_struct *task;
 	struct wkup_m3_ipc *m3_ipc;
+	struct property *nprop, *oprop;
+	const char nprop_name[] = "rprocs";
 
 	m3_ipc = devm_kzalloc(dev, sizeof(*m3_ipc), GFP_KERNEL);
 	if (!m3_ipc)
@@ -415,6 +417,28 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* provide compatibility for older DTBs using ti,rproc property */
+	nprop = of_find_property(dev->of_node, "rprocs", NULL);
+	if (!nprop) {
+		oprop = of_find_property(dev->of_node, "ti,rproc", NULL);
+		if (!oprop) {
+			dev_err(&pdev->dev, "node is missing ti,rproc property\n");
+			return -ENODEV;
+		}
+
+		nprop = kzalloc(sizeof(*nprop) + sizeof(nprop_name),
+				GFP_KERNEL);
+		if (!nprop)
+			return -ENOMEM;
+
+		nprop->name = (char *)nprop + sizeof(*nprop);
+		snprintf(nprop->name, sizeof(nprop_name), nprop_name);
+		nprop->value = oprop->value;
+		nprop->length = oprop->length;
+		of_update_property(dev->of_node, nprop);
+		of_remove_property(dev->of_node, oprop);
+	}
+
 	m3_ipc->mbox_client.dev = dev;
 	m3_ipc->mbox_client.tx_done = NULL;
 	m3_ipc->mbox_client.tx_prepare = NULL;
-- 
2.9.0
