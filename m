From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 3/8] ARM: OMAP2+: timer: Add comment on timer clk parenting
Date: Tue, 22 Apr 2014 20:27:04 -0500
Message-ID: <1398216429-4681-4-git-send-email-joelf@ti.com>
References: <1398216429-4681-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398216429-4681-1-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelf@ti.com>
List-Id: linux-omap@vger.kernel.org

Add a comment describing the state of system timer clock parenting.  The code
following the comment should be deleted once all platforms can do DT boot, and
specially should not be executed for DT platforms once we can specify default
clock parents through DT.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/timer.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index f192a41..9fdff5b 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -313,6 +313,10 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (IS_ERR(timer->fclk))
 		return PTR_ERR(timer->fclk);
 
+	/*
+	 * Clock reparenting code, goes away for DT-boot atleast,
+	 * once clock layer can do it through DT.
+	 */
 	src = clk_get(NULL, fck_source);
 	if (IS_ERR(src))
 		return PTR_ERR(src);
-- 
1.7.9.5
