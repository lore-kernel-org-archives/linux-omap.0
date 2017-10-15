From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ARM: head-common.S: Clear lr before jumping to start_kernel()
Date: Sun, 15 Oct 2017 10:04:16 +0200
Message-ID: <CAMuHMdX7Z0D2unRqC9z04f0MVsxLuVxouvquyYBHKavnycfh=w@mail.gmail.com>
References: <1507044184-27152-1-git-send-email-geert+renesas@glider.be>
 <nycvar.YSQ.7.76.1710031134140.5407@knanqh.ubzr> <CAMuHMdWJKQb5JY+diH=7dqNuypkPUqBeOEPSLOrfrnbfh2siRQ@mail.gmail.com>
 <CAMuHMdXpPfipmEdW0Dap6Pjwhz3QxLcrcbtU0RhCu721k-sBpA@mail.gmail.com>
 <CAMuHMdWH_pebSYAp04gmVceu3qqPczGaXS36R8CtzAYHo-CNog@mail.gmail.com>
 <20171010203324.GX4394@atomide.com> <20171012102341.GF23750@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710121123530.1718@knanqh.ubzr> <20171014141405.GG23750@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171014141405.GG23750@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Tony Lindgren <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Chris Brandt <Chris.Brandt@renesas.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Oct 14, 2017 at 4:14 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Oct 12, 2017 at 11:25:50AM -0400, Nicolas Pitre wrote:
>> On Thu, 12 Oct 2017, Russell King - ARM Linux wrote:
>>
>> > On Tue, Oct 10, 2017 at 01:33:25PM -0700, Tony Lindgren wrote:
>> > > * Geert Uytterhoeven <geert@linux-m68k.org> [171003 11:32]:
>> > > > On Tue, Oct 3, 2017 at 8:15 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > > > > On Tue, Oct 3, 2017 at 8:11 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > > > >> On Tue, Oct 3, 2017 at 5:37 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> > > > >>> On Tue, 3 Oct 2017, Geert Uytterhoeven wrote:
>> > > > >>> Please send it to RMK's patch system.
>> > > > >>
>> > > > >> Done (I hope so ;-)
>> > > > >
>> > > > > Failed. Retrying.
>> > > >
>> > > > Yiha ;-)
>> > > >
>> > > > http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8702/1
>> > >
>> > > This also fixes the spamming I started seeing with next-20171009:
>> > >
>> > > Tested-by: Tony Lindgren <tony@atomide.com>
>> >
>> > It's all nice and good that people are testing this patch, but I can't
>> > apply it to -rc1, nor my "misc" branch.  It appears that this is due
>> > to patches going through other trees.
>> >
>> > Sorry, I can't take this patch.
>>
>> It should go into your devel-testing branch as this must be applied on
>> top of my xip_zdata branch that you merged there.
>
> Thanks, it would've been good to have known that ahead of time.
>
> It's why the patch system has the KernelVersion: tag:
>
>  6. Kernel version.
>     On a separate line, add a tag "KernelVersion: " followed by the kernel
>     version that the patch was generated against. This should be formatted
>     as "KernelVersion: 2.6.0-rmk1"
>
> This is because that information is relevant for knowing where it should
> be applied, and to which branch.  Having it be something else means I
> have to guess, and that can result in the patch being discarded in this
> manner if I don't find where it's supposed to be applied.

That's why we have the standard Fixes tag, which was included
Fixes: 9520b1a1b5f7a348 ("ARM: head-common.S: speed up startup code")

It's trivial for the repo maintainer to know which branch the fix to apply to,
given the Fixes tag.
It's non-trivial to know the branch for the patch submitter, who is forced to
use a non-standard patch submission system.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
