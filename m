From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: head-common.S: Clear lr before jumping to
 start_kernel()
Date: Mon, 16 Oct 2017 13:29:09 +0100
Message-ID: <20171016122908.GJ23750@n2100.armlinux.org.uk>
References: <1507044184-27152-1-git-send-email-geert+renesas@glider.be>
 <nycvar.YSQ.7.76.1710031134140.5407@knanqh.ubzr>
 <CAMuHMdWJKQb5JY+diH=7dqNuypkPUqBeOEPSLOrfrnbfh2siRQ@mail.gmail.com>
 <CAMuHMdXpPfipmEdW0Dap6Pjwhz3QxLcrcbtU0RhCu721k-sBpA@mail.gmail.com>
 <CAMuHMdWH_pebSYAp04gmVceu3qqPczGaXS36R8CtzAYHo-CNog@mail.gmail.com>
 <20171010203324.GX4394@atomide.com>
 <20171012102341.GF23750@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710121123530.1718@knanqh.ubzr>
 <20171014141405.GG23750@n2100.armlinux.org.uk>
 <CAMuHMdX7Z0D2unRqC9z04f0MVsxLuVxouvquyYBHKavnycfh=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdX7Z0D2unRqC9z04f0MVsxLuVxouvquyYBHKavnycfh=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Tony Lindgren <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Chris Brandt <Chris.Brandt@renesas.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Oct 15, 2017 at 10:04:16AM +0200, Geert Uytterhoeven wrote:
> On Sat, Oct 14, 2017 at 4:14 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > Thanks, it would've been good to have known that ahead of time.
> >
> > It's why the patch system has the KernelVersion: tag:
> >
> >  6. Kernel version.
> >     On a separate line, add a tag "KernelVersion: " followed by the kernel
> >     version that the patch was generated against. This should be formatted
> >     as "KernelVersion: 2.6.0-rmk1"
> >
> > This is because that information is relevant for knowing where it should
> > be applied, and to which branch.  Having it be something else means I
> > have to guess, and that can result in the patch being discarded in this
> > manner if I don't find where it's supposed to be applied.
> 
> That's why we have the standard Fixes tag, which was included
> Fixes: 9520b1a1b5f7a348 ("ARM: head-common.S: speed up startup code")

Wrong.  You're confusing two different things.

The fixes tag identifies the commit to which the FIX applies.  That's
not what the kernelversion tag described above is for.  That's to
describe where the patch was GENERATED, so that it's easier to know
where it should be applied.

> It's trivial for the repo maintainer to know which branch the fix to
> apply to, given the Fixes tag.
> It's non-trivial to know the branch for the patch submitter, who is
> forced to use a non-standard patch submission system.

So what you're telling me is that you're unable to describe what commit
or the kernel version that the patch was GENERATED against.

I /really/ don't buy such an argument one bit.  If you don't have that
information, by definition you can't generate a git patch.

If it was trivial, then don't you think the patch would've been applied
without all this crap?  The proof is here in this thread, it's not as
trivial as you think it is.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
