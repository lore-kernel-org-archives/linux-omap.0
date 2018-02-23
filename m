From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/12] bus: ti-sysc: Handle stdout-path for debug console
Date: Fri, 23 Feb 2018 13:00:51 -0800
Message-ID: <20180223210100.86732-4-tony@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180223210100.86732-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

If we have stdout-path specified for earlycon, we must prevent
the debug console from idling until runtime PM kicks in.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -206,6 +206,50 @@ static int sysc_parse_and_check_child_range(struct sysc *ddata)
 	return 0;
 }
 
+static struct device_node *stdout_path;
+
+static void sysc_init_stdout_path(struct sysc *ddata)
+{
+	struct device_node *np = NULL;
+	const char *uart;
+
+	if (IS_ERR(stdout_path))
+		return;
+
+	if (stdout_path)
+		return;
+
+	np = of_find_node_by_path("/chosen");
+	if (!np)
+		goto err;
+
+	uart = of_get_property(np, "stdout-path", NULL);
+	if (!uart)
+		goto err;
+
+	np = of_find_node_by_path(uart);
+	if (!np)
+		goto err;
+
+	stdout_path = np;
+
+	return;
+
+err:
+	stdout_path = ERR_PTR(-ENODEV);
+}
+
+static void sysc_check_quirk_stdout(struct sysc *ddata,
+				    struct device_node *np)
+{
+	sysc_init_stdout_path(ddata);
+	if (np != stdout_path)
+		return;
+
+	ddata->cfg.quirks |= SYSC_QUIRK_NO_IDLE_ON_INIT |
+				SYSC_QUIRK_NO_RESET_ON_INIT;
+}
+
 /**
  * sysc_check_one_child - check child configuration
  * @ddata: device driver data
@@ -224,6 +268,8 @@ static int sysc_check_one_child(struct sysc *ddata,
 	if (name)
 		dev_warn(ddata->dev, "really a child ti,hwmods property?");
 
+	sysc_check_quirk_stdout(ddata, np);
+
 	return 0;
 }
 
-- 
2.16.2
