From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 0/4 RFC]OMAP:GPIO: Make GPIO an early init device
Date: Tue, 16 Feb 2010 20:36:37 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF809F@dbde02.ent.ti.com>
References: <20100215174928.GC21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46243 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755165Ab0BPPGp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 10:06:45 -0500
In-Reply-To: <20100215174928.GC21755@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Monday, February 15, 2010 11:19 PM
> To: Paul Walmsley
> Cc: Varadarajan, Charulatha; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 0/4 RFC]OMAP:GPIO: Make GPIO an early init device
> 
> * Paul Walmsley <paul@pwsan.com> [100214 17:38]:
> > On Fri, 12 Feb 2010, Paul Walmsley wrote:
> >
> > > On Fri, 12 Feb 2010, Varadarajan, Charulatha wrote:
> > >
> > > >   OMAP: Convert GPIO into a early driver
> > >
> > > The above patch appears to be missing.  Could you please re-send?
> >
> > This patch was too big for the mailing list, so it's been posted here:


Thanks Paul.

> >
> > http://www.pwsan.com/omap/patches/gpio/0002-OMAP-GPIO-split-omap1-and-
> omap2.patch
> 
> What, make two almost identical copies of the shared code? No way!
> Instead, please keep the common code under plat-omap:
> 
> arch/arm/plat-omap/gpio.c
> 
> Then implement the processor specific functions:
> 
> arch/arm/mach-omap1/gpio.c
> arch/arm/mach-omap2/gpio.c
> arch/arm/mach-omap2/gpio24xx.c
> arch/arm/mach-omap2/gpio44xx.c
> 
> Then have a subsys_initcall in processor specific implementation
> that sets the function pointers in the common code.
> 
Tony,

The current gpio.c has functions with code similar as mentioned below:
{
	#ifdef CONFIG_ARCH_OMAP1
		Get the reg offset for OMAP1
	#endif
	#ifdef CONFIG_ARCH_OMAP15XX
		Get the reg offset for OMAP15XX
	#endif
	#ifdef CONFIG_ARCH_OMAP16XX
		Get the reg offset for OMAP16XX
	#endif
	#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
		Get the reg offset for this OMAP
	#endif
	#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
		Get the reg offset for OMAP2&3
	#endif
	#if defined(CONFIG_ARCH_OMAP4)
		Get the reg offset for OMAP4
	#endif

	Read/write the register 
}

If function pointers are used in common code (plat-omap/gpio.c), the API's in this file would essentially do nothing but invoke these pointers. IMHO this is simply adding one unnecessary level of indirection. 
Please correct me if I am missing out something.

> Regards,
> 
> Tony
