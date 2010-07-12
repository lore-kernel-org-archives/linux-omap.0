From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM defconfig files
Date: Mon, 12 Jul 2010 21:06:04 +0100
Message-ID: <20100712200604.GD9897@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org> <20100603181010.GA25779@flint.arm.linux.org.uk> <1275589230.23384.19.camel@c-dwalke-linux.qualcomm.com> <alpine.LFD.2.00.1006031119440.8175@i5.linux-foundation.org> <20100614083214.GA2104@pengutronix.de> <20100630104043.GG11746@pengutronix.de> <20100712155518.GA24144@pengutronix.de> <AANLkTilhI9O6YwnuAylo_jNgwR8VXmpSVJ1kylIYPCGT@mail.gmail.com> <20100712173228.GC9897@n2100.arm.linux.org.uk> <AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Daniel Walker <dwalker@codeaurora.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Eric Miao <eric.miao@canonical.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 12, 2010 at 10:40:36AM -0700, Linus Torvalds wrote:
> On Mon, Jul 12, 2010 at 10:32 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >
> > When you brought up the problem you seemed absolutely convinced
> > that nothing except your solution was going to be acceptable.
> 
> That's not true. What's true is that you didn't seem to _understand_
> my solution, so I tried to push the understanding of it.

That's your point of view.

My viewpoint was that I had read your email, thought of some alternative
solution, proposed it and the result was shot down without any apparant
thought about it.  That gave the impression that you _only_ wanted to
see your own solution.

The result of that has been very little in the way of progress towards
either your, or my alternative solutions - and apart from a few Kconfig
corner quirk patches, the only major work that's happened has been from
Uwe.

So in that regard, I support Uwe's patches as a means to prevent the
impending loss of build coverage from facilities such as linux-next and
the ARM kernel autobuilder, as that's the only option that's currently
available.

As far as timing goes, I see no reason for it to be merged during -rc.
As has already been said, I'm intending _not_ to make the defconfig
situation any worse by accepting patches which add to the mess, as I'm
also mindful that its exactly those kinds of patches are the cause of
this problem.

Now, I'm happy to take Uwe's tree through mine for the next merge
window _iff_ you find his solution acceptable, and you want that to
happen.

I'll also use this opportunity to warn you now - especially as you also
complained about the amount of churn.  There is an effort to try to
allow a single ARM kernel to boot on a wider range of platforms with
more differences than it currently does.  This is going to mean a
certain amount of restructuring, and a lot of additional patches over
time to gradually convert the code.  So, I'm expecting that there will
be even _more_ patches - some fairly big - to come over the next year
or so.

To give an idea - if we change the structure which defines a machine's
properties, we're going to be changing 348 files under arch/arm to match.
Clearly that's also going to give you a problem with diffstat being
swamped.
