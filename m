From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 16/20] rtc: omap: enable wake-up from power off
Date: Tue, 21 Oct 2014 19:38:02 +0200
Message-ID: <1413913086-12730-17-git-send-email-johan@kernel.org>
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

The ALARM interrupt must not be disabled during shutdown in order to be
able to power up the system using an RTC alarm.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index f6c93f877857..cb5ef3c845d1 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -687,8 +687,15 @@ static SIMPLE_DEV_PM_OPS(omap_rtc_pm_ops, omap_rtc_suspend, omap_rtc_resume);
 static void omap_rtc_shutdown(struct platform_device *pdev)
 {
 	struct omap_rtc *rtc = platform_get_drvdata(pdev);
+	u8 mask;
 
-	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
+	/*
+	 * Keep the ALARM interrupt enabled to allow the system to power up on
+	 * alarm events.
+	 */
+	mask = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
+	mask &= OMAP_RTC_INTERRUPTS_IT_ALARM;
+	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, mask);
 }
 
 static struct platform_driver omap_rtc_driver = {
-- 
2.0.4
