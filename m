From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [GIT PULL] fbdev changes for 3.8
Date: Sun, 16 Dec 2012 22:00:32 -0800
Message-ID: <20121217060032.GB13300@core.coreip.homeip.net>
References: <50CAFDFF.3070802@ti.com>
 <CA+55aFz9+3mOZcjJ9C-izKkidT9mxeO7xUubJER0OTjcZjE=2A@mail.gmail.com>
 <20121215222431.GA7153@redhat.com>
 <20121216174613.GA18490@atomide.com>
 <20121216203536.GR4989@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121216203536.GR4989@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Felipe Balbi <balbi@ti.com>, Evgeniy Polyakov <zbr@ioremap.net>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

On Sun, Dec 16, 2012 at 12:35:37PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [121216 09:49]:
> > * Dave Jones <davej@redhat.com> [121215 14:27]:
> > > On Sat, Dec 15, 2012 at 01:11:04PM -0800, Linus Torvalds wrote:
> > >  > On Fri, Dec 14, 2012 at 2:22 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > >  > > Hi Linus,
> > >  > >
> > >  > > Florian, the fbdev maintainer, has been very busy lately, so I offered to send
> > >  > > the pull request for fbdev for this merge window.
> > >  > 
> > >  > Pulled. However, with this I get the Kconfig question
> > >  > 
> > >  >    OMAP2+ Display Subsystem support (OMAP2_DSS) [N/m/y/?] (NEW)
> > >  > 
> > >  > which doesn't make a whole lot of sense on x86-64, unless there's
> > >  > something about OMAP2 that I don't know.
> > >  > 
> > >  > So I'd suggest making that OMAP2_DSS be dependent on OMAP2. Or at
> > >  > least ARM. Because showing it to anybody else seems insane.
> > >  > 
> > >  > Same goes for FB_OMAP2 for that matter. I realize that it's likely
> > >  > nice to get compile testing for this on x86-64 too, but if that's the
> > >  > intent, we need to think about it some more. I don't think it's good
> > >  > to ask actual normal users questions like this just for compile
> > >  > coverage.
> > > 
> > > This OMAP stuff has been creeping into x86 builds for a while.
> > > Grep from my current build config ..
> > > 
> > > # CONFIG_OMAP_OCP2SCP is not set
> > > # CONFIG_KEYBOARD_OMAP4 is not set
> > > # CONFIG_OMAP2_DSS is not set
> > > # CONFIG_OMAP_USB2 is not set
> > > 
> > > There was some other arm-ism that does the same that I' currently forgetting,
> > > or maybe that got fixed..
> > 
> > Those are all omap internal devices and should be all marked with
> > depends on ARCH_OMAP2PLUS.
> > 
> > It's a different story for external devices that may be used on other
> > architectures.
> > 
> > I only came up with one reason to compile internal devices for other
> > architectures: In some cases the driver subsystem maintainer may want to
> > be able to compile test subsystem wide changes without having to compile
> > for each target separately. But for those cases it's trivial to carry a
> > compile test patch that just drops the depends Kconfig entries.
> 
> And here's a patch to limit the omap drivers above to omap only.

Do you think we could add a new symbol to debug options, something like
COMPILE_COVERAGE, and have drivers that can be compiled on platforms
other than ones having the hardware to do

	depend on ARCH_XXX || COMPILE_CONVERAGE

This way people who want to do compile coverage do not have to carry
patches and allyesconfig will pick this right up.

Thanks.

-- 
Dmitry
