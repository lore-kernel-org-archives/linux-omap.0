From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH RESEND 2/2] soc: ti: wkup_m3_ipc: Add wkup_m3_request_wake_src
Date: Thu, 21 Jun 2018 14:52:34 +0530
Message-ID: <1529572954-22244-2-git-send-email-j-keerthy@ti.com>
References: <1529572954-22244-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1529572954-22244-1-git-send-email-j-keerthy@ti.com>
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

From: Dave Gerlach <d-gerlach@ti.com>

Add wkup_m3_request_wake_src to allow users to get the name of
the wakeup source after a DeepSleep or Standby transition.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---

This is tested on am437x-gp-evm and target for 4.19

 drivers/soc/ti/wkup_m3_ipc.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/wkup_m3_ipc.h  |  6 ++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index b732c39..6840688 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -46,6 +46,7 @@
 #define M3_BASELINE_VERSION		0x191
 #define M3_STATUS_RESP_MASK		(0xffff << 16)
 #define M3_FW_VERSION_MASK		0xffff
+#define M3_WAKE_SRC_MASK		0xff
 
 #define M3_STATE_UNKNOWN		0
 #define M3_STATE_RESET			1
@@ -55,6 +56,23 @@
 
 static struct wkup_m3_ipc *m3_ipc_state;
 
+static const struct wkup_m3_wakeup_src wakeups[] = {
+	{.irq_nr = 35,	.src = "USB0_PHY"},
+	{.irq_nr = 36,	.src = "USB1_PHY"},
+	{.irq_nr = 40,	.src = "I2C0"},
+	{.irq_nr = 41,	.src = "RTC Timer"},
+	{.irq_nr = 42,	.src = "RTC Alarm"},
+	{.irq_nr = 43,	.src = "Timer0"},
+	{.irq_nr = 44,	.src = "Timer1"},
+	{.irq_nr = 45,	.src = "UART"},
+	{.irq_nr = 46,	.src = "GPIO0"},
+	{.irq_nr = 48,	.src = "MPU_WAKE"},
+	{.irq_nr = 49,	.src = "WDT0"},
+	{.irq_nr = 50,	.src = "WDT1"},
+	{.irq_nr = 51,	.src = "ADC_TSC"},
+	{.irq_nr = 0,	.src = "Unknown"},
+};
+
 static void am33xx_txev_eoi(struct wkup_m3_ipc *m3_ipc)
 {
 	writel(AM33XX_M3_TXEV_ACK,
@@ -330,6 +348,26 @@ static int wkup_m3_finish_low_power(struct wkup_m3_ipc *m3_ipc)
 }
 
 /**
+ * wkup_m3_request_wake_src - Get the wakeup source info passed from wkup_m3
+ * @m3_ipc: Pointer to wkup_m3_ipc context
+ */
+static const char *wkup_m3_request_wake_src(struct wkup_m3_ipc *m3_ipc)
+{
+	unsigned int wakeup_src_idx;
+	int j, val;
+
+	val = wkup_m3_ctrl_ipc_read(m3_ipc, 6);
+
+	wakeup_src_idx = val & M3_WAKE_SRC_MASK;
+
+	for (j = 0; j < ARRAY_SIZE(wakeups) - 1; j++) {
+		if (wakeups[j].irq_nr == wakeup_src_idx)
+			return wakeups[j].src;
+	}
+	return wakeups[j].src;
+}
+
+/**
  * wkup_m3_set_rtc_only - Set the rtc_only flag
  * @wkup_m3_wakeup: struct wkup_m3_wakeup_src * gets assigned the
  *                  wakeup src value
@@ -346,6 +384,7 @@ static void wkup_m3_set_rtc_only(struct wkup_m3_ipc *m3_ipc)
 	.prepare_low_power = wkup_m3_prepare_low_power,
 	.finish_low_power = wkup_m3_finish_low_power,
 	.request_pm_status = wkup_m3_request_pm_status,
+	.request_wake_src = wkup_m3_request_wake_src,
 	.set_rtc_only = wkup_m3_set_rtc_only,
 };
 
diff --git a/include/linux/wkup_m3_ipc.h b/include/linux/wkup_m3_ipc.h
index d639df1..e497e62 100644
--- a/include/linux/wkup_m3_ipc.h
+++ b/include/linux/wkup_m3_ipc.h
@@ -43,12 +43,18 @@ struct wkup_m3_ipc {
 	int is_rtc_only;
 };
 
+struct wkup_m3_wakeup_src {
+	int irq_nr;
+	char src[10];
+};
+
 struct wkup_m3_ipc_ops {
 	void (*set_mem_type)(struct wkup_m3_ipc *m3_ipc, int mem_type);
 	void (*set_resume_address)(struct wkup_m3_ipc *m3_ipc, void *addr);
 	int (*prepare_low_power)(struct wkup_m3_ipc *m3_ipc, int state);
 	int (*finish_low_power)(struct wkup_m3_ipc *m3_ipc);
 	int (*request_pm_status)(struct wkup_m3_ipc *m3_ipc);
+	const char *(*request_wake_src)(struct wkup_m3_ipc *m3_ipc);
 	void (*set_rtc_only)(struct wkup_m3_ipc *m3_ipc);
 };
 
-- 
1.9.1
