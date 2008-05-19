From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/9] OMAP: Add new function to check wether there is
	irq pending
Date: Mon, 19 May 2008 11:54:51 -0700
Message-ID: <20080519185449.GL23002@atomide.com>
References: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com> <1210935435-27617-1-git-send-email-jouni.hogander@nokia.com> <20080516154425.GE23002@atomide.com> <87od724t47.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56131 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbYESSys (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2008 14:54:48 -0400
Content-Disposition: inline
In-Reply-To: <87od724t47.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* Högander Jouni <jouni.hogander@nokia.com> [080519 01:05]:
> "ext Tony Lindgren" <tony@atomide.com> writes:
> 
> > Hi,
> >
> > * Jouni Hogander <jouni.hogander@nokia.com> [080516 03:57]:
> >> Add common omap2/3 function to check wether there is irq pending.
> >> Switch to use it in omap2 pm code instead of its own.
> >> 
> >> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> >> ---
> >>  arch/arm/mach-omap2/irq.c        |   29 +++++++++++++++++++++++------
> >>  arch/arm/mach-omap2/pm24xx.c     |   19 +++----------------
> >>  include/asm-arm/arch-omap/irqs.h |    1 +
> >>  3 files changed, 27 insertions(+), 22 deletions(-)
> >> 
> >> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> >> index ac062ee..f1e1e2e 100644
> >> --- a/arch/arm/mach-omap2/irq.c
> >> +++ b/arch/arm/mach-omap2/irq.c
> >> @@ -20,12 +20,13 @@
> >>  
> >>  /* selected INTC register offsets */
> >>  
> >> -#define INTC_REVISION	0x0000
> >> -#define INTC_SYSCONFIG	0x0010
> >> -#define INTC_SYSSTATUS	0x0014
> >> -#define INTC_CONTROL	0x0048
> >> -#define INTC_MIR_CLEAR0	0x0088
> >> -#define INTC_MIR_SET0	0x008c
> >> +#define INTC_REVISION		0x0000
> >> +#define INTC_SYSCONFIG		0x0010
> >> +#define INTC_SYSSTATUS		0x0014
> >> +#define INTC_CONTROL		0x0048
> >> +#define INTC_MIR_CLEAR0		0x0088
> >> +#define INTC_MIR_SET0		0x008c
> >> +#define INTC_PENDING_IRQ0	0x0098
> >>  
> >>  /*
> >>   * OMAP2 has a number of different interrupt controllers, each interrupt
> >> @@ -122,6 +123,22 @@ static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
> >>  	intc_bank_write_reg(1 << 0, bank, INTC_SYSCONFIG);
> >>  }
> >>  
> >> +int omap_irq_pending(void)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
> >> +		struct omap_irq_bank *bank = irq_banks + i;
> >> +		int irq;
> >> +
> >> +		for (irq = 0; irq < bank->nr_irqs; irq += 32)
> >> +			if (intc_bank_read_reg(bank, INTC_PENDING_IRQ0 +
> >> +					       ((irq >> 5) << 5)))
> >> +				return 1;
> >> +	}
> >> +	return 0;
> >> +}
> >> +
> >
> > In this case it should be enough to know if anything is set in the
> > bank registers, so you should be able to leave out the second for loop.
> > At most you need to read only the four bank registers. No need to check
> > for individual interrupts.
> 
> Current code is presenting each interrupt controller as a bank. I
> think in TRM they are talking about banks in each controller. So there
> is three banks in mpu intc 0..2. This is in arch/arm/mach-omap2/irq.c:
> 
>  * OMAP2 has a number of different interrupt controllers, each interrupt
>  * controller is identified as its own "bank". Register definitions are
>  * fairly consistent for each bank, but not all registers are implemented
>  * for each bank.. when in doubt, consult the TRM.
>  */
> 
> So the first loop is going through controllers which is only mpu
> intc. Second loop is going through bank registers. I'm using irq only
> for finding out right offset for bank register. This is another
> implementation. Which does exactly same thing:
> 
> int omap_irq_pending(void)
> {
> 	int i, j;
> 
> 	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
> 		struct omap_irq_bank *bank = irq_banks + i;
> 
> 		for (j = 0; j < 3; j++)
> 			if (intc_bank_read_reg(bank, INTC_PENDING_IRQ0 +
> 					       0x20 * j))
> 				return 1;
> 	}
> 	return 0;
> }
> 
> If you think this is better I can change it. In first version I was
> just trying to follow practices used in irq.c for finding out offsets.

Hmm, AFAIK, something like below should be enough to see if any interrupts
are pending (patch untested). See also include/asm-arm/arch-omap/entry-macro.S
and what pm.c was doing.

Regards,

Tony



--SUOF0GtieIMvvwua
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="irq-pending.patch"

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index ac062ee..aef28ab 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -26,6 +26,7 @@
 #define INTC_CONTROL	0x0048
 #define INTC_MIR_CLEAR0	0x0088
 #define INTC_MIR_SET0	0x008c
+#define INTC_PENDING	0x0098
 
 /*
  * OMAP2 has a number of different interrupt controllers, each interrupt
@@ -122,6 +123,20 @@ static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
 	intc_bank_write_reg(1 << 0, bank, INTC_SYSCONFIG);
 }
 
+int omap_irq_pending(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
+		struct omap_irq_bank *bank = irq_banks + i;
+
+		if (intc_bank_read_reg(bank, INTC_PENDING))
+			return 1;
+	}
+
+	return 0;
+}
+
 void __init omap_init_irq(void)
 {
 	unsigned long nr_irqs = 0;

--SUOF0GtieIMvvwua--
