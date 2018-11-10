From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] ARM: SoC fixes
Date: Sat, 10 Nov 2018 10:09:19 -0800
Message-ID: <CAOesGMje+-R4Qbtgtj2AvNK+=Q3Rqbo=n8Q2DV4SG9wOv3Kj_w@mail.gmail.com>
References: <20181107171023.zoo6qox5eewy3pmk@localhost> <CAHk-=whF7kBo49-BFTUc-by+HB_0qNw_=+d24TydO2mYwwsWMQ@mail.gmail.com>
 <CAOesGMg3uHJ7YB95skjcVK39kudAGGjKo6909d--LDZmqeE1HA@mail.gmail.com> <20181108154926.GI56134@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108154926.GI56134@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, guillaume.tucker@collabora.com, ARM-SoC Maintainers <arm@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 8, 2018 at 7:49 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Olof Johansson <olof@lixom.net> [181107 09:28]:
> > On Wed, Nov 7, 2018 at 9:17 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Wed, Nov 7, 2018 at 9:10 AM Olof Johansson <olof@lixom.net> wrote:
> > > >
> > > > ARM: SoC fixes
> > >
> > > Pulled.
> > >
> > > > I was a bit too trigger happy to enable PREEMPT on multi_v7_defconfig,
> > > > and it ended up regressing at least BeagleBone XM boards.
> > >
> > > Odd. Did it hit some "may_sleep()" test in a driver that is hidden by
> > > preempt being off? Otherwise I don't see how/why preempt should fail
> > > in a board-specific manner..
> >
> > The board hangs early during boot and the usual way of collecting
> > early console doesn't seem to work when attempted (I haven't tried
> > personally).
> >
> > It's one of the major non-SMP platforms covered by tests. I'd be
> > surprised if it turns out to be truly _board_ specific (and rather
> > specific to OMAP3), but we don't have enough data yet. Chances are it
> > either shuffles some timing around or indeed hits a may_sleep() test
> > somewhere.
> >
> > (I just realized I might have missed to attribute Guillaume in the
> > revert patch. Sorry about that).
>
> Looks like we're missing the stdout-path for earlycon, maybe try
> with the following patch? I can't find my Beagleboard-xm right now,
> time to clean-up a bit I guess.
>
> At least omap3-evm, logicpd-torpedo and n900 all boot with PREEMPT.

To follow up on this, it turned out to be an issue where the kernel
outgrew the location it was loaded to, and overwrite the device tree
on decompression. So, not a code issue.

It's a known fragile aspect on some of the u-boot setups, and
something I've been hit by myself on my farm a few times.

Still, for now we'll keep PREEMPT off until next merge window.


-Olof
