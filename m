From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] To add OMAP 2430 Support
Date: Fri, 03 Nov 2006 20:28:44 +0100
Message-ID: <454B986C.6070301@gmail.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE01C6AEA2@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01C6AEA2@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Syed Mohammed, Khasim wrote:
> ethernet_fix_2430.patch
> -----------------------
> This patch updates the GPIO interrupt line behavior for SMC91x
> interrupts on 2430 SDP.
 >
 > --- linux-omap/drivers/net/smc91x.h	2006-11-02 
00:16:21.000000000 -0600
 > +++ dev-linux-omap-2.6.git/drivers/net/smc91x.h 
2006-11-02 15:38:13.000000000 -0600
 > @@ -192,14 +192,16 @@ SMC_outw(u16 val, void __iomem 
*ioaddr,
 >  #include <asm/mach-types.h>
 >  #include <asm/arch/cpu.h>
 >
 > +#ifdef CONFIG_ARCH_OMAP2430
 > +#define SMC_IRQ_FLAGS		SA_TRIGGER_LOW
 > +#else
 > #define	SMC_IRQ_FLAGS (( \
 > 		   machine_is_omap_h2() \
 > 		|| machine_is_omap_h3() \
 > 		|| machine_is_omap_h4() \
 >		|| (machine_is_omap_innovator() && !cpu_is_omap1510()) \
 > 	) ? IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING)
 > -
 > -
 > +#endif
 > #elif	defined(CONFIG_SH_SH4202_MICRODEV)

Regarding SA_TRIGGER_LOW, include/linux/interrupt.h tells us

/*
  * Migration helpers. Scheduled for removal in 1/2007
  * Do not use for new code !
  */
...
#define SA_TRIGGER_LOW		IRQF_TRIGGER_LOW

Any chance (even if I don't see it at the moment ;) ) to 
integrate IRQF_TRIGGER_LOW instead into the existing 
SMC_IRQ_FLAGS using machine_is_omap_2430sdp and avoiding the 
additional #ifdef?

Cheers

Dirk
