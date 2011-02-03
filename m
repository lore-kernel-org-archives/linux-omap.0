From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/5] ARM: omap4: Correct definition of do_wfi() for
	CONFIG_THUMB2_KERNEL
Date: Thu, 3 Feb 2011 19:07:58 +0000
Message-ID: <20110203190758.GA15004@n2100.arm.linux.org.uk>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org> <1296756161-26092-2-git-send-email-dave.martin@linaro.org> <b0242fa556f17e47222fa7f30a36d75b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34110 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932430Ab1BCTIU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 14:08:20 -0500
Content-Disposition: inline
In-Reply-To: <b0242fa556f17e47222fa7f30a36d75b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

On Fri, Feb 04, 2011 at 12:09:34AM +0530, Santosh Shilimkar wrote:
> > -----Original Message-----
> > From: Dave Martin [mailto:dave.martin@linaro.org]
> > Sent: Thursday, February 03, 2011 11:33 PM
> > To: linux-arm-kernel@lists.infradead.org
> > Cc: Dave Martin; Tony Lindgren; Santosh Shilimkar; Jean Pihet;
> > linux-omap@vger.kernel.org; Nicolas Pitre
> > Subject: [PATCH v2 1/5] ARM: omap4: Correct definition of do_wfi()
> > for CONFIG_THUMB2_KERNEL
> >
> > For the Thumb-2 case, the "wfi" mnemonic is used, since in this
> > case the tools will necessarily be new enough to support it.
> >
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> I guess, we discussed this patch in your previous post.
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> > ---
> >  arch/arm/mach-omap2/include/mach/omap4-common.h |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h
> > b/arch/arm/mach-omap2/include/mach/omap4-common.h
> > index 5b0270b..68ce058 100644
> > --- a/arch/arm/mach-omap2/include/mach/omap4-common.h
> > +++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
> > @@ -17,8 +17,13 @@
> >   * wfi used in low power code. Directly opcode is used instead
> >   * of instruction to avoid mulit-omap build break
> >   */
> > +#ifdef CONFIG_THUMB2_KERNEL
> > +#define do_wfi()			\
> > +		__asm__ __volatile__ ("wfi" : : : "memory")
> > +#else
> >  #define do_wfi()			\
> >  		__asm__ __volatile__ (".word	0xe320f003" : : :
> > "memory")
> > +#endif

We actually have this:

#if __LINUX_ARM_ARCH__ >= 7 ||          \
        (__LINUX_ARM_ARCH__ == 6 && defined(CONFIG_CPU_32v6K))
#define sev()   __asm__ __volatile__ ("sev" : : : "memory")
#define wfe()   __asm__ __volatile__ ("wfe" : : : "memory")
#define wfi()   __asm__ __volatile__ ("wfi" : : : "memory")
#endif

in asm/system.h, so maybe it should be using wfe() from asm/system.h ?
