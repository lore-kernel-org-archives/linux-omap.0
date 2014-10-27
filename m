From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v6 3/7] ARM: l2c: Get outer cache .write_sec callback from
 mach_desc only if not NULL
Date: Mon, 27 Oct 2014 12:05:46 +0100
Message-ID: <1414407950-3029-4-git-send-email-m.szyprowski@samsung.com>
References: <1414407950-3029-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1414407950-3029-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, lauraa@codeaurora.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, santosh.shilimkar@ti.com, tony@atomide.com, drake@endlessm.com, loeliger@gmail.com, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-omap@vger.kernel.org

From: Tomasz Figa <t.figa@samsung.com>

Certain platforms (i.e. Exynos) might need to set .write_sec callback
from firmware initialization which is happenning in .init_early callback
of machine descriptor. However current code will overwrite the pointer
with whatever is present in machine descriptor, even though it can be
already set earlier. This patch fixes this by making the assignment
conditional, depending on whether current .write_sec callback is NULL.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/kernel/irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 7c81ec428b9b..5acb8aef6f2d 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -108,7 +108,8 @@ void __init init_IRQ(void)
 
 	if (IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_CACHE_L2X0) &&
 	    (machine_desc->l2c_aux_mask || machine_desc->l2c_aux_val)) {
-		outer_cache.write_sec = machine_desc->l2c_write_sec;
+		if (!outer_cache.write_sec)
+			outer_cache.write_sec = machine_desc->l2c_write_sec;
 		ret = l2x0_of_init(machine_desc->l2c_aux_val,
 				   machine_desc->l2c_aux_mask);
 		if (ret)
-- 
1.9.2
