From: Rob Herring <robh@kernel.org>
Subject: [PATCH v2 01/13] ARM: kill off set_irq_flags usage
Date: Sun, 12 Jul 2015 09:26:39 -0500
Message-ID: <1436711211-18223-2-git-send-email-robh@kernel.org>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1436711211-18223-1-git-send-email-robh@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kevin Hilman <khilman@deeprootsystems.com>, Sekhar Nori <nsekhar@ti.com>, Greg Ungerer <gerg@uclinux.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Roland Stigge <stigge@antcom.de>, linux-samsung-soc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, arm@kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Haojian Zhuang <haojian.zhuang@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, Simtec Linux Team <linux@simtec.co.uk>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-omap@vger.kernel.org

set_irq_flags is ARM specific with custom flags which have genirq
equivalents. Convert drivers to use the genirq interfaces directly, so we
can kill off set_irq_flags. The translation of flags is as follows:

IRQF_VALID -> !IRQ_NOREQUEST
IRQF_PROBE -> !IRQ_NOPROBE
IRQF_NOAUTOEN -> IRQ_NOAUTOEN

For IRQs managed by an irqdomain, the irqdomain core code handles clearing
and setting IRQ_NOREQUEST already, so there is no need to do this in
.map() functions and we can simply remove the set_irq_flags calls. Some
users also set IRQ_NOPROBE and this has been maintained although it is not
clear that is really needed. There appears to be a great deal of blind
copy and paste of this code.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Imre Kaloz <kaloz@openwrt.org>
Acked-by: Krzysztof Halasa <khalasa@piap.pl>
Cc: Greg Ungerer <gerg@uclinux.org>
Cc: Roland Stigge <stigge@antcom.de>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Simtec Linux Team <linux@simtec.co.uk>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Tested-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/common/it8152.c             |  2 +-
 arch/arm/common/locomo.c             |  2 +-
 arch/arm/common/sa1111.c             |  4 ++--
 arch/arm/mach-davinci/cp_intc.c      |  2 +-
 arch/arm/mach-dove/irq.c             |  2 +-
 arch/arm/mach-ebsa110/core.c         |  2 +-
 arch/arm/mach-footbridge/common.c    |  2 +-
 arch/arm/mach-footbridge/isa-irq.c   |  8 ++++----
 arch/arm/mach-gemini/gpio.c          |  2 +-
 arch/arm/mach-gemini/irq.c           |  2 +-
 arch/arm/mach-imx/3ds_debugboard.c   |  2 +-
 arch/arm/mach-imx/mach-mx31ads.c     |  2 +-
 arch/arm/mach-iop13xx/irq.c          |  2 +-
 arch/arm/mach-iop32x/irq.c           |  2 +-
 arch/arm/mach-iop33x/irq.c           |  2 +-
 arch/arm/mach-ixp4xx/common.c        |  2 +-
 arch/arm/mach-ks8695/irq.c           |  2 +-
 arch/arm/mach-lpc32xx/irq.c          |  2 +-
 arch/arm/mach-netx/generic.c         |  2 +-
 arch/arm/mach-omap1/fpga.c           |  2 +-
 arch/arm/mach-omap1/irq.c            |  2 +-
 arch/arm/mach-pxa/balloon3.c         |  2 +-
 arch/arm/mach-pxa/irq.c              |  1 -
 arch/arm/mach-pxa/lpd270.c           |  2 +-
 arch/arm/mach-pxa/pcm990-baseboard.c |  2 +-
 arch/arm/mach-pxa/pxa3xx.c           |  2 +-
 arch/arm/mach-pxa/viper.c            |  2 +-
 arch/arm/mach-pxa/zeus.c             |  2 +-
 arch/arm/mach-rpc/ecard.c            |  2 +-
 arch/arm/mach-rpc/irq.c              | 16 ++++++++--------
 arch/arm/mach-s3c24xx/bast-irq.c     |  2 +-
 arch/arm/mach-s3c64xx/common.c       |  2 +-
 arch/arm/mach-sa1100/neponset.c      |  4 ++--
 arch/arm/mach-w90x900/irq.c          |  2 +-
 drivers/irqchip/irq-sa11x0.c         |  1 -
 35 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
index 5114b68..96dabcb 100644
--- a/arch/arm/common/it8152.c
+++ b/arch/arm/common/it8152.c
@@ -91,7 +91,7 @@ void it8152_init_irq(void)
 	for (irq = IT8152_IRQ(0); irq <= IT8152_LAST_IRQ; irq++) {
 		irq_set_chip_and_handler(irq, &it8152_irq_chip,
 					 handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 }
 
diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index b55c362..339fc41 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -205,7 +205,7 @@ static void locomo_setup_irq(struct locomo *lchip)
 	for ( ; irq <= lchip->irq_base + 3; irq++) {
 		irq_set_chip_and_handler(irq, &locomo_chip, handle_level_irq);
 		irq_set_chip_data(irq, lchip);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 }
 
diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 93ee70d..680374d 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -486,7 +486,7 @@ static int sa1111_setup_irq(struct sa1111 *sachip, unsigned irq_base)
 		irq_set_chip_and_handler(irq, &sa1111_low_chip,
 					 handle_edge_irq);
 		irq_set_chip_data(irq, sachip);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	for (i = AUDXMTDMADONEA; i <= IRQ_S1_BVD1_STSCHG; i++) {
@@ -494,7 +494,7 @@ static int sa1111_setup_irq(struct sa1111 *sachip, unsigned irq_base)
 		irq_set_chip_and_handler(irq, &sa1111_high_chip,
 					 handle_edge_irq);
 		irq_set_chip_data(irq, sachip);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	/*
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 006dae8df..3f683fd 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -112,7 +112,7 @@ static int cp_intc_host_map(struct irq_domain *h, unsigned int virq,
 	pr_debug("cp_intc_host_map(%d, 0x%lx)\n", virq, hw);
 
 	irq_set_chip(virq, &cp_intc_irq_chip);
-	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
+	irq_set_noprobe(virq);
 	irq_set_handler(virq, handle_edge_irq);
 	return 0;
 }
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index df0223f..ea7892e 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -172,7 +172,7 @@ void __init dove_init_irq(void)
 	for (i = IRQ_DOVE_PMU_START; i < NR_IRQS; i++) {
 		irq_set_chip_and_handler(i, &pmu_irq_chip, handle_level_irq);
 		irq_set_status_flags(i, IRQ_LEVEL);
-		set_irq_flags(i, IRQF_VALID);
+		irq_clear_status_flags(i, IRQ_NOREQUEST);
 	}
 	irq_set_chained_handler(IRQ_DOVE_PMU, pmu_irq_handler);
 }
diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index 8254e71..688e5fe 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -65,7 +65,7 @@ static void __init ebsa110_init_irq(void)
 	for (irq = 0; irq < NR_IRQS; irq++) {
 		irq_set_chip_and_handler(irq, &ebsa110_irq_chip,
 					 handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 }
 
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 9e8220e..0f0c9e0 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -106,7 +106,7 @@ static void __init __fb_init_irq(void)
 
 	for (irq = _DC21285_IRQ(0); irq < _DC21285_IRQ(20); irq++) {
 		irq_set_chip_and_handler(irq, &fb_chip, handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 }
 
diff --git a/arch/arm/mach-footbridge/isa-irq.c b/arch/arm/mach-footbridge/isa-irq.c
index c3a0abb..fcd79bc 100644
--- a/arch/arm/mach-footbridge/isa-irq.c
+++ b/arch/arm/mach-footbridge/isa-irq.c
@@ -153,13 +153,13 @@ void __init isa_init_irq(unsigned int host_irq)
 		for (irq = _ISA_IRQ(0); irq < _ISA_IRQ(8); irq++) {
 			irq_set_chip_and_handler(irq, &isa_lo_chip,
 						 handle_level_irq);
-			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+			irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 		}
 
 		for (irq = _ISA_IRQ(8); irq < _ISA_IRQ(16); irq++) {
 			irq_set_chip_and_handler(irq, &isa_hi_chip,
 						 handle_level_irq);
-			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+			irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 		}
 
 		request_resource(&ioport_resource, &pic1_resource);
@@ -175,8 +175,8 @@ void __init isa_init_irq(unsigned int host_irq)
 		 * resistor on this line.
 		 */
 		if (machine_is_netwinder())
-			set_irq_flags(_ISA_IRQ(11), IRQF_VALID |
-				      IRQF_PROBE | IRQF_NOAUTOEN);
+			irq_modify_status(_ISA_IRQ(11),
+				IRQ_NOREQUEST | IRQ_NOPROBE, IRQ_NOAUTOEN);
 	}
 }
 
diff --git a/arch/arm/mach-gemini/gpio.c b/arch/arm/mach-gemini/gpio.c
index 3292f2e..220333e 100644
--- a/arch/arm/mach-gemini/gpio.c
+++ b/arch/arm/mach-gemini/gpio.c
@@ -220,7 +220,7 @@ void __init gemini_gpio_init(void)
 		     j < GPIO_IRQ_BASE + (i + 1) * 32; j++) {
 			irq_set_chip_and_handler(j, &gpio_irq_chip,
 						 handle_edge_irq);
-			set_irq_flags(j, IRQF_VALID);
+			irq_clear_status_flags(j, IRQ_NOREQUEST);
 		}
 
 		irq_set_chained_handler_and_data(IRQ_GPIO(i), gpio_irq_handler,
diff --git a/arch/arm/mach-gemini/irq.c b/arch/arm/mach-gemini/irq.c
index 44f50dc..d929b3f 100644
--- a/arch/arm/mach-gemini/irq.c
+++ b/arch/arm/mach-gemini/irq.c
@@ -92,7 +92,7 @@ void __init gemini_init_irq(void)
 		} else {			
 			irq_set_handler(i, handle_level_irq);
 		}
-		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(i, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	/* Disable all interrupts */
diff --git a/arch/arm/mach-imx/3ds_debugboard.c b/arch/arm/mach-imx/3ds_debugboard.c
index 1343773..45903be 100644
--- a/arch/arm/mach-imx/3ds_debugboard.c
+++ b/arch/arm/mach-imx/3ds_debugboard.c
@@ -195,7 +195,7 @@ int __init mxc_expio_init(u32 base, u32 intr_gpio)
 
 	for (i = irq_base; i < irq_base + MXC_MAX_EXP_IO_LINES; i++) {
 		irq_set_chip_and_handler(i, &expio_irq_chip, handle_level_irq);
-		set_irq_flags(i, IRQF_VALID);
+		irq_clear_status_flags(i, IRQ_NOREQUEST);
 	}
 	irq_set_irq_type(p_irq, IRQF_TRIGGER_LOW);
 	irq_set_chained_handler(p_irq, mxc_expio_irq_handler);
diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index d08c37c..2c08535 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -238,7 +238,7 @@ static void __init mx31ads_init_expio(void)
 
 	for (i = irq_base; i < irq_base + MXC_MAX_EXP_IO_LINES; i++) {
 		irq_set_chip_and_handler(i, &expio_irq_chip, handle_level_irq);
-		set_irq_flags(i, IRQF_VALID);
+		irq_clear_status_flags(i, IRQ_NOREQUEST);
 	}
 	irq = gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_4));
 	irq_set_irq_type(irq, IRQ_TYPE_LEVEL_HIGH);
diff --git a/arch/arm/mach-iop13xx/irq.c b/arch/arm/mach-iop13xx/irq.c
index bc73970..623d85a 100644
--- a/arch/arm/mach-iop13xx/irq.c
+++ b/arch/arm/mach-iop13xx/irq.c
@@ -233,7 +233,7 @@ void __init iop13xx_init_irq(void)
 			irq_set_chip(i, &iop13xx_irqchip4);
 
 		irq_set_handler(i, handle_level_irq);
-		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(i, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	iop13xx_msi_init();
diff --git a/arch/arm/mach-iop32x/irq.c b/arch/arm/mach-iop32x/irq.c
index d7ee278..2d1f69a 100644
--- a/arch/arm/mach-iop32x/irq.c
+++ b/arch/arm/mach-iop32x/irq.c
@@ -69,6 +69,6 @@ void __init iop32x_init_irq(void)
 
 	for (i = 0; i < NR_IRQS; i++) {
 		irq_set_chip_and_handler(i, &ext_chip, handle_level_irq);
-		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(i, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 }
diff --git a/arch/arm/mach-iop33x/irq.c b/arch/arm/mach-iop33x/irq.c
index f7f5d3e..c99ec8d 100644
--- a/arch/arm/mach-iop33x/irq.c
+++ b/arch/arm/mach-iop33x/irq.c
@@ -113,6 +113,6 @@ void __init iop33x_init_irq(void)
 		irq_set_chip_and_handler(i,
 					 (i < 32) ? &iop33x_irqchip1 : &iop33x_irqchip2,
 					 handle_level_irq);
-		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(i, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 }
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 8537d4c..0f3f01a 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -296,7 +296,7 @@ void __init ixp4xx_init_irq(void)
 	for(i = 0; i < NR_IRQS; i++) {
 		irq_set_chip_and_handler(i, &ixp4xx_irq_chip,
 					 handle_level_irq);
-		set_irq_flags(i, IRQF_VALID);
+		irq_clear_status_flags(i, IRQ_NOREQUEST);
 	}
 }
 
diff --git a/arch/arm/mach-ks8695/irq.c b/arch/arm/mach-ks8695/irq.c
index 76802aa..31439f2 100644
--- a/arch/arm/mach-ks8695/irq.c
+++ b/arch/arm/mach-ks8695/irq.c
@@ -172,6 +172,6 @@ void __init ks8695_init_irq(void)
 							 handle_edge_irq);
 		}
 
-		set_irq_flags(irq, IRQF_VALID);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST);
 	}
 }
diff --git a/arch/arm/mach-lpc32xx/irq.c b/arch/arm/mach-lpc32xx/irq.c
index d4f7dc8..4ffe333 100644
--- a/arch/arm/mach-lpc32xx/irq.c
+++ b/arch/arm/mach-lpc32xx/irq.c
@@ -434,7 +434,7 @@ void __init lpc32xx_init_irq(void)
 	for (i = 0; i < NR_IRQS; i++) {
 		irq_set_chip_and_handler(i, &lpc32xx_irq_chip,
 					 handle_level_irq);
-		set_irq_flags(i, IRQF_VALID);
+		irq_clear_status_flags(i, IRQ_NOREQUEST);
 	}
 
 	/* Set default mappings */
diff --git a/arch/arm/mach-netx/generic.c b/arch/arm/mach-netx/generic.c
index db25b0c..6373e2b 100644
--- a/arch/arm/mach-netx/generic.c
+++ b/arch/arm/mach-netx/generic.c
@@ -174,7 +174,7 @@ void __init netx_init_irq(void)
 	for (irq = NETX_IRQ_HIF_CHAINED(0); irq <= NETX_IRQ_HIF_LAST; irq++) {
 		irq_set_chip_and_handler(irq, &netx_hif_chip,
 					 handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST);
 	}
 
 	writel(NETX_DPMAS_INT_EN_GLB_EN, NETX_DPMAS_INT_EN);
diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
index 3c0e422..dfec671 100644
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -169,7 +169,7 @@ void omap1510_fpga_init_irq(void)
 		}
 
 		irq_set_handler(i, handle_edge_irq);
-		set_irq_flags(i, IRQF_VALID);
+		irq_clear_status_flags(i, IRQ_NOREQUEST);
 	}
 
 	/*
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index f4d346f..b11edc8 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -262,7 +262,7 @@ void __init omap1_init_irq(void)
 
 			irq_trigger = irq_banks[i].trigger_map >> IRQ_BIT(j);
 			omap_irq_set_cfg(j, 0, 0, irq_trigger);
-			set_irq_flags(j, IRQF_VALID);
+			irq_clear_status_flags(j, IRQ_NOREQUEST);
 		}
 		omap_alloc_gc(irq_banks[i].va, irq_base + i * 32, 32);
 	}
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index d897292..09b9a36 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -528,7 +528,7 @@ static void __init balloon3_init_irq(void)
 	for (irq = BALLOON3_IRQ(0); irq <= BALLOON3_IRQ(7); irq++) {
 		irq_set_chip_and_handler(irq, &balloon3_irq_chip,
 					 handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	irq_set_chained_handler(BALLOON3_AUX_NIRQ, balloon3_irq_handler);
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 98608c5..9c10248 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -133,7 +133,6 @@ static int pxa_irq_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip_and_handler(virq, &pxa_internal_irq_chip,
 				 handle_level_irq);
 	irq_set_chip_data(virq, base);
-	set_irq_flags(virq, IRQF_VALID);
 
 	return 0;
 }
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index eaee2c2..2670fb0 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -151,7 +151,7 @@ static void __init lpd270_init_irq(void)
 	for (irq = LPD270_IRQ(2); irq <= LPD270_IRQ(4); irq++) {
 		irq_set_chip_and_handler(irq, &lpd270_irq_chip,
 					 handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 	irq_set_chained_handler(PXA_GPIO_TO_IRQ(0), lpd270_irq_handler);
 	irq_set_irq_type(PXA_GPIO_TO_IRQ(0), IRQ_TYPE_EDGE_FALLING);
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index 2897da2..86e01bf 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -311,7 +311,7 @@ static void __init pcm990_init_irq(void)
 	for (irq = PCM027_IRQ(0); irq <= PCM027_IRQ(3); irq++) {
 		irq_set_chip_and_handler(irq, &pcm990_irq_chip,
 					 handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	/* disable all Interrupts */
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index bd4cbef..e1362c0 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -325,7 +325,7 @@ static void __init pxa_init_ext_wakeup_irq(int (*fn)(struct irq_data *,
 	for (irq = IRQ_WAKEUP0; irq <= IRQ_WAKEUP1; irq++) {
 		irq_set_chip_and_handler(irq, &pxa_ext_wakeup_chip,
 					 handle_edge_irq);
-		set_irq_flags(irq, IRQF_VALID);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST);
 	}
 
 	pxa_ext_wakeup_chip.irq_set_wake = fn;
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index de3b080..dae3de8 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -313,7 +313,7 @@ static void __init viper_init_irq(void)
 		isa_irq = viper_bit_to_irq(level);
 		irq_set_chip_and_handler(isa_irq, &viper_irq_chip,
 					 handle_edge_irq);
-		set_irq_flags(isa_irq, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(isa_irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	irq_set_chained_handler(gpio_to_irq(VIPER_CPLD_GPIO),
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index ac2ae5c..48dd5bd 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -151,7 +151,7 @@ static void __init zeus_init_irq(void)
 		isa_irq = zeus_bit_to_irq(level);
 		irq_set_chip_and_handler(isa_irq, &zeus_irq_chip,
 					 handle_edge_irq);
-		set_irq_flags(isa_irq, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(isa_irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	irq_set_irq_type(gpio_to_irq(ZEUS_ISA_GPIO), IRQ_TYPE_EDGE_RISING);
diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index fcb1d59..f726d4c 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -946,7 +946,7 @@ static int __init ecard_probe(int slot, unsigned irq, card_type_t type)
 		irq_set_chip_and_handler(ec->irq, &ecard_chip,
 					 handle_level_irq);
 		irq_set_chip_data(ec->irq, ec);
-		set_irq_flags(ec->irq, IRQF_VALID);
+		irq_clear_status_flags(ec->irq, IRQ_NOREQUEST);
 	}
 
 #ifdef CONFIG_ARCH_RPC
diff --git a/arch/arm/mach-rpc/irq.c b/arch/arm/mach-rpc/irq.c
index 3e4fa84..66502e6 100644
--- a/arch/arm/mach-rpc/irq.c
+++ b/arch/arm/mach-rpc/irq.c
@@ -117,7 +117,7 @@ extern unsigned char rpc_default_fiq_start, rpc_default_fiq_end;
 
 void __init rpc_init_irq(void)
 {
-	unsigned int irq, flags;
+	unsigned int irq, clr, set = 0;
 
 	iomd_writeb(0, IOMD_IRQMASKA);
 	iomd_writeb(0, IOMD_IRQMASKB);
@@ -128,37 +128,37 @@ void __init rpc_init_irq(void)
 		&rpc_default_fiq_end - &rpc_default_fiq_start);
 
 	for (irq = 0; irq < NR_IRQS; irq++) {
-		flags = IRQF_VALID;
+		clr = IRQ_NOREQUEST;
 
 		if (irq <= 6 || (irq >= 9 && irq <= 15))
-			flags |= IRQF_PROBE;
+			clr |= IRQ_NOPROBE;
 
 		if (irq == 21 || (irq >= 16 && irq <= 19) ||
 		    irq == IRQ_KEYBOARDTX)
-			flags |= IRQF_NOAUTOEN;
+			set |= IRQ_NOAUTOEN;
 
 		switch (irq) {
 		case 0 ... 7:
 			irq_set_chip_and_handler(irq, &iomd_a_chip,
 						 handle_level_irq);
-			set_irq_flags(irq, flags);
+			irq_modify_status(irq, clr, set);
 			break;
 
 		case 8 ... 15:
 			irq_set_chip_and_handler(irq, &iomd_b_chip,
 						 handle_level_irq);
-			set_irq_flags(irq, flags);
+			irq_modify_status(irq, clr, set);
 			break;
 
 		case 16 ... 21:
 			irq_set_chip_and_handler(irq, &iomd_dma_chip,
 						 handle_level_irq);
-			set_irq_flags(irq, flags);
+			irq_modify_status(irq, clr, set);
 			break;
 
 		case 64 ... 71:
 			irq_set_chip(irq, &iomd_fiq_chip);
-			set_irq_flags(irq, IRQF_VALID);
+			irq_modify_status(irq, clr, set);
 			break;
 		}
 	}
diff --git a/arch/arm/mach-s3c24xx/bast-irq.c b/arch/arm/mach-s3c24xx/bast-irq.c
index cb1b791..ced1ab8 100644
--- a/arch/arm/mach-s3c24xx/bast-irq.c
+++ b/arch/arm/mach-s3c24xx/bast-irq.c
@@ -147,7 +147,7 @@ static __init int bast_irq_init(void)
 
 			irq_set_chip_and_handler(irqno, &bast_pc104_chip,
 						 handle_level_irq);
-			set_irq_flags(irqno, IRQF_VALID);
+			irq_clear_status_flags(irqno, IRQ_NOREQUEST);
 		}
 	}
 
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 16547f2..06ba943 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -420,7 +420,7 @@ static int __init s3c64xx_init_irq_eint(void)
 	for (irq = IRQ_EINT(0); irq <= IRQ_EINT(27); irq++) {
 		irq_set_chip_and_handler(irq, &s3c_irq_eint, handle_level_irq);
 		irq_set_chip_data(irq, (void *)eint_irq_to_bit(irq));
-		set_irq_flags(irq, IRQF_VALID);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST);
 	}
 
 	irq_set_chained_handler(IRQ_EINT0_3, s3c_irq_demux_eint0_3);
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 99d9a3b..6d237b4 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -320,10 +320,10 @@ static int neponset_probe(struct platform_device *dev)
 
 	irq_set_chip_and_handler(d->irq_base + NEP_IRQ_SMC91X, &nochip,
 		handle_simple_irq);
-	set_irq_flags(d->irq_base + NEP_IRQ_SMC91X, IRQF_VALID | IRQF_PROBE);
+	irq_clear_status_flags(d->irq_base + NEP_IRQ_SMC91X, IRQ_NOREQUEST | IRQ_NOPROBE);
 	irq_set_chip_and_handler(d->irq_base + NEP_IRQ_USAR, &nochip,
 		handle_simple_irq);
-	set_irq_flags(d->irq_base + NEP_IRQ_USAR, IRQF_VALID | IRQF_PROBE);
+	irq_clear_status_flags(d->irq_base + NEP_IRQ_USAR, IRQ_NOREQUEST | IRQ_NOPROBE);
 	irq_set_chip(d->irq_base + NEP_IRQ_SA1111, &nochip);
 
 	irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
diff --git a/arch/arm/mach-w90x900/irq.c b/arch/arm/mach-w90x900/irq.c
index d66d43a..491b317 100644
--- a/arch/arm/mach-w90x900/irq.c
+++ b/arch/arm/mach-w90x900/irq.c
@@ -211,6 +211,6 @@ void __init nuc900_init_irq(void)
 	for (irqno = IRQ_WDT; irqno <= IRQ_ADC; irqno++) {
 		irq_set_chip_and_handler(irqno, &nuc900_irq_chip,
 					 handle_level_irq);
-		set_irq_flags(irqno, IRQF_VALID);
+		irq_clear_status_flags(irqno, IRQ_NOREQUEST);
 	}
 }
diff --git a/drivers/irqchip/irq-sa11x0.c b/drivers/irqchip/irq-sa11x0.c
index 46df287..61bb28d 100644
--- a/drivers/irqchip/irq-sa11x0.c
+++ b/drivers/irqchip/irq-sa11x0.c
@@ -70,7 +70,6 @@ static int sa1100_normal_irqdomain_map(struct irq_domain *d,
 {
 	irq_set_chip_and_handler(irq, &sa1100_normal_chip,
 				 handle_level_irq);
-	set_irq_flags(irq, IRQF_VALID);
 
 	return 0;
 }
-- 
2.1.0
