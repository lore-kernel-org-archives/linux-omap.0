From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Re: omap1510 MPU interupt BUG
Date: Fri, 20 Jan 2006 10:43:08 -0800
Message-ID: <20060120184308.GC4431@atomide.com>
References: <E1ElqUd-000N2H-00.palmtt2-mail-ru@f37.mail.ru>
	<20060103175520.GO6034@atomide.com>
	<43BEC6F5.70504@de.bosch.com> <43CB5911.8060606@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="w7PDEPdKQumQfZlR"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43CB5911.8060606@mail.ru>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: palmtt2 <palmtt2@mail.ru>
Cc: omap <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* palmtt2 <palmtt2@mail.ru> [060116 01:01]:
> Dirk Behme wrote:
> >------------------------------------------------------------------------
> >
> >--- ./arch/arm/plat-omap/gpio.c_orig	2006-01-06 19:37:32.602154520 +0100
> >+++ ./arch/arm/plat-omap/gpio.c	2006-01-06 19:44:03.917665520 +0100
> >@@ -767,6 +767,9 @@ static void gpio_irq_handler(unsigned in
> > 					OMAP24XX_GPIO_LEVELDETECT0) |
> > 				__raw_readl(bank->base +
> > 					OMAP24XX_GPIO_LEVELDETECT1);
> >+		if(cpu_is_omap15xx())
> >+			if(bank->method == METHOD_MPUIO)
> >+				level_mask = 0xffff0000; 
> > 
> > 		/* clear edge sensitive interrupts before handler(s) are
> > 		called so that we don't miss any interrupt occurred while
> >
> >
> >
> >  
> Patch to fixed MPUIO interrupt.
> Tested on linux-2.6.15-omap1.

Thanks, I'll push a slightly modified version below.

--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-1510-gpio-mpu-fix-modified

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index cf5ad29..cb740c3 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -764,6 +764,10 @@ static void gpio_irq_handler(unsigned in
 		u32 isr_saved, level_mask = 0;
 
 		isr_saved = isr = __raw_readl(isr_reg);
+
+		if (cpu_is_omap15xx() && (bank->method == METHOD_MPUIO))
+			isr &= 0x0000ffff;
+
 		if (cpu_is_omap24xx())
 			level_mask =
 				__raw_readl(bank->base +

--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--w7PDEPdKQumQfZlR--
