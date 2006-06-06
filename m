From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Add minimal OMAP2430 support
Date: Tue, 6 Jun 2006 10:58:56 -0700
Message-ID: <20060606175856.GS16454@atomide.com>
References: <20060605165447.GE16454@atomide.com>
	<20060606030819.75396.qmail@web37903.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060606030819.75396.qmail@web37903.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060605 20:08]:
> --- Tony Lindgren <tony@atomide.com> wrote:
> 
> > 
> > Well one thing we should change is to make it possible to compile in
> > all
> > 24xx boards. This involves changing things like PRCM register access
> > to use a base address instead of ifdefs.
> > 
> > I know we this is quite a bit of work now, but it pays off in the
> > long
> > run. Something like this has proven to work well for portable code
> > across various omaps/platforms: 
> > 
> > #define OMAP2420_PRCM_SOME_BASE	0xaaaaaaaa
> > #define OMAP2430_PRCM_SOME_BASE	0xbbbbbbbb
> > 
> > #define PRCM_SOME_REG1_OFFSET	0x10	
> > #define		REG1_AAAA	(1 << 31)
> > #define		REG1_BBBB	(1 << 30)
> > #define		REG1_CCCC	(1 << 29)
> > 
> > #define PRCM_SOME_REG2_OFFSET	0x20
> > #define		REG2_AAAA	(1 << 2)
> > #define		REG2_BBBB	(1 << 1)
> > #define		REG2_CCCC	(1 << 0)
> > 
> > #define PRCM_SOME_REG3_OFFSET	0x30	
> > 
> > static unsigned long prcm_vbase;
> > 
> > #define prcm_readl(r)		__raw_readl(prcm_vbase + (r))
> > #define prcm_writel(v, r)	__raw_writel((v), prcm_vbase + (r))
> > 
> > static int prcm_do_something(void)
> > {
> > 	u32 reg;
> > 
> > 	reg = prcm_readl(PRCM_SOME_REG1_OFFSET);
> > 	reg |= REG1_BBBB;
> > 	prcm_writel(reg, PRCM_SOME_REG1_OFFSET);
> > }
> > 
> > static int __init prcm_init(void)
> > {
> > 	if (cpu_is_omap2420())
> > 		prcm_vbase = OMAP2420_PRCM_SOME_BASE;
> > 	else if (cpu_is_omap2430())
> > 		prcm_vbase = OMAP2430_PRCM_SOME_BASE;
> > 
> > 	return 0;
> > }
> > 
> 
> Thanx for the review. I will work on this, once I come back from Japan
> :). At home, both the 2430 boards are not-booting and I had tough time
> with CSST and switch settings, so was not able to flash bootloader on
> 2430SDP-EVM ES1.0 chips. But it will not be hard to make compile-only
> patch for review.

OK, cool. I have some 24xx PM related patches coming up that already
convert some part of the PRCM registers to use prcm_readl/writel(). I'll
have those available probably towards the end of the week.

Tony
