From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/10] hwspinlock-next
Date: Wed, 21 Sep 2011 18:21:54 +0200
Message-ID: <201109211821.55058.arnd@arndb.de>
References: <1315846025-11453-1-git-send-email-ohad@wizery.com> <201109211612.33504.arnd@arndb.de> <CACRpkdbqVuFEgntw=bUYka5NuvpbPhjB8L0cD4CTmsjwoZBDSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbqVuFEgntw=bUYka5NuvpbPhjB8L0cD4CTmsjwoZBDSA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

On Wednesday 21 September 2011, Linus Walleij wrote:
> On Wed, Sep 21, 2011 at 4:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > My feeling is that it would be best for Ohad to send these directly
> > to Linus, since it's basically a standalone subsystem and he's listed
> > as the maintainer (well, after this series at least).
> 
> I agree. That's the path of least resistance and trouble.
> 
> If/when ARM-specific driver subsystems need their own zuper-maintainer
> we can deal with it, can't we? There aren't many of them yet.

Definitely, I think that's the ideal case. I would very much like to
see independent subsystem maintainers for the device drivers that are
currently buried in per-architecture or per-platform directories.
Among the ones that we should be moving out of there (or have already)
are cpufreq, gpio, irqchip, pinmux, clock, dmaengine, timer, and there
are probably some more. Since none of these are strictly ARM specific,
my feeling is that they should not be part of the arm or arm-soc tree
in the future but have their own trees.

	Arnd
