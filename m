From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv2 resend 09/11] ARM: pxa: hx4700: use PWM_LOOKUP to initialize struct pwm_lookup
Date: Mon, 19 May 2014 22:42:40 +0200
Message-ID: <1400532162-29483-10-git-send-email-alexandre.belloni@free-electrons.com>
References: <1400532162-29483-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55031 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751773AbaESUnn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 16:43:43 -0400
In-Reply-To: <1400532162-29483-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Bryan Wu <cooloney@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

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
1.9.1

