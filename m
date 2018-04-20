From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [regression v4.17-rc0] Re: FORTIFY_SOURCE breaks ARM compilation
 in -next -- was Re: ARM compile failure in Re: linux-next: Tree for Apr 4
Date: Fri, 20 Apr 2018 18:21:09 +0100
Message-ID: <20180420172108.GR10990@n2100.armlinux.org.uk>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404074856.GA9342@amd>
 <20180404175852.GI5700@atomide.com>
 <20180404184622.GA8608@amd>
 <20180404195951.GJ5700@atomide.com>
 <20180404201837.GA9710@amd>
 <20180415173908.GA2024@amd>
 <CAGXu5jK9f62n95sOdJViXHXzQFyCdcsWt9HPvcdSFRp9Qqg0bg@mail.gmail.com>
 <20180420073402.GA9356@amd>
 <CAGXu5j+6D3PiVc9SR4+31ZGDC2r5uWJOw8Sn3cDhXdNqBGH+hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGXu5j+6D3PiVc9SR4+31ZGDC2r5uWJOw8Sn3cDhXdNqBGH+hQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Pavel Machek <pavel@ucw.cz>, Daniel Micay <danielmicay@gmail.com>, Tony Lindgren <tony@atomide.com>, Thorsten Leemhuis <regressions@leemhuis.info>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, =?utf-8?B?TWlja3Vsw6HFoQ==?= Qwertz <abcloriens@gmail.com>, Clayton Craft <clayton@cr>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 20, 2018 at 08:05:17AM -0700, Kees Cook wrote:
> On Fri, Apr 20, 2018 at 12:34 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Sun 2018-04-15 11:00:06, Kees Cook wrote:
> >> On Sun, Apr 15, 2018 at 10:39 AM, Pavel Machek <pavel@ucw.cz> wrote:
> >> > Hi!
> >> >
> >> >> Thanks.
> >> >>
> >> >> Ok, let me try to bisect it. Compile-problem should be easy...
> >> >>
> >> >> Hmm. And as it is compile-problem in single file, it should even be
> >> >> reasonably fast. I did not realize how easy it would be:
> >> >>
> >> >> #!/bin/bash
> >> >> set -e
> >> >> cp config.ok .config
> >> >> yes '' | ARCH=arm make lib/string.o
> >> >>
> >> >> And the winner is:
> >> >>
> >> >> ee333554fed55555a986a90bb097ac7f9d6f05bf is the first bad commit
> >> >> commit ee333554fed55555a986a90bb097ac7f9d6f05bf
> >> >> Author: Jinbum Park <jinb.park7@gmail.com>
> >> >> Date:   Tue Mar 6 01:39:24 2018 +0100
> >> > ...
> >> >
> >> >>     Acked-by: Kees Cook <keescook@chromium.org>
> >> >>     Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
> >> >>     Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >> >
> >> > So I bisect a problem in -next, and patch is merged to Linus,
> >> > _anyway_, breaking compilation there? Neither Jinbum nor Russell even
> >> > bother to comment.
> >>
> >> Hi! Sorry I lost this email in my inbox. It seems this is specific to
> >> a particular subset of arm architectures? (My local builds of arm all
> >> succeed, for example. Can you send your failing config?) I'll take a
> >> closer look on Monday if Daniel doesn't beat me to it.
> >
> > Daniel, Kees: any news?
> >
> > I'm aware you did not specify which Monday :-).
> 
> Hi! Sorry, I got distracted. So the .config you sent me builds fine
> with my cross compiler. I suspect this is something specific to ELDK's
> compiler. I can try some other compiler versions. What version of gcc
> is failing?

Hi Kees,

We know it works fine with:

linux-next's gcc 4.6.3 + binutils 2.22
my gcc 4.7.4 + binutils 2.25
kernelci.org's Linaro GCC 5.3-2016.05 toolchain (gcc 5.3.1 20160412)
Tony's using gcc 7.3.0 + binutils 2.30
Arnd's using mostly gcc 8.0.1 + binutils 2.29
What-ever toolchain Olof's autobuilder is using

which is quite a spread of versions, both binutils and gcc, and they
all work.  The autobuilders plus Arnd's are regularly verifying lots
of kernel trees (including my own) with lots of configurations, and
the identified patch has not reproduced this compile failure there.

Searching google for:

lib/string.c "error: inlining failed in call to always_inline 'strlen': function not inlinable"

gives me only three hits on mail-archive.com for this, all of them
are Pavel's email or a reply to it.  There appears to be no other
reports of compile failure anywhere else on the google-crawled
Internet.

There appears to be no information readily available as to what
compiler versions each ELDK version contains (see
http://www.denx.de/wiki/view/ELDK-5) so providing the eldk-switch
command to us gives us no useful information.

I think more information about Pavel's setup is needed, including:

* compiler version
* environment (any kernel build specific environment variables set?)
* exact make command line

Maybe even showing the exact command used by kbuild to invoke the
C compiler for lib/string.c.

It could simply be a bug in the ELDK GCC version that Pavel's using.
Could it be that DENX have patched gcc for ELDK and subtly broken
it?  We all know distros like to apply patches to packages.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
