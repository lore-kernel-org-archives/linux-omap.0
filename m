From: Tony Lindgren <tony@atomide.com>
Subject: Re: Ethernet issue in most recent git?
Date: Thu, 19 Jan 2006 13:58:02 -0800
Message-ID: <20060119215802.GN4425@atomide.com>
References: <43CFD135.4090604@de.bosch.com> <20060119181207.GI4425@atomide.com>
	<43CFF2C8.6090307@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43CFF2C8.6090307@de.bosch.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@de.bosch.com> [060119 12:13]:
> Tony Lindgren wrote:
> >>Telnet and ping don't work as well. I imagine that I doesn't change any 
> >>configuration, only kernel update form git. UBoots tftpboot works quite 
> >>well.
> >
> >Same problem here. I'd assume it's the recent "IRQ type flags" patch
> >that does not work properly for omap gpio interrupts.
> 
> Thanks for the hint! Please try quick hack for OSK ethernet in the
> attachment.
> 
> With
> 
> -- cut --
> [PATCH] IRQ type flags
> /include/asm-arm/irq.h
> blob:59975ee43cf139138503288801c7d8758dada859 ->
> blob:7772432d3fd7750506943eaf88ea7eda9e720a7d
> --- include/asm-arm/irq.h
> +++ include/asm-arm/irq.h
> @@ -25,10 +25,14 @@ extern void disable_irq_nosync(unsigned
> extern void disable_irq(unsigned int);
> extern void enable_irq(unsigned int);
> -#define __IRQT_FALEDGE (1 << 0)
> -#define __IRQT_RISEDGE (1 << 1)
> -#define __IRQT_LOWLVL (1 << 2)
> -#define __IRQT_HIGHLVL (1 << 3)
> +/*
> + * These correspond with the SA_TRIGGER_* defines, and therefore the
> + * IRQRESOURCE_IRQ_* defines.
> + */
> +#define __IRQT_RISEDGE (1 << 0)
> +#define __IRQT_FALEDGE (1 << 1)
> +#define __IRQT_HIGHLVL (1 << 2)
> +#define __IRQT_LOWLVL (1 << 3)
> #define IRQT_NOEDGE (0)
> #define IRQT_RISING (__IRQT_RISEDGE)

Ah, that explains!

> 
> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blobdiff;h=7772432d3fd7750506943eaf88ea7eda9e720a7d;hp=59975ee43cf139138503288801c7d8758dada859;hb=9ded96f24c3a5fcbef954e88c443385a1af37eb9;f=include/asm-arm/irq.h
> 
> the meaning of __IRQT_RISEDGE and __IRQT_FALEDGE was inverted :( So I
> think we have to exchange _all_ places in OMAP code where these are used?

We should be able to just remap them in gpio.c. I believe there's a note
there somewhere saying that by coincidence the bits are the same in omap
hw as in irq.h...

Tony
