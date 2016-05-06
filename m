From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Fri, 6 May 2016 14:32:35 +0200
Message-ID: <20160506123235.GN12528@pali>
References: <20160115224839.GA19432@atomide.com>
 <569A1E32.1020502@gmail.com>
 <57081105.2050206@gmail.com>
 <571486A1.2060006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <571486A1.2060006-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Monday 18 April 2016 10:02:57 Ivaylo Dimitrov wrote:
>=20
>=20
> On  8.04.2016 23:13, Ivaylo Dimitrov wrote:
> >Hi,
> >
> >On 16.01.2016 12:40, Ivaylo Dimitrov wrote:
> >>Hi,
> >>
> >>On 16.01.2016 00:48, Tony Lindgren wrote:
> >>>Hi all,
> >>>
> >>>Looks like there's some issue with the USB gadgets and configfs.
> >>>
> ...
> >
> >(copied from "Re: [PATCH] usb: f_mass_storage: test whether thread i=
s
> >running before starting another" thread)
> >
> >Yet another problem with USB gadget, this time with f_acm - if there=
 is
> >an open /dev/ttyGSn device, it is impossible to reboot/power down th=
e
> >device.
> >
> >My investigation shown that there is a process(pnatd) that opens
> >/dev/ttyGSn devices, so gserial_free_port() hangs on
> >wait_event(port->close_wait, gs_closed(port)); if I do "cd
> >/sys/bus/platform/drivers/musb-hdrc && echo musb-hdrc.0.auto > unbin=
d".
> >
> >Unfortunately I don't have serial debug port connector on my N900, s=
o I
> >can't capture logs after the reboot command, however, I suspect it h=
angs
> >on the same place as with unbind.
> >
> >That looks weird, as one would expect that close() is called when th=
e
> >kernel kills user processes on reboot/powerdown.
> >
> >Ivo
>=20
>=20
> Anyone?

PING?

--=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
