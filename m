From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 12/20] rtc: omap: silence bogus power-up reset message at
 probe
Date: Tue, 21 Oct 2014 19:37:58 +0200
Message-ID: <1413913086-12730-13-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1413913086-12730-1-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1413913086-12730-1-git-send-email-johan@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alessandro Zummo <a.zummo@towertech.it>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Felipe Balbi <balbi@ti.com>
Cc: devicetree@vger.kernel.org, rtc-linux@googlegroups.com, Lokesh Vutla <lokeshvutla@ti.com>, j-keerthy@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, t-kristo@ti.com, linux-arm-kernel@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

Some legacy RTC IP revisions has a power-up reset flag in the status
register that later revisions lack.

As this flag is always read back as set on later revisions (or is
overloaded with a different flag), make sure to only clear the flag and
print the info message on legacy platforms.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 1abd88e24c22..ee20f2d36065 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -106,6 +106,7 @@ struct omap_rtc_device_type {
 	bool has_32kclk_en;
 	bool has_kicker;
 	bool has_irqwakeen;
+	bool has_power_up_reset;
 };
 
 struct omap_rtc {
@@ -346,6 +347,7 @@ static struct rtc_class_ops omap_rtc_ops = {
 };
 
 static const struct omap_rtc_device_type omap_rtc_default_type = {
+	.has_power_up_reset = true,
 };
 
 static const struct omap_rtc_device_type omap_rtc_am3352_type = {
@@ -391,7 +393,7 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 {
 	struct omap_rtc		*rtc;
 	struct resource		*res;
-	u8			reg, new_ctrl;
+	u8			reg, mask, new_ctrl;
 	const struct platform_device_id *id_entry;
 	const struct of_device_id *of_id;
 	int ret;
@@ -448,12 +450,17 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 
 	/* clear old status */
 	reg = rtc_read(rtc, OMAP_RTC_STATUS_REG);
-	if (reg & (u8) OMAP_RTC_STATUS_POWER_UP) {
-		dev_info(&pdev->dev, "RTC power up reset detected\n");
-		rtc_write(rtc, OMAP_RTC_STATUS_REG, OMAP_RTC_STATUS_POWER_UP);
+
+	mask = OMAP_RTC_STATUS_ALARM;
+
+	if (rtc->type->has_power_up_reset) {
+		mask |= OMAP_RTC_STATUS_POWER_UP;
+		if (reg & OMAP_RTC_STATUS_POWER_UP)
+			dev_info(&pdev->dev, "RTC power up reset detected\n");
 	}
-	if (reg & (u8) OMAP_RTC_STATUS_ALARM)
-		rtc_write(rtc, OMAP_RTC_STATUS_REG, OMAP_RTC_STATUS_ALARM);
+
+	if (reg & mask)
+		rtc_write(rtc, OMAP_RTC_STATUS_REG, reg & mask);
 
 	/* On boards with split power, RTC_ON_NOFF won't reset the RTC */
 	reg = rtc_read(rtc, OMAP_RTC_CTRL_REG);
-- 
2.0.4
