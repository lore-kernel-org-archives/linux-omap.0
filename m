From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv2 09/11] ARM: pxa: hx4700: use PWM_LOOKUP to initialize struct pwm_lookup
Date: Mon, 14 Apr 2014 23:59:51 +0200
Message-ID: <1397512793-10325-10-git-send-email-alexandre.belloni@free-electrons.com>
References: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-sh-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Bryan Wu <cooloney@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-pxa/hx4700.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 0788a1f171fe..c66ad4edc5e3 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -574,14 +574,8 @@ static struct platform_device backlight = {
 };
 
 static struct pwm_lookup hx4700_pwm_lookup[] = {
-	{
-		.provider = "pxa27x-pwm.1",
-		.index = 0,
-		.dev_id = "pwm-backlight",
-		.con_id = NULL,
-		.period = 30923,
-		.polarity = PWM_POLARITY_NORMAL,
-	},
+	PWM_LOOKUP("pxa27x-pwm.1", 0, "pwm-backlight", NULL,
+		   30923, PWM_POLARITY_NORMAL),
 };
 
 /*
-- 
1.8.3.2

