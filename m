From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 14/22] ARM: omap1: use pci_ioremap_io() for omap_cf
Date: Fri, 16 Aug 2019 11:34:03 +0300
Message-ID: <20190816083403.GB1952@darkstar.musicnaut.iki.fi>
References: <20190808212234.2213262-1-arnd@arndb.de>
 <20190808212234.2213262-15-arnd@arndb.de>
 <20190813103605.GL52127@atomide.com>
 <CAK8P3a0E+QUn9wcP5Obv-FitWyXCFwcp+oPConeO2p-NV1rqsw@mail.gmail.com>
 <20190813181158.GA26798@darkstar.musicnaut.iki.fi>
 <CAK8P3a0LjKrc+7c5Ht9OL7LfYyLnG9=y7u+w24ujA1xAid_yCQ@mail.gmail.com>
 <20190814074918.GA52127@atomide.com>
 <CAK8P3a3k_HOGqzMGjtc+7NSaK0Bsa_vxxRFLzY8aP6ev4wa9iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3k_HOGqzMGjtc+7NSaK0Bsa_vxxRFLzY8aP6ev4wa9iA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Aug 14, 2019 at 12:36:40PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 14, 2019 at 9:49 AM Tony Lindgren <tony@atomide.com> wrote:
> > * Arnd Bergmann <arnd@arndb.de> [190813 19:34]:
> > > -#define OMAP1_IO_OFFSET                0x01000000      /* Virtual IO
> > > = 0xfefb0000 */
> > > +#define OMAP1_IO_OFFSET                0x00fb0000      /* Virtual IO
> > > = 0xff000000 */
> > >  #define OMAP1_IO_ADDRESS(pa)   IOMEM((pa) - OMAP1_IO_OFFSET)
> >
> > Oh OK yeah sounds like that's the issue.
> >
> > > There may be additional locations that hardcode the virtual address.
> >
> > Those should be in mach-omap1/io.c, and I recall innovator had some
> > hardcoded fpga address that should also be checked.
> 
> I see four boards with hardcoded I/O addresses, but they are all below
> the PCI I/O virtual address range, and are not affected by that change.
> 
> For the innovator FPGA access, this was ok, it uses the correct address
> in the OMAP1_IO_OFFSET range.

I tried testing this on OSK board. If I boot with earlyprintk disabled,
it boots OK and everything works (also CF card) with your playground
commit 5723b6686943.

However with earlyprintk it seems to hang as soon as kernel tries to print
something. So something goes wrong with early DEBUG_LL mapping code when
CONFIG_DEBUG_UART_VIRT=0xff000000 is used?

A.
