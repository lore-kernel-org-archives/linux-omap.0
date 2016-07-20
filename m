From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/3] ARM: pxa: add module.h for spitz symbol_get/symbol_put
 usage
Date: Wed, 20 Jul 2016 00:13:32 -0400
Message-ID: <20160720041332.30789-4-paul.gortmaker@windriver.com>
References: <20160720041332.30789-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160720041332.30789-1-paul.gortmaker@windriver.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: linux-omap@vger.kernel.org

During unrelated work, attempting to remove an include of the
linux/module.h in favour of "struct module;" in order to reduce
header entanglement, we found doing so caused a build failure in
this file.

mach-pxa/spitz.c: In function 'spitz_bl_kick_battery':
mach-pxa/spitz.c:524:2: error: implicit declaration of function 'symbol_get' [-Werror=implicit-function-declaration]
mach-pxa/spitz.c:524:12: warning: assignment makes pointer from integer without a cast [enabled by default]
mach-pxa/spitz.c:527:3: error: implicit declaration of function 'symbol_put' [-Werror=implicit-function-declaration]

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
 arch/arm/mach-pxa/spitz.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index b410698808ca..8078e3cdb6c8 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>	/* symbol_get ; symbol_put */
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/gpio_keys.h>
-- 
2.8.4
