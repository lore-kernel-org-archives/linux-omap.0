From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH RESEND 1/2] ti: wkup_m3_ipc: Add rtc_only with ddr in self
 refresh mode support
Date: Thu, 21 Jun 2018 14:52:33 +0530
Message-ID: <1529572954-22244-1-git-send-email-j-keerthy@ti.com>
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
To: santosh.shilimkar@oracle.com
Cc: t-kristo@ti.com, j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org

Adds rtc_only support. This needs resume function to shutdown and
reboot the m3.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

This is tested on am437x-gp-evm and target for 4.19

 drivers/soc/ti/wkup_m3_ipc.c | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/wkup_m3_ipc.h  |  3 +++
 2 files changed, 44 insertions(+)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 369aef5..b732c39 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -329,12 +329,24 @@ static int wkup_m3_finish_low_power(struct wkup_m3_ipc *m3_ipc)
 	return 0;
 }
 
+/**
+ * wkup_m3_set_rtc_only - Set the rtc_only flag
+ * @wkup_m3_wakeup: struct wkup_m3_wakeup_src * gets assigned the
+ *                  wakeup src value
+ */
+static void wkup_m3_set_rtc_only(struct wkup_m3_ipc *m3_ipc)
+{
+	if (m3_ipc_state)
+		m3_ipc_state->is_rtc_only = true;
+}
+
 static struct wkup_m3_ipc_ops ipc_ops = {
 	.set_mem_type = wkup_m3_set_mem_type,
 	.set_resume_address = wkup_m3_set_resume_address,
 	.prepare_low_power = wkup_m3_prepare_low_power,
 	.finish_low_power = wkup_m3_finish_low_power,
 	.request_pm_status = wkup_m3_request_pm_status,
+	.set_rtc_only = wkup_m3_set_rtc_only,
 };
 
 /**
@@ -484,6 +496,32 @@ static int wkup_m3_ipc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int wkup_m3_ipc_suspend(struct device *dev)
+{
+	/*
+	 * Nothing needs to be done on suspend even with rtc_only flag set
+	 */
+	return 0;
+}
+
+static int wkup_m3_ipc_resume(struct device *dev)
+{
+	if (m3_ipc_state->is_rtc_only) {
+		rproc_shutdown(m3_ipc_state->rproc);
+		rproc_boot(m3_ipc_state->rproc);
+	}
+
+	m3_ipc_state->is_rtc_only = false;
+
+	return 0;
+}
+
+static const struct dev_pm_ops wkup_m3_ipc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(wkup_m3_ipc_suspend, wkup_m3_ipc_resume)
+};
+#endif
+
 static const struct of_device_id wkup_m3_ipc_of_match[] = {
 	{ .compatible = "ti,am3352-wkup-m3-ipc", },
 	{ .compatible = "ti,am4372-wkup-m3-ipc", },
@@ -497,6 +535,9 @@ static int wkup_m3_ipc_remove(struct platform_device *pdev)
 	.driver = {
 		.name = "wkup_m3_ipc",
 		.of_match_table = wkup_m3_ipc_of_match,
+#ifdef CONFIG_PM
+		.pm = &wkup_m3_ipc_pm_ops,
+#endif
 	},
 };
 
diff --git a/include/linux/wkup_m3_ipc.h b/include/linux/wkup_m3_ipc.h
index d6ba7d3..d639df1 100644
--- a/include/linux/wkup_m3_ipc.h
+++ b/include/linux/wkup_m3_ipc.h
@@ -40,6 +40,7 @@ struct wkup_m3_ipc {
 	struct mbox_chan *mbox;
 
 	struct wkup_m3_ipc_ops *ops;
+	int is_rtc_only;
 };
 
 struct wkup_m3_ipc_ops {
@@ -48,8 +49,10 @@ struct wkup_m3_ipc_ops {
 	int (*prepare_low_power)(struct wkup_m3_ipc *m3_ipc, int state);
 	int (*finish_low_power)(struct wkup_m3_ipc *m3_ipc);
 	int (*request_pm_status)(struct wkup_m3_ipc *m3_ipc);
+	void (*set_rtc_only)(struct wkup_m3_ipc *m3_ipc);
 };
 
 struct wkup_m3_ipc *wkup_m3_ipc_get(void);
 void wkup_m3_ipc_put(struct wkup_m3_ipc *m3_ipc);
+void wkup_m3_set_rtc_only_mode(void);
 #endif /* _LINUX_WKUP_M3_IPC_H */
-- 
1.9.1
