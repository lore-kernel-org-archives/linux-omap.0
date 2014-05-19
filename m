From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv2 resend 07/11] ARM: OMAP3: Beagle: use PWM_LOOKUP to initialize struct pwm_lookup
Date: Mon, 19 May 2014 22:42:38 +0200
Message-ID: <1400532162-29483-8-git-send-email-alexandre.belloni@free-electrons.com>
References: <1400532162-29483-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1400532162-29483-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Bryan Wu <cooloney@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index f27e1ec90b5e..54c135a5b4f7 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -61,14 +61,8 @@
 
 static struct pwm_lookup pwm_lookup[] = {
 	/* LEDB -> PMU_STAT */
-	{
-		.provider = "twl-pwmled",
-		.index = 1,
-		.dev_id = "leds_pwm",
-		.con_id = "beagleboard::pmu_stat",
-		.period = 7812500,
-		.polarity = PWM_POLARITY_NORMAL,
-	},
+	PWM_LOOKUP("twl-pwmled", 1, "leds_pwm", "beagleboard::pmu_stat",
+		   7812500, PWM_POLARITY_NORMAL),
 };
 
 static struct led_pwm pwm_leds[] = {
-- 
1.9.1

