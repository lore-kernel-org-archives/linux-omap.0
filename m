From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/3] usb: musb: fix compilation error in musb_platform_init
Date: Fri, 23 Jan 2009 02:39:37 -0800
Message-ID: <200901230239.37353.david-b@pacbell.net>
References: <1231326846-22691-1-git-send-email-ajay.gupta@ti.com> <20090123101630.GN9233@scadufax.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090123101630.GN9233-isLFH4NzETkyzkgwUT+3V04zl0OMDgKpQQ4Iyu8u01E@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Cc: ext Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 23 January 2009, Felipe Balbi wrote:
> > --- a/drivers/usb/musb/Kconfig
> > +++ b/drivers/usb/musb/Kconfig
> > @@ -11,6 +11,7 @@ config USB_MUSB_HDRC
> > =A0=A0=A0=A0=A0=A0depends on (USB || USB_GADGET) && HAVE_CLK
> > =A0=A0=A0=A0=A0=A0depends on !SUPERH
> > =A0=A0=A0=A0=A0=A0select TWL4030_USB if MACH_OMAP_3430SDP
> > +=A0=A0=A0=A0=A0select USB_OTG_UTILS if ARCH_OMAP34XX
> > =A0=A0=A0=A0=A0=A0tristate 'Inventra Highspeed Dual Role Controller=
 (TI, ADI, ...)'
> > =A0=A0=A0=A0=A0=A0help
> > =A0=A0=A0=A0=A0=A0 =A0Say Y here if your system has a dual role hig=
h speed USB

NAK -- not needed given my more-complete "another musb buildfix",
which includes a non-conditional "select" for this.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
