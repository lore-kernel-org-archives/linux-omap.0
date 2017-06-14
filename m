From: Hoeun Ryu <hoeun.ryu@gmail.com>
Subject: Re: [RESEND PATCH 1/2] arm:omap2+: put omap_uart_phys/virt/lsr in
 .text section when ZIMAGE is true
Date: Wed, 14 Jun 2017 15:48:46 +0900
Message-ID: <1497422926.1935.4.camel@gmail.com>
References: <1497316206-11110-1-git-send-email-hoeun.ryu@gmail.com>
         <20170614052750.GC3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614052750.GC3730@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2017-06-13 at 22:27 -0700, Tony Lindgren wrote:
> Hi,
> 
> * Hoeun Ryu <hoeun.ryu@gmail.com> [170612 18:18]:
> > 
> > --- a/arch/arm/include/debug/omap2plus.S
> > +++ b/arch/arm/include/debug/omap2plus.S
> > @@ -58,11 +58,22 @@
> >  
> >  #define UART_OFFSET(addr)	((addr) & 0x00ffffff)
> >  
> > +/*
> > + * Definition of ZIMAGE is in arch/arm/boot/compressed/Makefile.
> > + * Place the following block in .text section only when this file
> > is
> > + * included by arch/arm/boot/compressed/* to make it possible to
> > + * enable CONFIG_DEBUG_UNCOMPRESS and DEBUG in
> > arch/arm/boot/compressed/head.S
> > + * on OMAP2+ SoCs.
> > + */
> > +#ifndef ZIMAGE
> >  		.pushsection .data
> > +#endif
> >  omap_uart_phys:	.word	0
> >  omap_uart_virt:	.word	0
> >  omap_uart_lsr:	.word	0
> > +#ifndef ZIMAGE
> >  		.popsection
> > +#endif
> So I converted all these to use the 8250 debug_ll yesterday
> which should solve the DEBUG_UNCOMPRESS issue for you and
> allows us to remove this file. Will post the series shortly
> for testing with you in Cc after I've done a bit more testing
> here.

It sounds good.
patch 01 is dropped though, are you using the second patch ?
"[PATCH 2/2] arm:omap2+: drop dependence on DEBUG_OMAP2PLUS_UART for
DEBUG_UNCOMPRESS"

Thank you.

> 
> Regards,
> 
> Tony
