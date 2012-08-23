From: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Subject: Re: linux 3.6-rc2, undefined reference to omap_musb_mailbox
Date: Thu, 23 Aug 2012 22:38:59 +0200 (CEST)
Message-ID: <alpine.DEB.2.01.1208232235200.15831@pmeerw.net>
References: <alpine.DEB.2.01.1208181741450.32497@pmeerw.net> <CAAe_U6+dFuX9fSX_epnPzX_3Zx3XBWAxE6kHDCTeuPwtn-ZQNw@mail.gmail.com> <20120820095421.GL17455@arwen.pp.htv.fi> <CAAe_U6+x+gxp2PMzuTyT=2Ox=HJtYw3DXGZLmaczi+q2oTM6TQ@mail.gmail.com>
 <20120820102641.GM17455@arwen.pp.htv.fi> <CAAe_U6JsPJ0b3HszOuCcu1LqEkXnC=LTQG00qwQzdB6pBnpryA@mail.gmail.com> <20120820113624.GP17455@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120820113624.GP17455-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, 20 Aug 2012, Felipe Balbi wrote:

> On Mon, Aug 20, 2012 at 04:37:28PM +0530, ABRAHAM, KISHON VIJAY wrote:
> > Hi,
> > 
> > On Mon, Aug 20, 2012 at 3:56 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > > On Mon, Aug 20, 2012 at 03:46:07PM +0530, ABRAHAM, KISHON VIJAY wrote:
> > >> Hi,
> > >>
> > >> On Mon, Aug 20, 2012 at 3:24 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > >> > On Mon, Aug 20, 2012 at 11:06:34AM +0530, ABRAHAM, KISHON VIJAY wrote:
> > >> >> Hi,
> > >> >>
> > >> >> On Sat, Aug 18, 2012 at 9:34 PM, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org> wrote:
> > >> >> >
> > >> >> > 3.6-rc2 fails to compile with
> > >> >> > CONFIG_USB_MUSB_HDRC=m
> > >> >> > CONFIG_USB_MUSB_OMAP2PLUS=m
> > >> >> >
> > >> >> >   LD      init/built-in.o
> > >> >> > drivers/built-in.o: In function `twl4030_usb_irq':
> > >> >> > /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:518: undefined reference to `omap_musb_mailbox'
> > >> >> > drivers/built-in.o: In function `twl4030_usb_phy_init':
> > >> >> > /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:540: undefined reference to `omap_musb_mailbox'
> > >> >>
> > >> >> Having TWL4030_USB as a module will get rid of this.
> > >> >> I'll see how this can be resolved when some modules are *built-in* and
> > >> >> some are made as *modules*.
> > >> >
> > >> > EXPORT_SYMBOL_GPL() should sort that out, right ?
> > >>
> > >> No :-( I already have EXPORT_SYMBOL_GPL() in omap2430.c.
> > >
> > > I see you're missing an "extern" on the function prototype (on the
> > > header). Not sure how modules.dep is generated, but maybe it needs the
> > > "extern" there. Can you check it out ?
> > 
> > That isn't helping either.
> 
> oh, ok... twl4030-usb is built-in... now that makes sense. Since
> twl4030-usb uses a symbol from omap2430, then it should depend on it,
> otherwise this will always happen.

so add USB_MUSB_OMAP2PLUS to the depends of TWL4030_USB in 
drivers/usb/otg/Kconfig?

thanks, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
