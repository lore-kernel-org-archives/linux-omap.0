From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] ARM: OMAP: Fix board data to support device only, host
 only and OTG roles.
Date: Fri, 21 May 2010 13:13:29 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E535F3E@dbde02.ent.ti.com>
References: <1274360966-9974-1-git-send-email-x0082077@ti.com>
 <602675.31449.qm@web180309.mail.gq1.yahoo.com>
 <19F8576C6E063C45BE387C64729E7394044E535E9B@dbde02.ent.ti.com>
 <20100521065218.GG925@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100521065218.GG925-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Mankad, Maulik Ojas" <x0082077-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> On Fri, May 21, 2010 at 07:15:37AM +0200, ext Gupta, Ajay Kumar wrote=
:
> >Hi,
> >> > +#ifdef CONFIG_USB_MUSB_OTG
> >> > +=A0=A0=A0 .mode
> >> > =A0=A0=A0 =A0=A0=A0 =3D MUSB_OTG,
> >> > +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> >> > +=A0=A0=A0 .mode
> >> > =A0=A0=A0 =A0=A0=A0 =3D MUSB_HOST,
> >> > +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
> >> >  =A0=A0=A0 .mode
> >> > =A0=A0=A0 =A0=A0=A0 =3D MUSB_PERIPHERAL,
> >> > +#endif
> >>
> >> > =A0=A0=A0 =A0=A0=A0 =3D MUSB_PERIPHERAL,
> >> > +#endif
> >>
> >> By the way ... the #ifdeffery should indeed vanish from all board
> >> configs except the Davinci DM6446 EVM.
> >
> >If we are claiming to support:
> >	A. Same kernel would work on multiple boards
> >	B. Single kernel for one single board
> >
> >Then I think these #ifdefferys are required in all the board files.
> >
> >Let's consider the OMAP3EVM which supports all the three modes and
>=20
> you don't support "all three modes" you support OTG. If you want to
> build for peripheral only, that's your choice, but the board is wired=
 so
> that it has OTG support.

I meant OTG with ID pin based role.

>=20
> >If these #ifdefferys are not present and .mode is set to OTG.
> >Then if I choose to compile the Kernel only for peripheral mode
> >(Case-B above) then I would get below error from musb_core.c.
> >
> >"incompatible Kconfig role setting"
>=20
> there's a patch making that a warning instead of an #error if I'm not
> wrong.

If that patch ([1] below) is taken then we can avoid all these #ifdefs.

[1] http://marc.info/?l=3Dlinux-usb&m=3D127367875600618&w=3D2

But I see comment from David on above patch [1] to fix board data
Instead which means using #ifdefs again in board files...

With all these discussion it's best to accept the above [1] patch and
Avoid having ugly #ifdefs from board files.

-Ajay
>=20
> --
> balbi
>=20
> DefectiveByDesign.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
