From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] RTC: TWL: ensure all interrupts are disabled during probe
Date: Thu, 13 Sep 2012 13:45:57 -0700
Message-ID: <1347569157-19262-1-git-send-email-khilman@deeprootsystems.com>
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
To: Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

From: Kevin Hilman <khilman@ti.com>

On some platforms, bootloaders are known to do some interesting RTC
programming.  Without going into the obscurities as to why this may be
the case, suffice it to say the the driver should not make any
assumptions about the state of the RTC when the driver loads.  In
particular, the driver probe should be sure that all interrupts are
disabled until otherwise programmed.

This was discovered when finding bursty I2C traffic every second on
Overo platforms.  This I2C overhead was keeping the SoC from hitting
deep power states.  The cause was found to be the RTC firing every
second on the I2C-connected TWL PMIC.

Special thanks to Felipe Balbi for suggesting to look for a rogue
driver as the source of the I2C traffic rather than the I2C driver
itself.

Special thanks to Steve Sakoman for helping track down the source of
the continuous RTC interrups on the Overo boards.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Patch applies to v3.6-rc5

 drivers/rtc/rtc-twl.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index c5d06fe..9277d94 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -495,6 +495,11 @@ static int __devinit twl_rtc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out1;
 
+	/* ensure interrupts are disabled, bootloaders can be strange */
+	ret = twl_rtc_write_u8(0, REG_RTC_INTERRUPTS_REG);
+	if (ret < 0)
+		dev_warn(&pdev->dev, "unable to disable interrupt\n");
+
 	/* init cached IRQ enable bits */
 	ret = twl_rtc_read_u8(&rtc_irq_bits, REG_RTC_INTERRUPTS_REG);
 	if (ret < 0)
-- 
1.7.9.2
