From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes
Date: Mon, 12 Nov 2018 07:13:24 +0100
Message-ID: <20181112061324.GA28680@Red>
References: <20181107171023.zoo6qox5eewy3pmk@localhost>
 <CAHk-=whF7kBo49-BFTUc-by+HB_0qNw_=+d24TydO2mYwwsWMQ@mail.gmail.com>
 <CAOesGMg3uHJ7YB95skjcVK39kudAGGjKo6909d--LDZmqeE1HA@mail.gmail.com>
 <20181108154926.GI56134@atomide.com>
 <CAOesGMje+-R4Qbtgtj2AvNK+=Q3Rqbo=n8Q2DV4SG9wOv3Kj_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMje+-R4Qbtgtj2AvNK+=Q3Rqbo=n8Q2DV4SG9wOv3Kj_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, guillaume.tucker@collabora.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ARM-SoC Maintainers <arm@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Nov 10, 2018 at 10:09:19AM -0800, Olof Johansson wrote:
> On Thu, Nov 8, 2018 at 7:49 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Olof Johansson <olof@lixom.net> [181107 09:28]:
> > > On Wed, Nov 7, 2018 at 9:17 AM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > On Wed, Nov 7, 2018 at 9:10 AM Olof Johansson <olof@lixom.net> wrote:
> > > > >
> > > > > ARM: SoC fixes
> > > >
> > > > Pulled.
> > > >
> > > > > I was a bit too trigger happy to enable PREEMPT on multi_v7_defconfig,
> > > > > and it ended up regressing at least BeagleBone XM boards.
> > > >
> > > > Odd. Did it hit some "may_sleep()" test in a driver that is hidden by
> > > > preempt being off? Otherwise I don't see how/why preempt should fail
> > > > in a board-specific manner..
> > >
> > > The board hangs early during boot and the usual way of collecting
> > > early console doesn't seem to work when attempted (I haven't tried
> > > personally).
> > >
> > > It's one of the major non-SMP platforms covered by tests. I'd be
> > > surprised if it turns out to be truly _board_ specific (and rather
> > > specific to OMAP3), but we don't have enough data yet. Chances are it
> > > either shuffles some timing around or indeed hits a may_sleep() test
> > > somewhere.
> > >
> > > (I just realized I might have missed to attribute Guillaume in the
> > > revert patch. Sorry about that).
> >
> > Looks like we're missing the stdout-path for earlycon, maybe try
> > with the following patch? I can't find my Beagleboard-xm right now,
> > time to clean-up a bit I guess.
> >
> > At least omap3-evm, logicpd-torpedo and n900 all boot with PREEMPT.
> 
> To follow up on this, it turned out to be an issue where the kernel
> outgrew the location it was loaded to, and overwrite the device tree
> on decompression. So, not a code issue.
> 
> It's a known fragile aspect on some of the u-boot setups, and
> something I've been hit by myself on my farm a few times.
> 
> Still, for now we'll keep PREEMPT off until next merge window.
> 

Hello

Note that CONFIG_PREEMPT cause some errors also on sun8i-a83t-bananapi-m3
Already reported https://lkml.org/lkml/2017/12/29/139

Regards
