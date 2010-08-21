From: hvaibhav@ti.com
Subject: [PATCH-V2 3/3] RTC:s35390a: Add update_irq (per Min interrupt) support
Date: Sat, 21 Aug 2010 18:00:29 +0530
Message-ID: <1282393829-7326-4-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, byron.bbradley@gmail.com, linux-omap@vger.kernel.org, felipe.balbi@nokia.com, Vaibhav Hiremath <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Vaibhav Hiremath <hvaibhav@ti.com>

S35390A RTC supports per minute steady interrupt, after configuration
device steadily keeps on generating interrupts every minute. So add
related RTC API's -
	- update_irq_enable

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 drivers/rtc/rtc-s35390a.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index d8d59d7..34c9c47 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -390,6 +390,35 @@ static int s35390a_rtc_set_irq_freq(struct device *dev, int freq)
 	return s35390a_set_irq_freq(to_i2c_client(dev), freq);
 }

+static int s35390a_update_irq_enable(struct i2c_client *client,
+						unsigned enabled)
+{
+	struct s35390a *s35390a = i2c_get_clientdata(client);
+	char buf[1];
+
+	if (s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, buf, sizeof(buf)) < 0)
+		return -EIO;
+
+	/* This chip returns the bits of each byte in reverse order */
+	buf[0] = bitrev8(buf[0]);
+
+	buf[0] &= ~S35390A_INT1_MODE_MASK;
+	if (enabled)
+		buf[0] |= S35390A_INT1_MODE_PMIN_STDY;
+	else
+		buf[0] |= S35390A_INT1_MODE_NOINTR;
+
+	/* This chip expects the bits of each byte in reverse order */
+	buf[0] = bitrev8(buf[0]);
+
+	return s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, buf, sizeof(buf));
+}
+
+static int s35390a_rtc_update_irq_enable(struct device *dev, unsigned enabled)
+{
+	return s35390a_update_irq_enable(to_i2c_client(dev), enabled);
+}
+
 static irqreturn_t s35390a_irq_thread(int irq, void *handle)
 {
 	char buf[1];
@@ -406,6 +435,8 @@ static irqreturn_t s35390a_irq_thread(int irq, void *handle)
 	if (buf[0] & BIT(2)) {
 		rtc_update_irq(s35390a->rtc, 1, RTC_IRQF | RTC_AF);
 		s35390a_alarm_irq_enable(client, 0);
+	} else if (buf[0] & BIT(1)) {
+		rtc_update_irq(s35390a->rtc, 1, RTC_IRQF | RTC_UF);
 	} else if (buf[0] & BIT(0)) {
 		rtc_update_irq(s35390a->rtc, 1, RTC_IRQF | RTC_PF);
 	}
@@ -422,6 +453,7 @@ static const struct rtc_class_ops s35390a_rtc_ops = {
 	.read_alarm		= s35390a_rtc_read_alarm,
 	.irq_set_freq		= s35390a_rtc_set_irq_freq,
 	.irq_set_state		= s35390a_rtc_freq_irq_enable,
+	.update_irq_enable	= s35390a_rtc_update_irq_enable,
 };

 static struct i2c_driver s35390a_driver;
--
1.6.2.4
