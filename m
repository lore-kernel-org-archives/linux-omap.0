From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 15/18] ARM: mach-pnx4008: remove including old leds event API header file
Date: Fri, 30 Mar 2012 19:58:30 +0800
Message-ID: <1333108713-12707-16-git-send-email-bryan.wu@canonical.com>
References: <1333108713-12707-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1333108713-12707-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, rpurdie@rpsys.net, manuel.lauss@gmail.com, cjb@laptop.org, cbou@mail.ru, dwmw2@infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-pnx4008/time.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pnx4008/time.c b/arch/arm/mach-pnx4008/time.c
index 0cfe8af..47a7ae9 100644
--- a/arch/arm/mach-pnx4008/time.c
+++ b/arch/arm/mach-pnx4008/time.c
@@ -25,7 +25,6 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <asm/leds.h>
 #include <asm/mach/time.h>
 #include <asm/errno.h>
 
-- 
1.7.9.1
