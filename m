From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 13/20] rtc: omap: add helper to read raw bcd time
Date: Tue, 21 Oct 2014 19:37:59 +0200
Message-ID: <1413913086-12730-14-git-send-email-johan@kernel.org>
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

Add helper to read raw BCD time that can be used in interrupt context.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index ee20f2d36065..bcdf3c596214 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -234,22 +234,24 @@ static void bcd2tm(struct rtc_time *tm)
 	tm->tm_year = bcd2bin(tm->tm_year) + 100;
 }
 
-
-static int omap_rtc_read_time(struct device *dev, struct rtc_time *tm)
+static void omap_rtc_read_time_raw(struct omap_rtc *rtc, struct rtc_time *tm)
 {
-	struct omap_rtc *rtc = dev_get_drvdata(dev);
-
-	/* we don't report wday/yday/isdst ... */
-	local_irq_disable();
-	rtc_wait_not_busy(rtc);
-
 	tm->tm_sec = rtc_read(rtc, OMAP_RTC_SECONDS_REG);
 	tm->tm_min = rtc_read(rtc, OMAP_RTC_MINUTES_REG);
 	tm->tm_hour = rtc_read(rtc, OMAP_RTC_HOURS_REG);
 	tm->tm_mday = rtc_read(rtc, OMAP_RTC_DAYS_REG);
 	tm->tm_mon = rtc_read(rtc, OMAP_RTC_MONTHS_REG);
 	tm->tm_year = rtc_read(rtc, OMAP_RTC_YEARS_REG);
+}
+
+static int omap_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct omap_rtc *rtc = dev_get_drvdata(dev);
 
+	/* we don't report wday/yday/isdst ... */
+	local_irq_disable();
+	rtc_wait_not_busy(rtc);
+	omap_rtc_read_time_raw(rtc, tm);
 	local_irq_enable();
 
 	bcd2tm(tm);
-- 
2.0.4
