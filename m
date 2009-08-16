From: Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: MUSB regression in 2.6.31-rc6
Date: Sun, 16 Aug 2009 19:49:53 +0300
Message-ID: <20090816194953.8d96cdb7.jhnikula@gmail.com>
References: <20090815174352.c2883585.jhnikula@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0305398E07@dbde02.ent.ti.com>
	<20090815180701.7710de51.jhnikula@gmail.com>
	<20090815174000.GA13164@nokia.com>
	<20090816104415.e12a5e46.jhnikula@gmail.com>
	<19F8576C6E063C45BE387C64729E739404322AA35B@dbde02.ent.ti.com>
	<20090816131337.GA7634@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090816131337.GA7634@gandalf>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Cc: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, 16 Aug 2009 16:13:38 +0300
Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org> wrote:

> > > It didn't help. Only way to get the mainline kernel booting is to revert
> > > e8e2ff462dd92693f29eb848f42d3eb720390d59 and activate both
> > > CONFIG_TWL4030_USB and CONFIG_NOP_USB_XCEIV.
> > 
> > > By some reason CONFIG_OMAP_LL_DEBUG_UART3=y and CONFIG_DEBUG_LL=y
> > > don't work in mainline so hard to trace what is make an oops.
> > 
> > > I attached my config if you want look at it.
> > 
> > You config has both CONFIG_TWL4030_USB and CONFIG_NOP_USB_XCEIV enabled.
> > Can you try Felipe's patch but enable only CONFIG_TWL4030_USB.
> > 
> > http://marc.info/?l=linux-arm-kernel&m=125007992121335&w=2
> 
> Oh yeah, good point.
> 
As I told before (lines 4-6 in this mail), Felipe's patch to the
board-omap3beagle.c didn't help. Only way to make 2.6.31-rc6 booting
was to enable both of those config options + revert.

> @Jarkko With the patch I sent you on top of mainline, did you make
> omap3_beagle_defconfig again ?
> 
Yep. Actually I re-tested it now with make distclean first. Meaning
patch from this mail:

http://marc.info/?l=linux-usb&m=125041334606967&w=2

No sign of life.

Now reverting the e8e2ff462dd92693f29eb848f42d3eb720390d59

No sign of life.

Adding CONFIG_NOP_USB_XCEIV=y

Bingo!

Getting e8e2ff462dd92693f29eb848f42d3eb720390d59 back

Again, no sign of life.


-- 
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
