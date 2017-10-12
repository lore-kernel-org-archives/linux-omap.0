From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ARM: head-common.S: Clear lr before jumping to start_kernel()
Date: Thu, 12 Oct 2017 14:34:39 +0200
Message-ID: <CAMuHMdUtOHAb=dfy1ufGyHMERk=frhSH-BTmWgeb9zUyZvHANw@mail.gmail.com>
References: <1507044184-27152-1-git-send-email-geert+renesas@glider.be>
 <nycvar.YSQ.7.76.1710031134140.5407@knanqh.ubzr> <CAMuHMdWJKQb5JY+diH=7dqNuypkPUqBeOEPSLOrfrnbfh2siRQ@mail.gmail.com>
 <CAMuHMdXpPfipmEdW0Dap6Pjwhz3QxLcrcbtU0RhCu721k-sBpA@mail.gmail.com>
 <CAMuHMdWH_pebSYAp04gmVceu3qqPczGaXS36R8CtzAYHo-CNog@mail.gmail.com>
 <20171010203324.GX4394@atomide.com> <20171012102341.GF23750@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171012102341.GF23750@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Chris Brandt <Chris.Brandt@renesas.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Russell, Nicolas,

On Thu, Oct 12, 2017 at 12:23 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Oct 10, 2017 at 01:33:25PM -0700, Tony Lindgren wrote:
>> * Geert Uytterhoeven <geert@linux-m68k.org> [171003 11:32]:
>> > On Tue, Oct 3, 2017 at 8:15 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > > On Tue, Oct 3, 2017 at 8:11 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > >> On Tue, Oct 3, 2017 at 5:37 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> > >>> On Tue, 3 Oct 2017, Geert Uytterhoeven wrote:
>> > >>> Please send it to RMK's patch system.
>> > >>
>> > >> Done (I hope so ;-)
>> > >
>> > > Failed. Retrying.
>> >
>> > Yiha ;-)
>> >
>> > http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8702/1
>>
>> This also fixes the spamming I started seeing with next-20171009:
>>
>> Tested-by: Tony Lindgren <tony@atomide.com>
>
> It's all nice and good that people are testing this patch, but I can't
> apply it to -rc1, nor my "misc" branch.  It appears that this is due
> to patches going through other trees.
>
> Sorry, I can't take this patch.
>
> (This is the falicy about any one particular tree having rights to
> exclusively own a sub-tree in the kernel...)

So through which tree did this end up in -next?

Apparently Nicolas committed 9520b1a1b5f7a348 ("ARM: head-common.S: speed up
startup code") himself, and then asked me to send the fix for that commit to
Russell anyway?
The commit above is actually in Russell's
git://git.armlinux.org.uk/~rmk/linux-arm.git#for-next.

Russell, you did merge it yourself into for-next in commit 476242482bdee72b
("Merge branch 'xip_zdata' of http://git.linaro.org/people/nicolas.pitre/linux
into devel-testing").

My patch applies fine against your for-next branch. So I fail to see why
you can't take this patch?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
