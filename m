From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/3] ARM: pxa: add module.h for corgi symbol_get/symbol_put usage
Date: Wed, 20 Jul 2016 00:13:31 -0400
Message-ID: <20160720041332.30789-3-paul.gortmaker@windriver.com>
References: <20160720041332.30789-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160720041332.30789-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

During unrelated work, attempting to remove an include of the
linux/module.h in favour of "struct module;" in order to reduce
header entanglement, we found doing so caused a build failure in
this file.

mach-pxa/corgi.c: In function 'corgi_bl_kick_battery':
mach-pxa/corgi.c:548:2: error: implicit declaration of function 'symbol_get' [-Werror=implicit-function-declaration]
mach-pxa/corgi.c:548:12: warning: assignment makes pointer from integer without a cast [enabled by default]
mach-pxa/corgi.c:551:3: error: implicit declaration of function 'symbol_put' [-Werror=implicit-function-declaration]

It turns out this file uses symbol_get/symbol_put which live in the
module.h header, but it wasn't including module.h -- which was
being masked by the module.h in include/linux/gpio/driver.h - the
one we want to remove/replace.

With ARM and GPIO being different subsystems, we'll need to get
this in ARM 1st, and then wait a release before changing the GPIO
header, otherwise we'll risk triggering build failures.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arm/mach-pxa/corgi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index aa952979461f..183cd3446f25 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>	/* symbol_get ; symbol_put */
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/major.h>
-- 
2.8.4
