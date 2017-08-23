From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mfd: omap-usb-tll: fix register offsets
Date: Wed, 23 Aug 2017 16:44:51 +0200
Message-ID: <20170823144501.2292044-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

gcc-8 notices that the register number calculation is wrong
when the offset is an 'u8' but the number is larger than 256:

drivers/mfd/omap-usb-tll.c: In function 'omap_tll_init':
drivers/mfd/omap-usb-tll.c:90:46: error: overflow in conversion from 'int' to 'u8 {aka unsigned char}' chages value from 'i * 256 + 2070' to '22' [-Werror=overflow]

This addresses it by always using a 32-bit offset number for
the register. This is apparently an old problem that previous
compilers did not find.

Fixes: 16fa3dc75c22 ("mfd: omap-usb-tll: HOST TLL platform driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/omap-usb-tll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 6f5300b0eb31..44a5d66314c6 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -131,12 +131,12 @@ static inline u32 usbtll_read(void __iomem *base, u32 reg)
 	return readl_relaxed(base + reg);
 }
 
-static inline void usbtll_writeb(void __iomem *base, u8 reg, u8 val)
+static inline void usbtll_writeb(void __iomem *base, u32 reg, u8 val)
 {
 	writeb_relaxed(val, base + reg);
 }
 
-static inline u8 usbtll_readb(void __iomem *base, u8 reg)
+static inline u8 usbtll_readb(void __iomem *base, u32 reg)
 {
 	return readb_relaxed(base + reg);
 }
-- 
2.9.0
