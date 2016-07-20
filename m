From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/3] ARM: mach-omap2: remove bogus "or_module" from rx51-peripherals
Date: Wed, 20 Jul 2016 00:13:30 -0400
Message-ID: <20160720041332.30789-2-paul.gortmaker@windriver.com>
References: <20160720041332.30789-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160720041332.30789-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

During unrelated work, attempting to remove an include of the
linux/module.h in favour of "struct module;" in order to reduce
header entanglement, we found doing so caused a build failure in
this file.

It turns out this file uses __init_or_module which lives in the
module.h header, but it wasn't including module.h -- which was
being masked by the module.h in include/linux/gpio/driver.h - the
one we want to remove/replace.

However, if we dig into Makefile / Kconfig we find:

mach-omap2/board-rx51-peripherals.o ---->
   mach-omap2/Makefile:obj-$(CONFIG_MACH_NOKIA_RX51) += board-rx51-peripherals.o

arch/arm/mach-omap2/Kconfig:config MACH_NOKIA_RX51
arch/arm/mach-omap2/Kconfig:    bool "Nokia N900 (RX-51) phone"

...and hence the __init_or_module is pointless, as it will always
evaluate to plain __init.

With ARM and GPIO being different subsystems, we'll need to get
this in ARM 1st, and then wait a release before changing the GPIO
header, otherwise we'll risk triggering build failures.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index a5ab712c1a59..4ddda1d33ec1 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -978,7 +978,7 @@ static struct twl4030_platform_data rx51_twldata __initdata = {
 	.vio			= &rx51_vio,
 };
 
-static struct tpa6130a2_platform_data rx51_tpa6130a2_data __initdata_or_module = {
+static struct tpa6130a2_platform_data rx51_tpa6130a2_data __initdata = {
 	.power_gpio		= 98,
 };
 
-- 
2.8.4
