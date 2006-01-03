From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap1510 MPU interupt BUG
Date: Tue, 3 Jan 2006 09:55:20 -0800
Message-ID: <20060103175520.GO6034@atomide.com>
References: <E1ElqUd-000N2H-00.palmtt2-mail-ru@f37.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <E1ElqUd-000N2H-00.palmtt2-mail-ru@f37.mail.ru>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Petukhov Nikolay <palmtt2@mail.ru>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Petukhov Nikolay <palmtt2@mail.ru> [051212 11:03]:
> Hi All.
> 
> in file linux-2.6.14-omap2/arch/arm/plat-omap/gpio.c
> in function
> static void gpio_irq_handler(unsigned int irq, struct irqdesc *desc,                                                                    struct pt_regs *regs)
> 
> .......
> 
>         isr = __raw_readl(isr_reg);  
> .......
> 
> Note:    __raw_readl return 32bit, but MPU have 16 bit registers
> 
> example:
> MPU isr=0x0001, but __raw_readl() return isr=0x00010001 -> virtual interrupt 16
> desc_handle_irq(0, d, regs) - handled ok
> desc_handle_irq(16, d, regs) - interrupt handler = NULL
> 
> Here patch fix it
> 
> diff -Nru linux-2.6.14-omap2/arch/arm/plat-omap/gpio.c
> linux-2.6.14-omap2-palmtt2/arch/arm/plat-omap/gpio.c  
> 
> --- linux-2.6.14-omap2/arch/arm/plat-omap/gpio.c        Sat Dec 10 21:05:46 2005                             +++ linux-2.6.14-omap2-palmtt2/arch/arm/plat-omap/gpio.c        Sat Dec 10 19:57:30 2005                     @@ -758,6 +758,10 @@
>                                                                                                                                                                                      while(1) {            
> isr = __raw_readl(isr_reg);
> +#ifdef CONFIG_ARCH_OMAP15XX                                                                                 +       if (bank->method == METHOD_MPUIO)
> +           isr&=0xffff;   
> +#endif !
>                                                                                                            _enable_gpio_irqbank(bank, isr, 0);
> _clear_gpio_irqbank(bank, isr);            
> _enable_gpio_irqbank(bank, isr, 1);


Can't read this patch because of the bad formatting... Can you please
repost? Maybe sending it as an attachment works better with a web
interface :)

Tony
