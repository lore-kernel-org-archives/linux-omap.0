From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: SoC fixes
Date: Thu, 8 Nov 2018 07:49:26 -0800
Message-ID: <20181108154926.GI56134@atomide.com>
References: <20181107171023.zoo6qox5eewy3pmk@localhost>
 <CAHk-=whF7kBo49-BFTUc-by+HB_0qNw_=+d24TydO2mYwwsWMQ@mail.gmail.com>
 <CAOesGMg3uHJ7YB95skjcVK39kudAGGjKo6909d--LDZmqeE1HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMg3uHJ7YB95skjcVK39kudAGGjKo6909d--LDZmqeE1HA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, guillaume.tucker@collabora.com, ARM-SoC Maintainers <arm@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Olof Johansson <olof@lixom.net> [181107 09:28]:
> On Wed, Nov 7, 2018 at 9:17 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, Nov 7, 2018 at 9:10 AM Olof Johansson <olof@lixom.net> wrote:
> > >
> > > ARM: SoC fixes
> >
> > Pulled.
> >
> > > I was a bit too trigger happy to enable PREEMPT on multi_v7_defconfig,
> > > and it ended up regressing at least BeagleBone XM boards.
> >
> > Odd. Did it hit some "may_sleep()" test in a driver that is hidden by
> > preempt being off? Otherwise I don't see how/why preempt should fail
> > in a board-specific manner..
> 
> The board hangs early during boot and the usual way of collecting
> early console doesn't seem to work when attempted (I haven't tried
> personally).
> 
> It's one of the major non-SMP platforms covered by tests. I'd be
> surprised if it turns out to be truly _board_ specific (and rather
> specific to OMAP3), but we don't have enough data yet. Chances are it
> either shuffles some timing around or indeed hits a may_sleep() test
> somewhere.
> 
> (I just realized I might have missed to attribute Guillaume in the
> revert patch. Sorry about that).

Looks like we're missing the stdout-path for earlycon, maybe try
with the following patch? I can't find my Beagleboard-xm right now,
time to clean-up a bit I guess.

At least omap3-evm, logicpd-torpedo and n900 all boot with PREEMPT.

Regards,

Tony

8< ----------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 8 Nov 2018 07:43:28 -0800
Subject: [PATCH] ARM: dts: Add missing earlycon UART for Beagleboard

We can get early boot messages if CONFIG_SERIAL_EARLYCON=y is set, and
kernel commandline has debug earlycon. But we're missing the related dts
entry for Beagleboard.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Note: Untested, I can't find my Beagleboard-XM right now..

---
 arch/arm/boot/dts/omap3-beagle.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -24,6 +24,10 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	chosen {
+		stdout-path = &uart3;
+	};
+
 	aliases {
 		display0 = &dvi0;
 		display1 = &tv0;
-- 
2.19.1
