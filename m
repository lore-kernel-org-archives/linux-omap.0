From: David Rivshin <drivshin@awxrd.com>
Subject: [PATCH] pwm: pwm-omap-dmtimer: return -EPROBE_DEFER if no dmtimer
 platform data
Date: Thu, 12 Jul 2018 13:28:53 -0400
Message-ID: <20180712172853.22293-1-drivshin@awxrd.com>
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
To: Thierry Reding <thierry.reding@gmail.com>, Keerthy <j-keerthy@ti.com>, Ladislav Michl <ladis@linux-mips.org>, Neil Armstrong <narmstrong@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-pwm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: David Rivshin <DRivshin@allworx.com>

If a pwm-omap-dmtimer is probed before the dmtimer it uses, the platform
data won't be set yet.

Fixes: ac30751df953 ("ARM: OMAP: pdata-quirks: Remove unused timer pdata")
Cc: <stable@vger.kernel.org> # 4.17+
Signed-off-by: David Rivshin <drivshin@allworx.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 665da3c8fbceb..d3d7ea7a53146 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -264,8 +264,9 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
 	timer_pdata = dev_get_platdata(&timer_pdev->dev);
 	if (!timer_pdata) {
-		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
-		ret = -EINVAL;
+		dev_info(&pdev->dev,
+			 "dmtimer pdata structure NULL, deferring probe\n");
+		ret = -EPROBE_DEFER;
 		goto put;
 	}
 

base-commit: 1e4b044d22517cae7047c99038abb444423243ca
-- 
2.17.1
