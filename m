From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 07/17] genirq: Ensure IRQ descriptor is valid when setting-up the IRQ
Date: Wed, 4 May 2016 17:25:20 +0100
Message-ID: <1462379130-11742-8-git-send-email-jonathanh@nvidia.com>
References: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

In the function, setup_irq(), we don't check that the descriptor
returned from irq_to_desc() is valid before we start using it. For
example chip_bus_lock() called from setup_irq(), assumes that the
descriptor pointer is valid and doesn't check before dereferencing it.

In many other functions including setup/free_percpu_irq() we do check
that the descriptor returned is not NULL and therefore add the same test
to setup_irq() to ensure the descriptor returned is valid.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index b2a93a37f772..eaedeb74b49d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1414,7 +1414,7 @@ int setup_irq(unsigned int irq, struct irqaction *act)
 	int retval;
 	struct irq_desc *desc = irq_to_desc(irq);
 
-	if (WARN_ON(irq_settings_is_per_cpu_devid(desc)))
+	if (!desc || WARN_ON(irq_settings_is_per_cpu_devid(desc)))
 		return -EINVAL;
 	chip_bus_lock(desc);
 	retval = __setup_irq(irq, desc, act);
-- 
2.1.4
