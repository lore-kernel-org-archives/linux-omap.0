From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM : OMAP : Add empty functions in header file
Date: Mon, 4 Jan 2010 09:25:34 -0600
Message-ID: <20100104152534.GA16974@lixom.net>
References: <1262603399-13036-1-git-send-email-x0082077@ti.com> <20100104123423.GA1439@gandalf> <016301ca8d3c$2d2b7f60$808918ac@apr.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <016301ca8d3c$2d2b7f60$808918ac-wD+IZp/g4/2mHdYHvhjUOg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maulik <x0082077-l0cyMroinI0@public.gmane.org>
Cc: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Tony Lindgren' <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, 'Felipe Balbi' <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, 'Greg Kroah-Hartman' <gregkh-l3A5Bk7waGM@public.gmane.org>, 'Sergei Shtylyov' <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, "'Gupta, Ajay Kumar'" <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 04, 2010 at 06:18:08PM +0530, Maulik wrote:
> 
> >>not omap-specific. How about USB: instead ?
> 
> [Maulik] Yes this can go through linux-usb.
> 
> > +#if defined(CONFIG_USB_NOP_XCEIV)
> >  /* sometimes transceivers are accessed only through e.g. ULPI */
> >  extern void usb_nop_xceiv_register(void);
> >  extern void usb_nop_xceiv_unregister(void);
> > +#else
> > +extern inline void usb_nop_xceiv_register()
> > +{
> > +}
> > +
> > +extern inline void usb_nop_xceiv_unregister()
> 
> >>I hope these are copy&paste error
> 
> [Maulik] Nope. When 'extern' is dropped I get the following error while
> compiling when CONFIG_USB_NOP_XCEIV is NOT defined. 
> 
> arch/arm/plat-omap/built-in.o: In function `usb_nop_xceiv_unregister':
> /share/maulik/felipe_musb/include/linux/usb/otg.h:123: multiple definition
> of `usb_nop_xceiv_unregister'
> arch/arm/mach-omap2/built-in.o:/share/maulik/felipe_musb/include/linux/usb/o
> tg.h:123: first defined here
> arch/arm/plat-omap/built-in.o: In function `usb_nop_xceiv_register':
> /share/maulik/felipe_musb/include/linux/usb/otg.h:119: multiple definition
> of `usb_nop_xceiv_register'
> arch/arm/mach-omap2/built-in.o:/share/maulik/felipe_musb/include/linux/usb/o
> tg.h:119: first defined here
> make: *** [vmlinux.o] Error 1
> 
> I referred some kernel code which uses extern inline. 
> 
> Any suggestions?

It needs to be static inline:

#ifdef CONFIG_USB_NO_XCEIV
/* sometimes transceivers are accessed only through e.g. ULPI */
extern void usb_nop_xceiv_register(void);
extern void usb_nop_xceiv_unregister(void);
#else
static inline void usb_nop_xceiv_register(void) { }
static inline void usb_nop_xceiv_unregister(void) { }
#endif

And you need to make sure that the actual body of the function in the
C file is encapsulated with #ifdef too, since the very point of having
it under a config option is to not include it if it's not selected
and needed.

-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
