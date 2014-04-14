From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv2 08/11] ARM: shmobile: Armadillo 800 EVA: use PWM_LOOKUP to initialize struct pwm_lookup
Date: Mon, 14 Apr 2014 23:59:50 +0200
Message-ID: <1397512793-10325-9-git-send-email-alexandre.belloni@free-electrons.com>
References: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Bryan Wu <cooloney@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 1bf61dad9a35..ca82b1e2ebab 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -407,14 +407,8 @@ static struct platform_device pwm_device = {
 };
 
 static struct pwm_lookup pwm_lookup[] = {
-	{
-		.provider = "renesas-tpu-pwm",
-		.index = 2,
-		.dev_id = "pwm-backlight.0",
-		.con_id = NULL,
-		.period = 33333,
-		.polarity = PWM_POLARITY_INVERSED,
-	},
+	PWM_LOOKUP("renesas-tpu-pwm", 2, "pwm-backlight.0", NULL,
+		   33333, PWM_POLARITY_INVERSED),
 };
 
 /* LCDC and backlight */
-- 
1.8.3.2

