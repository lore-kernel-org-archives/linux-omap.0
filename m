From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv2 resend 05/11] ARM: pxa: hx4700: initialize all the struct pwm_lookup members
Date: Mon, 19 May 2014 22:42:36 +0200
Message-ID: <1400532162-29483-6-git-send-email-alexandre.belloni@free-electrons.com>
References: <1400532162-29483-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1400532162-29483-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Bryan Wu <cooloney@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

This will allow to get rid of the .pwm_period_ns member of struct
platform_pwm_backlight_data as the period will be set by the PWM core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-pxa/hx4700.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index a7c30eb0c8db..0788a1f171fe 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -574,7 +574,14 @@ static struct platform_device backlight = {
 };
 
 static struct pwm_lookup hx4700_pwm_lookup[] = {
-	PWM_LOOKUP("pxa27x-pwm.1", 0, "pwm-backlight", NULL),
+	{
+		.provider = "pxa27x-pwm.1",
+		.index = 0,
+		.dev_id = "pwm-backlight",
+		.con_id = NULL,
+		.period = 30923,
+		.polarity = PWM_POLARITY_NORMAL,
+	},
 };
 
 /*
-- 
1.9.1

