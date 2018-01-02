From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: OMAP: clock: Fix debugfs_create_*() usage
Date: Tue,  2 Jan 2018 16:25:35 +0100
Message-ID: <1514906735-8977-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-omap@vger.kernel.org

When exposing data access through debugfs, the correct
debugfs_create_*() functions must be used, depending on data type.

Remove all casts from data pointers passed to debugfs_create_*()
functions, as such casts prevent the compiler from flagging bugs.

Correct all wrong usage:
  - clk.rate is unsigned long, not u32,
  - clk.flags is u8, not u32, which exposed the successive
    clk.rate_offset and clk.src_offset fields.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 arch/arm/mach-omap1/clock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 43e3e188f5213418..fa512413a4717221 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -1011,17 +1011,17 @@ static int clk_debugfs_register_one(struct clk *c)
 		return -ENOMEM;
 	c->dent = d;
 
-	d = debugfs_create_u8("usecount", S_IRUGO, c->dent, (u8 *)&c->usecount);
+	d = debugfs_create_u8("usecount", S_IRUGO, c->dent, &c->usecount);
 	if (!d) {
 		err = -ENOMEM;
 		goto err_out;
 	}
-	d = debugfs_create_u32("rate", S_IRUGO, c->dent, (u32 *)&c->rate);
+	d = debugfs_create_ulong("rate", S_IRUGO, c->dent, &c->rate);
 	if (!d) {
 		err = -ENOMEM;
 		goto err_out;
 	}
-	d = debugfs_create_x32("flags", S_IRUGO, c->dent, (u32 *)&c->flags);
+	d = debugfs_create_x8("flags", S_IRUGO, c->dent, &c->flags);
 	if (!d) {
 		err = -ENOMEM;
 		goto err_out;
-- 
2.7.4

