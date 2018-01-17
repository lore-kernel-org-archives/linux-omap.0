From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 1/3] clocksource: timer-dm: Check prescaler value
Date: Wed, 17 Jan 2018 22:47:14 +0100
Message-ID: <20180117214714.GB11952@lenoch>
References: <20180117214629.GA11952@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180117214629.GA11952@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: t-kristo@ti.com, grygorii.strashko@ti.com, aaro.koskinen@iki.fi, tony@atomide.com, Keerthy <j-keerthy@ti.com>, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, narmstrong@baylibre.com, thierry.reding@gmail.com, sebastian.reichel@collabora.co.uk, Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Invalid value silently disables use of the prescaler.
Use -1 explicitely for that purpose and error out on
invalid value.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/clocksource/timer-dm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
index 60db1734ea3b..324ec93d3dd2 100644
--- a/drivers/clocksource/timer-dm.c
+++ b/drivers/clocksource/timer-dm.c
@@ -663,13 +663,13 @@ int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 {
 	u32 l;
 
-	if (unlikely(!timer))
+	if (unlikely(!timer) || prescaler < -1 || prescaler > 7)
 		return -EINVAL;
 
 	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
-	if (prescaler >= 0x00 && prescaler <= 0x07) {
+	if (prescaler >= 0) {
 		l |= OMAP_TIMER_CTRL_PRE;
 		l |= prescaler << 2;
 	}
