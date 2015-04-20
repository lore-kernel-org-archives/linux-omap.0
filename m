From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Mon, 20 Apr 2015 16:40:32 -0700
Message-ID: <20150420234032.GM18048@atomide.com>
References: <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
 <20150407135713.GL4027@n2100.arm.linux.org.uk>
 <20150407152207.GM18048@atomide.com>
 <20150408230658.GO4027@n2100.arm.linux.org.uk>
 <20150409134843.GQ4027@n2100.arm.linux.org.uk>
 <20150415163108.GB2033@earth>
 <20150416160858.GH18048@atomide.com>
 <20150417184156.GA3326@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:45927 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003AbbDTXng (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Apr 2015 19:43:36 -0400
Content-Disposition: inline
In-Reply-To: <20150417184156.GA3326@earth>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Sebastian Reichel <sre@kernel.org> [150417 11:43]:
> On Thu, Apr 16, 2015 at 09:08:58AM -0700, Tony Lindgren wrote:
> > * Sebastian Reichel <sre@kernel.org> [150415 09:32]:
> > > Hi,
> > > 
> > > On Thu, Apr 09, 2015 at 02:48:43PM +0100, Russell King - ARM Linux wrote:
> > > > On Thu, Apr 09, 2015 at 12:06:58AM +0100, Russell King - ARM Linux wrote:
> > > > > On Tue, Apr 07, 2015 at 08:22:08AM -0700, Tony Lindgren wrote:
> > > > > > Works for me. The above needs the following fix folded in to build:
> > > > > > 
> > > > > > --- a/arch/arm/mm/proc-v7.S
> > > > > > +++ b/arch/arm/mm/proc-v7.S
> > > > > > @@ -532,7 +532,7 @@ __v7_ca9mp_proc_info:
> > > > > >  __v7_ca8_proc_info:
> > > > > >  	.long	0x410fc080
> > > > > >  	.long	0xff0ffff0
> > > > > > -	__v7_proc __v7_ca8mp_proc_info, proc_fns = ca8_processor_functions
> > > > > > +	__v7_proc __v7_ca8_proc_info, __v7_setup, proc_fns = ca8_processor_functions
> > > > > >  	.size	__v7_ca8_proc_info, . - __v7_ca8_proc_info
> > > > > >  
> > > > > >  #endif	/* CONFIG_ARM_LPAE */
> > > > > 
> > > > > Thanks, merged into the original patch.
> > > > 
> > > > Do you want to give me an ack for this, thanks?
> > > 
> > > I tried to test this together with Tony's follow up patch, but I get
> > > this after applying the patch to v4.0:
> > > 
> > > sre@earth ~/src/linux [430973-fix] % make -j4
> > >   CHK     include/config/kernel.release
> > >   CHK     include/generated/uapi/linux/version.h
> > >   CHK     include/generated/utsrelease.h
> > > make[1]: 'include/generated/mach-types.h' is up to date.
> > >   CALL    scripts/checksyscalls.sh
> > >   CHK     include/generated/compile.h
> > >   AS      arch/arm/mm/proc-v7.o
> > > arch/arm/mm/proc-v7.S: Assembler messages:
> > > arch/arm/mm/proc-v7.S:535: Error: invalid operands (*ABS* and .text sections) for `|'
> > > arch/arm/mm/proc-v7.S:535: Error: invalid operands (*ABS* and .text sections) for `|'
> > > scripts/Makefile.build:294: recipe for target 'arch/arm/mm/proc-v7.o' failed
> > > make[1]: *** [arch/arm/mm/proc-v7.o] Error 1
> > > Makefile:947: recipe for target 'arch/arm/mm' failed
> > > make: *** [arch/arm/mm] Error 2
> > > make: *** Waiting for unfinished jobs....
> > 
> > Maybe test the version in Linux next:
> > 
> > a6d746789825 ("ARM: proc-v7: avoid errata 430973 workaround for non-Cortex A8 CPUs")
> 
> DONE with your your patch added on top:
> 
> Tested-By: Sebastian Reichel <sre@kernel.org>
> 
> (on N900)

OK thanks, patch now uploaded to Russell's patch system:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8345/1
 
> I guess we should also drop the CONFIG_ARM_ERRATA_430973 check from
> pdata-quirks' nokia_n900_legacy_init() and just enable it unconditionally.

Yeah makes sense to me.

Regards,

Tony
