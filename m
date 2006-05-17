From: Imre Deak <imre.deak@nokia.com>
Subject: Re: [RFC] ARM: OMAP: handle lazy IRQ disable properly
Date: Wed, 17 May 2006 21:14:02 +0300
Message-ID: <446B67EA.7030107@nokia.com>
References: <1144008267.8058.58.camel@bitbox.mine.nu>
	<1147882410.22799.5.camel@orphique>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070608040901090007090704"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1147882410.22799.5.camel@orphique>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Ladislav Michl <michl@2n.cz>
Cc: linux-omap <linux-omap-open-source@linux.omap.com>, "Yrjola Juha (Nokia-M/Helsinki)" <Juha.Yrjola@nokia.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------070608040901090007090704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

ext Ladislav Michl wrote:
> On Sun, 2006-04-02 at 23:04 +0300, Imre Deak wrote:
>> GPIO IRQs can't be disabled at the moment, since the ARM lazy IRQ
>> masking is not handled properly by the current GPIO IRQ handler.
> 
> Imre,
> 
> I updated linux-omap git tree yesterday and found that it no longer
> boots on VoiceBlue (5910) board; smc91x driver doesn't get any
> interrupts. Reverting following commit made it work again.
> 
> diff-tree e829dc78d9908b3949c2994b331c5279049b9098 
> Author: Imre Deak <imre.deak@nokia.com>
> Date:   Thu May 11 16:13:42 2006 +0300
> 
>     ARM: OMAP: GPIO IRQ lazy IRQ disable fix
> 
> It is not exactly the same as the one you provided here, but it seems it
> is based on it.

I missed the fact that some OMAPs have IRQ mask others IRQ enable 
register.. Could you try it with the attached patch?

--Imre

> 
> Best regards,
> 	ladis


--------------070608040901090007090704
Content-Type: text/plain;
 name="omap-gpio_irq_mask-patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap-gpio_irq_mask-patch.diff"

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index cd1e508..0fb4081 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -540,19 +540,24 @@ static inline void _clear_gpio_irqstatus
 static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 {
 	void __iomem *reg = bank->base;
+	int inv = 0;
+	u32 mask;
 
 	switch (bank->method) {
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_GPIO_MASKIT;
+		inv = 1;
 		break;
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_INT_MASK;
+		inv = 1;
 		break;
 	case METHOD_GPIO_1610:
 		reg += OMAP1610_GPIO_IRQENABLE1;
 		break;
 	case METHOD_GPIO_730:
 		reg += OMAP730_GPIO_INT_MASK;
+		inv = 1;
 		break;
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQENABLE1;
@@ -562,7 +567,8 @@ static u32 _get_gpio_irqbank_mask(struct
 		return 0;
 	}
 
-	return __raw_readl(reg);
+	mask = __raw_readl(reg);
+	return inv ? !mask : mask;
 }
 
 static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enable)

--------------070608040901090007090704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070608040901090007090704--
