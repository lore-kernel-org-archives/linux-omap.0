From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 9/10] arch/arm/mach-omap2/clock.c: add missing clk_put
Date: Wed,  1 Jun 2011 19:10:12 +0200
Message-ID: <1306948213-20767-9-git-send-email-julia@diku.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: kernel-janitors@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

Add missing call to clk_put.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@r exists@
expression e1,e2;
statement S;
@@

e1 = clk_get@p1(...);
... when != e1 = e2
    when != clk_put(e1)
    when any
if (...) { ... when != clk_put(e1)
               when != if (...) { ... clk_put(e1) ... }
* return@p3 ...;
 } else S
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/arm/mach-omap2/clock.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 180299e..bf9c36c 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -453,6 +453,7 @@ int __init omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name)
 	if (IS_ERR_VALUE(r)) {
 		WARN(1, "clock: %s: unable to set MPU rate to %d: %d\n",
 		     mpurate_ck->name, mpurate, r);
+		clk_put(mpurate_ck);
 		return -EINVAL;
 	}
 
