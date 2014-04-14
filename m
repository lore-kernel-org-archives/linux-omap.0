From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv2 02/11] ARM: shmobile: Armadillo 800 EVA: initialize all
 struct pwm_lookup members
Date: Mon, 14 Apr 2014 23:59:44 +0200
Message-ID: <1397512793-10325-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Bryan Wu <cooloney@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Simon Horman <horms@verge.net.au>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-leds@vger.kernel.org, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Initializing all the struct pwm_lookup members allows to get rid of the struct
tpu_pwm_platform_data as the polarity initialization will be taken care of by
the PWM core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 2858f380beae..1bf61dad9a35 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -31,7 +31,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/regulator/driver.h>
 #include <linux/pinctrl/machine.h>
-#include <linux/platform_data/pwm-renesas-tpu.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/gpio-regulator.h>
@@ -399,24 +399,22 @@ static struct resource pwm_resources[] = {
 	},
 };
 
-static struct tpu_pwm_platform_data pwm_device_data = {
-	.channels[2] = {
-		.polarity = PWM_POLARITY_INVERSED,
-	}
-};
-
 static struct platform_device pwm_device = {
 	.name = "renesas-tpu-pwm",
 	.id = -1,
-	.dev = {
-		.platform_data = &pwm_device_data,
-	},
 	.num_resources = ARRAY_SIZE(pwm_resources),
 	.resource = pwm_resources,
 };
 
 static struct pwm_lookup pwm_lookup[] = {
-	PWM_LOOKUP("renesas-tpu-pwm", 2, "pwm-backlight.0", NULL),
+	{
+		.provider = "renesas-tpu-pwm",
+		.index = 2,
+		.dev_id = "pwm-backlight.0",
+		.con_id = NULL,
+		.period = 33333,
+		.polarity = PWM_POLARITY_INVERSED,
+	},
 };
 
 /* LCDC and backlight */
-- 
1.8.3.2
