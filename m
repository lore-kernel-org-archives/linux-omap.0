From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH] Re: omap1510 MPU interupt BUG
Date: Fri, 06 Jan 2006 20:37:25 +0100
Message-ID: <43BEC6F5.70504@de.bosch.com>
References: <E1ElqUd-000N2H-00.palmtt2-mail-ru@f37.mail.ru>
	<20060103175520.GO6034@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080104070809050803080407"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060103175520.GO6034@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, Petukhov Nikolay <palmtt2@mail.ru>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------080104070809050803080407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tony Lindgren wrote:

>>diff -Nru linux-2.6.14-omap2/arch/arm/plat-omap/gpio.c
>>linux-2.6.14-omap2-palmtt2/arch/arm/plat-omap/gpio.c  
>>
>>--- linux-2.6.14-omap2/arch/arm/plat-omap/gpio.c        Sat Dec 10 21:05:46 2005      
>>+++ linux-2.6.14-omap2-palmtt2/arch/arm/plat-omap/gpio.c        Sat Dec 10 19:57:30 2005      
>>@@ -758,6 +758,10 @@
>>    
>>while(1) {            
>>isr = __raw_readl(isr_reg);
>>+#ifdef CONFIG_ARCH_OMAP15XX   
>>+       if (bank->method == METHOD_MPUIO)
>>+           isr&=0xffff;   
>>+#endif !
>>
>>_enable_gpio_irqbank(bank, isr, 0);
>>_clear_gpio_irqbank(bank, isr);            
>>_enable_gpio_irqbank(bank, isr, 1);
> 
> 
> Can't read this patch because of the bad formatting... Can you please
> repost? Maybe sending it as an attachment works better with a web
> interface :)

arch/arm/plat-omap/gpio.c has changed since 2.6.14-omap2, so patch above
will not apply to recent git even if formatting is correct. I tried to
adapt it to current version of gpio.c. I can't test it, so is patch
below okay?



--------------080104070809050803080407
Content-Type: text/plain;
 name="omap1510_mpu_interrupt_bug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap1510_mpu_interrupt_bug.patch"

--- ./arch/arm/plat-omap/gpio.c_orig	2006-01-06 19:37:32.602154520 +0100
+++ ./arch/arm/plat-omap/gpio.c	2006-01-06 19:44:03.917665520 +0100
@@ -767,6 +767,9 @@ static void gpio_irq_handler(unsigned in
 					OMAP24XX_GPIO_LEVELDETECT0) |
 				__raw_readl(bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
+		if(cpu_is_omap15xx())
+			if(bank->method == METHOD_MPUIO)
+				level_mask = 0xffff0000; 
 
 		/* clear edge sensitive interrupts before handler(s) are
 		called so that we don't miss any interrupt occurred while




--------------080104070809050803080407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080104070809050803080407--
