From: Kevin Hilman <khilman@deeprooted.net>
Subject: [PATCH] ARM: OMAP: fix gcc4 compile errors
Date: Wed, 21 Jun 2006 15:14:05 -0700
Message-ID: <11509280453372-git-send-email-khilman@deeprooted.net>
Reply-To: Kevin Hilman <khilman@deeprooted.net>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@deeprooted.net>

---
commit 76f8985aa5e9ee6cbd4351ac92dc19c250dad92f
tree 764dedbbe50db95780ece482af03c944ad368376
parent ff7e6adc7e6071c37fe557753806199a068a9317
author Kevin Hilman <khilman@mvista.com> Wed, 21 Jun 2006 15:06:29 -0700
committer Kevin Hilman <khilman@mvista.com> Wed, 21 Jun 2006 15:06:29 -0700

 arch/arm/plat-omap/common.h       |    0 
 include/asm-arm/arch-omap/clock.h |    2 --
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/common.h b/arch/arm/plat-omap/common.h
deleted file mode 100644
index e69de29..0000000
diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
index 3c4eb9f..f83003f 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -48,8 +48,6 @@ struct clk_functions {
 };
 
 extern unsigned int mpurate;
-extern struct list_head clocks;
-extern spinlock_t clockfw_lock;
 
 extern int clk_init(struct clk_functions * custom_clocks);
 extern int clk_register(struct clk *clk);
