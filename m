From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: head-common.S: Clear lr before jumping to
 start_kernel()
Date: Thu, 12 Oct 2017 11:23:41 +0100
Message-ID: <20171012102341.GF23750@n2100.armlinux.org.uk>
References: <1507044184-27152-1-git-send-email-geert+renesas@glider.be>
 <nycvar.YSQ.7.76.1710031134140.5407@knanqh.ubzr>
 <CAMuHMdWJKQb5JY+diH=7dqNuypkPUqBeOEPSLOrfrnbfh2siRQ@mail.gmail.com>
 <CAMuHMdXpPfipmEdW0Dap6Pjwhz3QxLcrcbtU0RhCu721k-sBpA@mail.gmail.com>
 <CAMuHMdWH_pebSYAp04gmVceu3qqPczGaXS36R8CtzAYHo-CNog@mail.gmail.com>
 <20171010203324.GX4394@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171010203324.GX4394@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Chris Brandt <Chris.Brandt@renesas.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 10, 2017 at 01:33:25PM -0700, Tony Lindgren wrote:
> * Geert Uytterhoeven <geert@linux-m68k.org> [171003 11:32]:
> > On Tue, Oct 3, 2017 at 8:15 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Oct 3, 2017 at 8:11 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >> On Tue, Oct 3, 2017 at 5:37 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > >>> On Tue, 3 Oct 2017, Geert Uytterhoeven wrote:
> > >>> Please send it to RMK's patch system.
> > >>
> > >> Done (I hope so ;-)
> > >
> > > Failed. Retrying.
> > 
> > Yiha ;-)
> > 
> > http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8702/1
> 
> This also fixes the spamming I started seeing with next-20171009:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

It's all nice and good that people are testing this patch, but I can't
apply it to -rc1, nor my "misc" branch.  It appears that this is due
to patches going through other trees.

Sorry, I can't take this patch.

(This is the falicy about any one particular tree having rights to
exclusively own a sub-tree in the kernel...)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
