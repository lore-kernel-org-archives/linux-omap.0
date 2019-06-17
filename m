From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH, for GregKH] ARM: omap1: remove unused variable
Date: Mon, 17 Jun 2019 14:55:02 +0200
Message-ID: <20190617125521.1553103-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Kevin Hilman <khilman@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The cleanup of the debugfs functions left one variable behind that
should now be removed as well:

arch/arm/mach-omap1/clock.c:1008:6: error: unused variable 'err' [-Werror,-Wunused-variable]

Fixes: d5ddd5a51726 ("arm: omap1: no need to check return value of debugfs_create functions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/clock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 3d7ab2bcf46c..a5a50efc8e17 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -1005,7 +1005,6 @@ static void clk_debugfs_register_one(struct clk *c)
 
 static void clk_debugfs_register(struct clk *c)
 {
-	int err;
 	struct clk *pa = c->parent;
 
 	if (pa && !pa->dent)
-- 
2.20.0
