From: Felipe Balbi <balbi@ti.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Thu, 31 Mar 2011 14:27:06 +0300
Message-ID: <20110331112706.GJ2267@legolas.emea.dhcp.ti.com>
References: <201103301906.42429.arnd@arndb.de>
 <AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
 <20110331001502.GB6680@n2100.arm.linux.org.uk>
 <AANLkTinE7EDbV8hrYZWBxgvwOxdPMLoS0Y57PSm04rvM@mail.gmail.com>
 <AANLkTik-BFTzyPLuYVdhCJPocc0wPY0rKvO7BQS4Fg1S@mail.gmail.com>
 <AANLkTikd_JRxmB_OWZqq178=K3bnxhdDqcNbgFNRtTyU@mail.gmail.com>
 <AANLkTimS_8BnBz9MSdxYJVL6oreEpH=W61BsyuX2G+Xz@mail.gmail.com>
 <AANLkTimtO7vR2AQvJj1hHMqHCDqtoiJX_eENE9o3dPpV@mail.gmail.com>
 <AANLkTimPJCiaUyTfcR1NSPivJ2YjSwazhiWRC-CPLy6J@mail.gmail.com>
 <AANLkTi=fSUizM38SkBhPAzSbArgoNQxbV8JrC51x_RDf@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=fSUizM38SkBhPAzSbArgoNQxbV8JrC51x_RDf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bill Gatliff <bgat@billgatliff.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Mar 30, 2011 at 08:24:30PM -0700, Linus Torvalds wrote:
> So let's take a really simple example of this kind of crap.
> 
> Do this:
> 
>     git ls-files arch/arm/ | grep gpio
> 
> and cry. That's 145 files in the arm directory that are some kind of
> crazy gpio support.

Most likely those are remanescent from times when we didn't have
gpiolib. It's not long ago (about 2 years) that David Brownell (rip, my
friend) introduced it to the kernel. So those should be converted to
gpiolib and moved to drivers/gpio/ but it doesn't mean we don't need
that piece of code.

With different register layout, register offsets, register sizes, etc,
it would be way uglier to combine all those into one big hacky driver.

-- 
balbi
