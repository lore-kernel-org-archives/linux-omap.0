From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: OMAP2420 GPIO IRQSTATUS2 for retention
Date: Fri, 8 Sep 2006 12:57:56 +0300
Message-ID: <20060908125756.3092c559.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

In OMAP2420, the bits in both GPIO_IRQSTATUS1 and GPIO_IRQSTATUS2
prevents the system from going idle state. It seems that the GPIO
interrupts always set both GPIO_IRQSTATUS1 and GPIO_IRQSTATUS2 at
once, even if the equivalent bit is disabled in GPIO_IRQENABLE1/2
and also DSP doesn't use GPIO at all.

GPIO_IRQSTATUS1 is for MPU and GPIO_IRQSTATUS2 is for DSP.

There are some registers to control irq detection mode(EDGE/LEVEL),
but they affects both GPIO_IRQSTATUS1 and GPIO_IRQSTATUS2 at the same
time. So it seems that there is no way just to disable GPIO_IRQSTATUS2
currently.

This patch clears IRQSTATUS2 to avoid the above situation when GPIO
interrupt occurs. But I am wondering how to disable GPIO_IRQSTATUS2
independently.

Do you know if any way to disable GPIO interrupts(disabling
GPIO_IRQSTATUS2)?

---
 arch/arm/plat-omap/gpio.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 8d835b1..ce43684 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -94,6 +94,8 @@ #define OMAP24XX_GPIO_REVISION		0x0000
 #define OMAP24XX_GPIO_SYSCONFIG		0x0010
 #define OMAP24XX_GPIO_SYSSTATUS		0x0014
 #define OMAP24XX_GPIO_IRQSTATUS1	0x0018
+#define OMAP24XX_GPIO_IRQSTATUS2	0x0028
+#define OMAP24XX_GPIO_IRQENABLE2	0x002c
 #define OMAP24XX_GPIO_IRQENABLE1	0x001c
 #define OMAP24XX_GPIO_CTRL		0x0030
 #define OMAP24XX_GPIO_OE		0x0034
@@ -529,6 +531,10 @@ static void _clear_gpio_irqbank(struct g
 		return;
 	}
 	__raw_writel(gpio_mask, reg);
+
+	/* Workaround for clearing DSP GPIO interrupts to allow
retention */
+	if (cpu_is_omap2420())
+		__raw_writel(gpio_mask, bank->base +
OMAP24XX_GPIO_IRQSTATUS2); }
 
 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int
gpio) -- 
1.4.2.g44c10
