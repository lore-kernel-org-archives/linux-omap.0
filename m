From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 18:33:25 +0000
Message-ID: <20130221183325.GE17852@n2100.arm.linux.org.uk>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk> <20130221173707.76A7D200671@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130221173707.76A7D200671@gemini.denx.de>
Sender: linux-kbuild-owner@vger.kernel.org
To: Wolfgang Denk <wd@denx.de>
Cc: Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, linux-kbuild@vger.kernel.org, tony@atomide.com, Grant Likely <grant.likely@secretlab.ca>, Joel A Fernandes <agnel.joel@gmail.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

[uboot list deleted again]

On Thu, Feb 21, 2013 at 06:37:07PM +0100, Wolfgang Denk wrote:
> Dear Russell,
> 
> In message <20130221134656.GC17852@n2100.arm.linux.org.uk> you wrote:
> >
> > > Note that FIT images are relatively old (docs date back to March
> > > 2008).  This is more of another effort to try and update what the
> > > kernel uses.
> > 
> > So it's five years old and people haven't been that interested in it so
> > far.  That speaks volumes...
> 
> Well, your attitude to (not) accept anything like that is well known;
> there have been few previews attempts, which have all been rejected in
> basicly the same way.

_My_ attitude?

I'll point out something fundamental here: _our_ kernels native format
has not changed over the last 15+ years, and continues to work everywhere
where uboot is not involved, and continues to work where uboot is
involved provided its wrapped up in silly uboot formats.

That means we designed it right back in the early days.  The fact that
uboot has to reinvent the wheel shows that there were wrong design
decisions made that did not cater for the situations that people
encountered in the future.

Now, as for "have all been rejected in basic_al_ly the same way" that's
not true.  What you'll notice is that there's been discussions over the
years about FIT, which never went anywhere for various reasons (some of
them I was not involved with.)  And during those discussions, uboot's
continued refusal to use the native zImage format ended up getting
fixed by those who raised (and continue to raise) concerns about uboots
fixation with its file formats and the built-in restrictions of them.

> But now the situation has changed - multiplatform support adds a
> number of use cases where this feature comes in handy, so it pops up
> again.

No, the situation hasn't changed.  We're still talking about booting
a kernel image in several platforms.  That's been the situation since
the 1990s.

And boot loaders from the 1990s and early 2000s have been able to do
this _long_ before uboot.

What's changed is the number of platforms, and the apparant acceptance
of uboot as "the official boot loader" because it's seen as having its
own format integrated into the kernel itself.
