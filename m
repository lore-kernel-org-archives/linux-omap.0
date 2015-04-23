From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Thu, 23 Apr 2015 11:25:42 +0100
Message-ID: <20150423102542.GZ4027@n2100.arm.linux.org.uk>
References: <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
 <20150407135713.GL4027@n2100.arm.linux.org.uk>
 <20150407152207.GM18048@atomide.com>
 <20150408230658.GO4027@n2100.arm.linux.org.uk>
 <20150409134843.GQ4027@n2100.arm.linux.org.uk>
 <20150415163108.GB2033@earth>
 <20150416160858.GH18048@atomide.com>
 <20150417184156.GA3326@earth>
 <20150420234032.GM18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:48128 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933097AbbDWKZ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2015 06:25:57 -0400
Content-Disposition: inline
In-Reply-To: <20150420234032.GM18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Apr 20, 2015 at 04:40:32PM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sre@kernel.org> [150417 11:43]:
> > On Thu, Apr 16, 2015 at 09:08:58AM -0700, Tony Lindgren wrote:
> > > * Sebastian Reichel <sre@kernel.org> [150415 09:32]:
> > > > Hi,
> > > > 
> > > > On Thu, Apr 09, 2015 at 02:48:43PM +0100, Russell King - ARM Linux wrote:
> > > > > On Thu, Apr 09, 2015 at 12:06:58AM +0100, Russell King - ARM Linux wrote:
> > > > > > On Tue, Apr 07, 2015 at 08:22:08AM -0700, Tony Lindgren wrote:
> > > > > > > Works for me. The above needs the following fix folded in to build:
> > > > > > > 
> > > > > > > --- a/arch/arm/mm/proc-v7.S
> > > > > > > +++ b/arch/arm/mm/proc-v7.S
> > > > > > > @@ -532,7 +532,7 @@ __v7_ca9mp_proc_info:
> > > > > > >  __v7_ca8_proc_info:
> > > > > > >  	.long	0x410fc080
> > > > > > >  	.long	0xff0ffff0
> > > > > > > -	__v7_proc __v7_ca8mp_proc_info, proc_fns = ca8_processor_functions
> > > > > > > +	__v7_proc __v7_ca8_proc_info, __v7_setup, proc_fns = ca8_processor_functions
> > > > > > >  	.size	__v7_ca8_proc_info, . - __v7_ca8_proc_info
> > > > > > >  
> > > > > > >  #endif	/* CONFIG_ARM_LPAE */
> > > > > > 
> > > > > > Thanks, merged into the original patch.
> > > > > 
> > > > > Do you want to give me an ack for this, thanks?
> > > > 
> > > > I tried to test this together with Tony's follow up patch, but I get
> > > > this after applying the patch to v4.0:
> > > > 
> > > > sre@earth ~/src/linux [430973-fix] % make -j4
> > > >   CHK     include/config/kernel.release
> > > >   CHK     include/generated/uapi/linux/version.h
> > > >   CHK     include/generated/utsrelease.h
> > > > make[1]: 'include/generated/mach-types.h' is up to date.
> > > >   CALL    scripts/checksyscalls.sh
> > > >   CHK     include/generated/compile.h
> > > >   AS      arch/arm/mm/proc-v7.o
> > > > arch/arm/mm/proc-v7.S: Assembler messages:
> > > > arch/arm/mm/proc-v7.S:535: Error: invalid operands (*ABS* and .text sections) for `|'
> > > > arch/arm/mm/proc-v7.S:535: Error: invalid operands (*ABS* and .text sections) for `|'
> > > > scripts/Makefile.build:294: recipe for target 'arch/arm/mm/proc-v7.o' failed
> > > > make[1]: *** [arch/arm/mm/proc-v7.o] Error 1
> > > > Makefile:947: recipe for target 'arch/arm/mm' failed
> > > > make: *** [arch/arm/mm] Error 2
> > > > make: *** Waiting for unfinished jobs....
> > > 
> > > Maybe test the version in Linux next:
> > > 
> > > a6d746789825 ("ARM: proc-v7: avoid errata 430973 workaround for non-Cortex A8 CPUs")
> > 
> > DONE with your your patch added on top:
> > 
> > Tested-By: Sebastian Reichel <sre@kernel.org>
> > 
> > (on N900)
> 
> OK thanks, patch now uploaded to Russell's patch system:
> 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8345/1

I have a concern with that patch.

The reason that it's disabled for multiplatform is because we can't
guarantee that the auxctrl register will be writable.  The solution
we came up with for multiplatform was to require firmware to be
updated to enable this bit.

Enabling it on a platform where firmware has not been updated, but
runs in the non-secure world will lead to the kernel hanging in the
early assembly code.

I've discussed it with Catalin, and Catalin's position is that we
should not remove the !multiplatform conditional.  That's something
which I find that I'm agreeing with Catalin on - any other non-secure
Cortex A8 user who is setting this bit in firmware will instantly
break if this patch is applied.

However, I don't think anyone is willing to say that they have a
solution to this problem - obviously, you can't build OMAP as a
non-multiplatform kernel anymore, so in effect you can never have
the kernel enable this errata.  And you can't detect whether you're
running in secure mode or not.

We could do the "only write the bit if it was originally clear" but
we still have the problem that doing so may cause other people
regressions.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
