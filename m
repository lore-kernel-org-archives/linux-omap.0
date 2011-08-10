From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib implementations
Date: Wed, 10 Aug 2011 09:54:52 +0200
Message-ID: <CAKnu2Mofp+f7Khu1d0j9Pz3Pr03EawBgkRPWEqDy7mf4DzoETA@mail.gmail.com>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
	<E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

2011/8/9 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Consolidate 24 trivial gpiolib implementions out of mach/gpio.h
> into asm/gpio.h. =A0This is basically the include of asm-generic/gpio=
=2Eh
> and the definition of gpio_get_value, gpio_set_value, and gpio_cansle=
ep
> as described in Documentation/gpio.txt
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

reaks compile of plat-nomadik due to missing u32, feel free to fold in
the below fix. With that it's
Tested-by: Linus Walleij <linus.walleij@linaro.org>
for Nomadik, U300 and Ux500.

=46rom 2e4496fc7643d804ccf50a8efe1a0304210176d1 Mon Sep 17 00:00:00 200=
1
=46rom: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 10 Aug 2011 09:51:16 +0200
Subject: [PATCH] plat-nomadik: small fixup for gpio.h

Removing the generic gpio.h broke compilation of the Nomadik
GPIO driver since it implicitly got u32 from it. Explicitly
include <linux/kernel.h> so we get u32 defined.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-nomadik/include/plat/gpio.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-nomadik/include/plat/gpio.h
b/arch/arm/plat-nomadik/include/plat/gpio.h
index cf0b78b..b894a53 100644
--- a/arch/arm/plat-nomadik/include/plat/gpio.h
+++ b/arch/arm/plat-nomadik/include/plat/gpio.h
@@ -12,6 +12,8 @@
 #ifndef __ASM_PLAT_GPIO_H
 #define __ASM_PLAT_GPIO_H

+#include <linux/kernel.h>
+
 /*
  * "nmk_gpio" and "NMK_GPIO" stand for "Nomadik GPIO", leaving
  * the "gpio" namespace for generic and cross-machine functions
--=20
1.7.3.2

Thanks,
Linus Walleij
