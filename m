From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH] ARM: OMAP: fix GPIO IRQ mask handling [was Re: [RFC] ARM:
	OMAP: handle lazy IRQ disable properly]
Date: Wed, 24 May 2006 14:55:20 +0300
Message-ID: <1148471720.28420.32.camel@mammoth.research.nokia.com>
References: <1144008267.8058.58.camel@bitbox.mine.nu>
	<1147882410.22799.5.camel@orphique> <446B67EA.7030107@nokia.com>
	<446B6C65.7010504@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <446B6C65.7010504@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: michl@2n.cz, linux-omap <linux-omap-open-source@linux.omap.com>, "Yrjola Juha (Nokia-M/Helsinki)" <Juha.Yrjola@nokia.com>
List-Id: linux-omap@vger.kernel.org

[ Ignore the two previous ones they were both bogus:( I tested this on
OMAP1510 innovator ]

ARM: OMAP: fix GPIO IRQ mask handling

The GPIO IRQ mask was retrieved incorrectly in cases where we have a mask
register instead of an enable register. Also we should only return the
valid bits depending on the bank size.

This fixes a bug on 1510/1610 based OMAPs where GPIO IRQs are not
delivered.

Signed-off-by: Imre Deak <imre.deak@nokia.com>

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index cd1e508..e75a2ca 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -540,29 +540,44 @@ static inline void _clear_gpio_irqstatus
 static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 {
 	void __iomem *reg = bank->base;
+	int inv = 0;
+	u32 l;
+	u32 mask;
 
 	switch (bank->method) {
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_GPIO_MASKIT;
+		mask = 0xffff;
+		inv = 1;
 		break;
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_INT_MASK;
+		mask = 0xffff;
+		inv = 1;
 		break;
 	case METHOD_GPIO_1610:
 		reg += OMAP1610_GPIO_IRQENABLE1;
+		mask = 0xffff;
 		break;
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_INT_MASK;
+		mask = 0xffffffff;
+		inv = 1;
 		break;
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQENABLE1;
+		mask = 0xffffffff;
 		break;
 	default:
 		BUG();
 		return 0;
 	}
 
-	return __raw_readl(reg);
+	l = __raw_readl(reg);
+	if (inv)
+		l = ~l;
+	l &= mask;
+	return l;
 }
 
 static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enable)
