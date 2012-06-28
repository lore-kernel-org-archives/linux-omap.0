From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] drivers/rtc/rtc-twl.c: fix threaded IRQ to use IRQF_ONESHOT
Date: Thu, 28 Jun 2012 09:17:45 -0700
Message-ID: <1340900265-11962-1-git-send-email-khilman@ti.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rtc-linux@googlegroups.com, linux-omap@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Requesting a threaded interrupt without a primary handler and without
IRQF_ONESHOT is dangerous, and after commit 1c6c6952 (genirq: Reject
bogus threaded irq requests), these requests are rejected.  This
causes ->probe() to fail, and the RTC driver not to be availble.

To fix, add IRQF_ONESHOT to the IRQ flags.

Tested on OMAP3730/OveroSTORM and OMAP4430/Panda board using rtcwake
to wake from system suspend multiple times.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
This fix is needed in v3.5.
Applies on top of v3.5-rc4.

 drivers/rtc/rtc-twl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 258abea..c5d06fe 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -510,7 +510,7 @@ static int __devinit twl_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = request_threaded_irq(irq, NULL, twl_rtc_interrupt,
-				   IRQF_TRIGGER_RISING,
+				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 				   dev_name(&rtc->dev), rtc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "IRQ is not free.\n");
-- 
1.7.9.2
