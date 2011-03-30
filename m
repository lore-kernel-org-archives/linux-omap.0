From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Wed, 30 Mar 2011 15:39:46 -0700
Message-ID: <20110330223946.GL18334@atomide.com>
References: <20110317183048.GW7258@atomide.com>
 <AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com>
 <20110318101512.GA15375@n2100.arm.linux.org.uk>
 <201103301906.42429.arnd@arndb.de>
 <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
 <20110330214437.GH18334@atomide.com>
 <AANLkTikE5LXMkaSH4t4=DPvAOWXDh5Zyp0ESi=v2mra3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikE5LXMkaSH4t4=DPvAOWXDh5Zyp0ESi=v2mra3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Brown <davidb@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-omap@vger.kernel.org

* Linus Torvalds <torvalds@linux-foundation.org> [110330 15:18]:
> On Wed, Mar 30, 2011 at 2:44 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> But for ARM, I suspect even ACPI would actually be an improvement.
> Because on ARM, the crazy non-platform hw people already happened, and
> took over the insane asylum.  So having a complicated description
> language with an interpreter wouldn't be worse than what we already do
> there.
> 
> I'm only half kidding. I wouldn't wish for ACPI even on ARM. But..

Heh I think the device tree is saner here than ACPI :)
 
> > Anyways, let's plan on kicking out per-SoC and per-board data from
> > the kernel and get it from the bootloader via device tree in the
> > long run. Most of the data is already separate from the code, so
> > it should not be that hard to do, just takes some time.
> 
> This is basically my hope for the future. I just think that ARM people
> should be very very aggressive about it, because the longer it isn't
> done, the more crud there will be to convert.

At least now all that data is in one place in convertable format instead
of direct register tinkering of shared registers in each device driver
probe function..
 
> I bet it will be painful to do. But it will be even more painful to
> _not_ do it, and then five years from now realize that it should have
> been done ten years ago.

Something needs to be done for sure.

Tony
