From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 14/18] ARM: plat-samsung: remove including old leds event API header file
Date: Fri, 30 Mar 2012 19:58:29 +0800
Message-ID: <1333108713-12707-15-git-send-email-bryan.wu@canonical.com>
References: <1333108713-12707-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1333108713-12707-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, rpurdie@rpsys.net, manuel.lauss@gmail.com, cjb@laptop.org, cbou@mail.ru, dwmw2@infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/plat-samsung/time.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/time.c b/arch/arm/plat-samsung/time.c
index 4dcb11c..60552e2 100644
--- a/arch/arm/plat-samsung/time.c
+++ b/arch/arm/plat-samsung/time.c
@@ -28,7 +28,6 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
-#include <asm/leds.h>
 #include <asm/mach-types.h>
 
 #include <asm/irq.h>
-- 
1.7.9.1
