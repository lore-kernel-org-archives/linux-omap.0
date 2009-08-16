From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: MUSB regression in 2.6.31-rc6
Date: Sun, 16 Aug 2009 16:13:38 +0300
Message-ID: <20090816131337.GA7634@gandalf>
References: <20090815174352.c2883585.jhnikula@gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0305398E07@dbde02.ent.ti.com>
 <20090815180701.7710de51.jhnikula@gmail.com>
 <20090815174000.GA13164@nokia.com>
 <20090816104415.e12a5e46.jhnikula@gmail.com>
 <19F8576C6E063C45BE387C64729E739404322AA35B@dbde02.ent.ti.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404322AA35B-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Sun, Aug 16, 2009 at 06:37:40PM +0530, Gupta, Ajay Kumar wrote:
> 
> > > CONFIG_TWL4030_USB=y
> > > CONFIG_NOP_USB_XCEIV=y
> > >
> > > But anyway, I don't get Beagle booting with 2.6.31-rc6 if I disable any
> > > of them and IRCC another oops will follow if both are disabled.
> >
> > There's a patch from me adding back the twl4030_usb pdata to beagle
> > board-file and another one from Paul which changed the defconfig.
> >
> > You mean this one?
> 
> > http://marc.info/?l=linux-arm-kernel&m=125007992121335&w=2
> 
> > It didn't help. Only way to get the mainline kernel booting is to revert
> > e8e2ff462dd92693f29eb848f42d3eb720390d59 and activate both
> > CONFIG_TWL4030_USB and CONFIG_NOP_USB_XCEIV.
> 
> > By some reason CONFIG_OMAP_LL_DEBUG_UART3=y and CONFIG_DEBUG_LL=y
> > don't work in mainline so hard to trace what is make an oops.
> 
> > I attached my config if you want look at it.
> 
> You config has both CONFIG_TWL4030_USB and CONFIG_NOP_USB_XCEIV enabled.
> Can you try Felipe's patch but enable only CONFIG_TWL4030_USB.
> 
> http://marc.info/?l=linux-arm-kernel&m=125007992121335&w=2

Oh yeah, good point.

@Jarkko With the patch I sent you on top of mainline, did you make
omap3_beagle_defconfig again ?

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
