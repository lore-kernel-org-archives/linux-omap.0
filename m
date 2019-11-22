From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 085/219] memory: omap-gpmc: Get the header of the enum
Date: Fri, 22 Nov 2019 00:46:57 -0500
Message-ID: <20191122054911.1750-78-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Ladislav Michl <ladis@linux-mips.org>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit a0752e9c3097b2c4fccd618802938e0951038dfa ]

Commit 21abf103818a
("gpio: Pass a flag to gpiochip_request_own_desc()")
started to pass an enum gpiod_flags but this file is
not including the header file that defines that enum
and the compiler spits:

drivers/memory/omap-gpmc.c: In function
			    'gpmc_probe_generic_child':
drivers/memory/omap-gpmc.c:2174:9: error: type of formal
				   parameter 4 is incomplete
         0);
         ^

Cc: Ladislav Michl <ladis@linux-mips.org>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 21abf103818a ("gpio: Pass a flag to gpiochip_request_own_desc()")
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/omap-gpmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index c215287e80cf3..1c6a7c16e0c17 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -21,6 +21,7 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/consumer.h> /* GPIO descriptor enum */
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/platform_device.h>
-- 
2.20.1
