From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: head-common.S: Clear lr before jumping to
 start_kernel()
Date: Sat, 14 Oct 2017 15:14:05 +0100
Message-ID: <20171014141405.GG23750@n2100.armlinux.org.uk>
References: <1507044184-27152-1-git-send-email-geert+renesas@glider.be>
 <nycvar.YSQ.7.76.1710031134140.5407@knanqh.ubzr>
 <CAMuHMdWJKQb5JY+diH=7dqNuypkPUqBeOEPSLOrfrnbfh2siRQ@mail.gmail.com>
 <CAMuHMdXpPfipmEdW0Dap6Pjwhz3QxLcrcbtU0RhCu721k-sBpA@mail.gmail.com>
 <CAMuHMdWH_pebSYAp04gmVceu3qqPczGaXS36R8CtzAYHo-CNog@mail.gmail.com>
 <20171010203324.GX4394@atomide.com>
 <20171012102341.GF23750@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710121123530.1718@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1710121123530.1718@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Tony Lindgren <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Chris Brandt <Chris.Brandt@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 12, 2017 at 11:25:50AM -0400, Nicolas Pitre wrote:
> On Thu, 12 Oct 2017, Russell King - ARM Linux wrote:
> 
> > On Tue, Oct 10, 2017 at 01:33:25PM -0700, Tony Lindgren wrote:
> > > * Geert Uytterhoeven <geert@linux-m68k.org> [171003 11:32]:
> > > > On Tue, Oct 3, 2017 at 8:15 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Tue, Oct 3, 2017 at 8:11 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > >> On Tue, Oct 3, 2017 at 5:37 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > > > >>> On Tue, 3 Oct 2017, Geert Uytterhoeven wrote:
> > > > >>> Please send it to RMK's patch system.
> > > > >>
> > > > >> Done (I hope so ;-)
> > > > >
> > > > > Failed. Retrying.
> > > > 
> > > > Yiha ;-)
> > > > 
> > > > http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8702/1
> > > 
> > > This also fixes the spamming I started seeing with next-20171009:
> > > 
> > > Tested-by: Tony Lindgren <tony@atomide.com>
> > 
> > It's all nice and good that people are testing this patch, but I can't
> > apply it to -rc1, nor my "misc" branch.  It appears that this is due
> > to patches going through other trees.
> > 
> > Sorry, I can't take this patch.
> 
> It should go into your devel-testing branch as this must be applied on 
> top of my xip_zdata branch that you merged there.

Thanks, it would've been good to have known that ahead of time.

It's why the patch system has the KernelVersion: tag:

 6. Kernel version.
    On a separate line, add a tag "KernelVersion: " followed by the kernel
    version that the patch was generated against. This should be formatted
    as "KernelVersion: 2.6.0-rmk1"

This is because that information is relevant for knowing where it should
be applied, and to which branch.  Having it be something else means I
have to guess, and that can result in the patch being discarded in this
manner if I don't find where it's supposed to be applied.

Yes, I know it's a pain to have to supply this information, but giving
accurate information there makes things a lot easier and quicker when
applying patches, rather than playing a game of "guess where it needs
to be applied, nope, doesn't apply there, try somewhere else."

Various people in the kernel community have different solutions to this.
For example, on netdev, it is preferred to state whether you want your
patch to be applied to "net" or "net-next" by adding that into the
"[PATCH ...]" tag in the subject line.  It's really about streamlining
the patch submission and application process.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
