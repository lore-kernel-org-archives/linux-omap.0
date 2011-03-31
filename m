From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Wed, 30 Mar 2011 17:15:32 -0700
Message-ID: <20110331001531.GR18334@atomide.com>
References: <20110317183048.GW7258@atomide.com>
 <AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com>
 <20110318101512.GA15375@n2100.arm.linux.org.uk>
 <201103301906.42429.arnd@arndb.de>
 <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
 <alpine.LFD.2.00.1103301531420.28032@xanadu.home>
 <AANLkTim6zg-U6HtAQbqnENqoK7x8erXSqOuTFVC0YE5r@mail.gmail.com>
 <alpine.LFD.2.00.1103301814250.28032@xanadu.home>
 <20110330235930.GA6680@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110330235930.GA6680@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, David Brown <davidb@codeaurora.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110330 16:57]:
> On Wed, Mar 30, 2011 at 07:31:59PM -0400, Nicolas Pitre wrote:
> 
> > Still, because ARM is just a CPU architecture, those SOC vendors will 
> > always have something new to differenciate themselves from the other SOC 
> > vendors.  And that cannot be described in a table alone. The power 
> > management hardware from TI will still require separate _executable_ 
> > code from the Freescale one, or the Samsung one, or the Nvidia one, or 
> > the Qualcomm one, or the Marvell one, yada yada.  And I really don't 
> > want to see that code turned into some vendor provided buggy ACPI 
> > bytecode or similar.
> 
> To get rid of all the platform related stuff, I think you'd need some
> kind of bytecode to deal with some of the procedural stuff with various
> platforms.  Without bytecode, the only other way is to keep the stuff
> as C functions in the kernel and find some way of binding them to
> drivers through DT, which means we're still going to have platform
> specific C files littering the kernel.

The SoC specific code still needs to be different for things like PM,
but that's pretty small compared to the mux/clock/hwmod data on omaps.

Also I think we can make the PM code into loadable modules eventually.
 
> While I can see DT solving the "declare this data structure" problem,
> I believe that's only part of the issue.

Yup I agree there are other issues too.

> This is exactly why when DT was proposed as a miracle cure-all for ARM,
> I wanted to see DT on a real ARM platform rather than just ARM Ltd's
> simple and similar development boards.
> 
> Certainly, though, DT for ARM is progressing.

At least omap mux/clokc/hwmod data could come either from devicetree
or be a loadable kernel module for most entries.

Regards,

Tony
