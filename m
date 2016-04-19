From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] rtc: ds1307: Use irq when available for wakeup-source device
Date: Tue, 19 Apr 2016 11:23:54 -0500
Message-ID: <1461083034-9227-1-git-send-email-nm@ti.com>
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
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>
Cc: Nishanth Menon <nm@ti.com>, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michael Lange <linuxstuff@milaw.biz>
List-Id: linux-omap@vger.kernel.org

With commit 8bc2a40730ec ("rtc: ds1307: add support for the
DT property 'wakeup-source'") we lost the ability for rtc irq
functionality for devices that are actually hooked on a real IRQ
line and have capability to wakeup as well. This is not an expected
behavior. So, instead of just not requesting IRQ, skip the IRQ
requirement only if interrupts are not defined for the device.

Fixes: 8bc2a40730ec ("rtc: ds1307: add support for the DT property 'wakeup-source'")
Reported-by: Tony Lindgren <tony@atomide.com>
Cc: Michael Lange <linuxstuff@milaw.biz>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index b2156ee5bae1..74cd5cd544ee 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1531,7 +1531,7 @@ read_rtc:
 		return PTR_ERR(ds1307->rtc);
 	}
 
-	if (ds1307_can_wakeup_device) {
+	if (ds1307_can_wakeup_device && ds1307->client->irq <= 0) {
 		/* Disable request for an IRQ */
 		want_irq = false;
 		dev_info(&client->dev, "'wakeup-source' is set, request for an IRQ is disabled!\n");
-- 
2.8.0
