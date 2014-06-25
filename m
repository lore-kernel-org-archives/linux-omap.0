From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH v2 1/6] ARM: mm: cache-l2x0: Add base address argument to
 write_sec callback
Date: Wed, 25 Jun 2014 15:37:26 +0200
Message-ID: <1403703451-12233-2-git-send-email-t.figa@samsung.com>
References: <1403703451-12233-1-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1403703451-12233-1-git-send-email-t.figa@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-samsung-soc@vger.kernel.org
Cc: Kukjin Kim <kgene.kim@samsung.com>, Laura Abbott <lauraa@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Daniel Drake <drake@endlessm.com>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

For certain platforms (e.g. Exynos) it is necessary to read back some
values from registers before they can be written (i.e. SMC calls that
set multiple registers per call), so base address of L2C controller is
needed for .write_sec operation. This patch adds base argument to
.write_sec callback so that its implementation can also access registers
directly.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/include/asm/mach/arch.h   | 3 ++-
 arch/arm/include/asm/outercache.h  | 2 +-
 arch/arm/mach-highbank/highbank.c  | 3 ++-
 arch/arm/mach-omap2/omap4-common.c | 3 ++-
 arch/arm/mach-ux500/cache-l2x0.c   | 3 ++-
 arch/arm/mm/cache-l2x0.c           | 2 +-
 6 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 060a75e..fefff4d 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -46,7 +46,8 @@ struct machine_desc {
 	enum reboot_mode	reboot_mode;	/* default restart mode	*/
 	unsigned		l2c_aux_val;	/* L2 cache aux value	*/
 	unsigned		l2c_aux_mask;	/* L2 cache aux mask	*/
-	void			(*l2c_write_sec)(unsigned long, unsigned);
+	void			(*l2c_write_sec)(unsigned long,
+						 void __iomem *, unsigned);
 	struct smp_operations	*smp;		/* SMP operations	*/
 	bool			(*smp_init)(void);
 	void			(*fixup)(struct tag *, char **);
diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index 891a56b..25b70b5 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -35,7 +35,7 @@ struct outer_cache_fns {
 	void (*resume)(void);
 
 	/* This is an ARM L2C thing */
-	void (*write_sec)(unsigned long, unsigned);
+	void (*write_sec)(unsigned long, void __iomem *, unsigned);
 };
 
 extern struct outer_cache_fns outer_cache;
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 8c35ae4..20cf160 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -51,7 +51,8 @@ static void __init highbank_scu_map_io(void)
 }
 
 
-static void highbank_l2c310_write_sec(unsigned long val, unsigned reg)
+static void highbank_l2c310_write_sec(unsigned long val, void __iomem *base,
+				      unsigned reg)
 {
 	if (reg == L2X0_CTRL)
 		highbank_smc1(0x102, val);
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 326cd98..ce04afa 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -167,7 +167,8 @@ void __iomem *omap4_get_l2cache_base(void)
 	return l2cache_base;
 }
 
-static void omap4_l2c310_write_sec(unsigned long val, unsigned reg)
+static void omap4_l2c310_write_sec(unsigned long val, void __iomem *base,
+				   unsigned reg)
 {
 	unsigned smc_op;
 
diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 842ebed..bd87108 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -35,7 +35,8 @@ static int __init ux500_l2x0_unlock(void)
 	return 0;
 }
 
-static void ux500_l2c310_write_sec(unsigned long val, unsigned reg)
+static void ux500_l2c310_write_sec(unsigned long val, void __iomem *base,
+				   unsigned reg)
 {
 	/*
 	 * We can't write to secure registers as we are in non-secure
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index efc5cab..478566b 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -72,7 +72,7 @@ static void l2c_write_sec(unsigned long val, void __iomem *base, unsigned reg)
 	if (val == readl_relaxed(base + reg))
 		return;
 	if (outer_cache.write_sec)
-		outer_cache.write_sec(val, reg);
+		outer_cache.write_sec(val, base, reg);
 	else
 		writel_relaxed(val, base + reg);
 }
-- 
1.9.3
