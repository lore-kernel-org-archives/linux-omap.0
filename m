From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 14/22] ARM: omap1: use pci_ioremap_io() for omap_cf
Date: Tue, 13 Aug 2019 13:02:16 +0200
Message-ID: <CAK8P3a0E+QUn9wcP5Obv-FitWyXCFwcp+oPConeO2p-NV1rqsw@mail.gmail.com>
References: <20190808212234.2213262-1-arnd@arndb.de> <20190808212234.2213262-15-arnd@arndb.de>
 <20190813103605.GL52127@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813103605.GL52127@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 13, 2019 at 12:36 PM Tony Lindgren <tony@atomide.com> wrote:

> * Arnd Bergmann <arnd@arndb.de> [190808 21:34]:
> > The ISA I/O space handling in omap_cf is incompatible with
> > PCI drivers in a multiplatform kernel, and requires a custom
> > mach/io.h.
> >
> > Change the driver to use pci_ioremap_io() like PCI drivers do,
> > so the generic ioport access can work across platforms.
> >
> > To actually use that code, we have to select CONFIG_PCI
> > here.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Looks like this series boots for me on 5912osk up to this
> patch

Ok, that's something. Thanks for testing!

>, but this patch breaks booting somehow.
>
> Any ideas for fixes?

I can think of multiple possible issues:

- I force CONFIG_PCI to be enabled here in order to keep the
  asm/io.h logic unchanged. If PCI support in itself is an issue,
  then turning on CONFIG_PCI without the rest of this patch
  should also break.

- I see that osk is the one board that actually has a CF slot.
  If it crashes while trying to access a CF device, then I most
  likely screwed up the I/O port mapping itself, so it uses the
  wrong virtual and/or physical address for the access.

- I made on the assumption that only CF devices use inb/outb
  on any OMAP1 machine. If there is a driver that uses inb/outb
  instead of readb/writeb, it would have worked by chance before
  but stopped working now.

        Arnd
