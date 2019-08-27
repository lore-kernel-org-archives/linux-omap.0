From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 14/22] ARM: omap1: use pci_ioremap_io() for omap_cf
Date: Tue, 27 Aug 2019 18:33:01 +0200
Message-ID: <CAK8P3a3jqNxoihQ+UFvOZMg=AcF2yzHXs5ay6X1TZX8L3zQ3rg@mail.gmail.com>
References: <20190808212234.2213262-1-arnd@arndb.de> <20190808212234.2213262-15-arnd@arndb.de>
 <20190813103605.GL52127@atomide.com> <CAK8P3a0E+QUn9wcP5Obv-FitWyXCFwcp+oPConeO2p-NV1rqsw@mail.gmail.com>
 <20190813181158.GA26798@darkstar.musicnaut.iki.fi> <CAK8P3a0LjKrc+7c5Ht9OL7LfYyLnG9=y7u+w24ujA1xAid_yCQ@mail.gmail.com>
 <20190814074918.GA52127@atomide.com> <CAK8P3a3k_HOGqzMGjtc+7NSaK0Bsa_vxxRFLzY8aP6ev4wa9iA@mail.gmail.com>
 <20190816083403.GB1952@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816083403.GB1952@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 16, 2019 at 10:34 AM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> On Wed, Aug 14, 2019 at 12:36:40PM +0200, Arnd Bergmann wrote:
> > On Wed, Aug 14, 2019 at 9:49 AM Tony Lindgren <tony@atomide.com> wrote:
> > > * Arnd Bergmann <arnd@arndb.de> [190813 19:34]:
> > > > -#define OMAP1_IO_OFFSET                0x01000000      /* Virtual IO
> > > > = 0xfefb0000 */
> > > > +#define OMAP1_IO_OFFSET                0x00fb0000      /* Virtual IO
> > > > = 0xff000000 */
> > > >  #define OMAP1_IO_ADDRESS(pa)   IOMEM((pa) - OMAP1_IO_OFFSET)
> > >
> > > Oh OK yeah sounds like that's the issue.
> > >
> > > > There may be additional locations that hardcode the virtual address.
> > >
> > > Those should be in mach-omap1/io.c, and I recall innovator had some
> > > hardcoded fpga address that should also be checked.
> >
> > I see four boards with hardcoded I/O addresses, but they are all below
> > the PCI I/O virtual address range, and are not affected by that change.
> >
> > For the innovator FPGA access, this was ok, it uses the correct address
> > in the OMAP1_IO_OFFSET range.
>
> I tried testing this on OSK board. If I boot with earlyprintk disabled,
> it boots OK and everything works (also CF card) with your playground
> commit 5723b6686943.
>
> However with earlyprintk it seems to hang as soon as kernel tries to print
> something. So something goes wrong with early DEBUG_LL mapping code when
> CONFIG_DEBUG_UART_VIRT=0xff000000 is used?

I just redid the calculation and came out with the same address, so I
don't think I put the wrong one there. The address also does not
conflict with the PCI mapping, and the address is the same one that
is installed later, so that should also be fine.

Are you sure you used the correct address in the .config file? If you
ran 'make oldconfig', the virtual address would not be changed here
as I just modify the default for a fresh 'make omap1_defconfig'
run or similar.

        Arnd
