From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/12] bus: ti-sysc: Add suspend and resume handling
Date: Fri, 23 Feb 2018 13:00:50 -0800
Message-ID: <20180223210100.86732-3-tony@atomide.com>
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

This allows us to idle the module on suspend after the children
are suspended.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -58,6 +58,7 @@ static const char * const clock_names[] = { "fck", "ick", };
  * @cfg: interconnect target module configuration
  * @name: name if available
  * @revision: interconnect target module revision
+ * @needs_resume: runtime resume needed on resume from suspend
  */
 struct sysc {
 	struct device *dev;
@@ -71,6 +72,8 @@ struct sysc {
 	struct sysc_config cfg;
 	const char *name;
 	u32 revision;
+	bool enabled;
+	bool needs_resume;
 };
 
 static u32 sysc_read(struct sysc *ddata, int offset)
@@ -497,7 +500,38 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int sysc_suspend(struct device *dev)
+{
+	struct sysc *ddata;
+
+	ddata = dev_get_drvdata(dev);
+
+	if (!ddata->enabled)
+		return 0;
+
+	ddata->needs_resume = true;
+
+	return sysc_runtime_suspend(dev);
+}
+
+static int sysc_resume(struct device *dev)
+{
+	struct sysc *ddata;
+
+	ddata = dev_get_drvdata(dev);
+	if (ddata->needs_resume) {
+		ddata->needs_resume = false;
+
+		return sysc_runtime_resume(dev);
+	}
+
+	return 0;
+}
+#endif
+
 static const struct dev_pm_ops sysc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sysc_suspend, sysc_resume)
 	SET_RUNTIME_PM_OPS(sysc_runtime_suspend,
 			   sysc_runtime_resume,
 			   NULL)
-- 
2.16.2
