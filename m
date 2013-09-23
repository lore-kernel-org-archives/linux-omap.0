From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 07/10] unicore32: Initialize PWM backlight enable_gpio field
Date: Mon, 23 Sep 2013 23:41:04 +0200
Message-ID: <1379972467-11243-8-git-send-email-treding@nvidia.com>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379972467-11243-1-git-send-email-treding@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, openezx-devel@lists.openezx.org, linux-samsung-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The GPIO API defines 0 as being a valid GPIO number, so this field needs
to be initialized explicitly.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/unicore32/kernel/puv3-nb0916.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/unicore32/kernel/puv3-nb0916.c b/arch/unicore32/kernel/puv3-nb0916.c
index 181108b..0c6618e 100644
--- a/arch/unicore32/kernel/puv3-nb0916.c
+++ b/arch/unicore32/kernel/puv3-nb0916.c
@@ -54,6 +54,7 @@ static struct platform_pwm_backlight_data nb0916_backlight_data = {
 	.max_brightness	= 100,
 	.dft_brightness	= 100,
 	.pwm_period_ns	= 70 * 1024,
+	.enable_gpio	= -1,
 };
 
 static struct gpio_keys_button nb0916_gpio_keys[] = {
-- 
1.8.4
