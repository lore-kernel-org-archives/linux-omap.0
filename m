From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Mon, 18 Apr 2016 10:55:43 +0300
Message-ID: <87oa97gxkw.fsf@intel.com>
References: <20160115224839.GA19432@atomide.com> <569A1E32.1020502@gmail.com> <57081105.2050206@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57081105.2050206-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> Hi,
>
> On 16.01.2016 12:40, Ivaylo Dimitrov wrote:
>> Hi,
>>
>> On 16.01.2016 00:48, Tony Lindgren wrote:
>>> Hi all,
>>>
>>> Looks like there's some issue with the USB gadgets and configfs.
>>>
>>> I'm seeing rmmod of the UDC driver cause a warning and then reboot
>>> hangs the system. This happens at least with v4.4, and I've reproduced
>>> it with dwc3 and musb so it seems to be generic.
>>>
>>
>> Having configfs is not needed, disabling usb gadgets (#
>> CONFIG_USB_MUSB_GADGET is not set) seems to solved at least poweroff
>> hang issue on N900. Also, g_nokia is not a module in the config I use,
>> so I guess the problem is not related whether gadgets are modular or
>> not. Unfortunately I was not able to test reboot, as rootfs became
>> corrupted after the first poweroff :( . So it looks like my theory that
>> onenand corruption on N900 is because poweroff/reboot hangs is wrong.
>
> (copied from "Re: [PATCH] usb: f_mass_storage: test whether thread is=20
> running before starting another" thread)
>
> Yet another problem with USB gadget, this time with f_acm - if there is=20
> an open /dev/ttyGSn device, it is impossible to reboot/power down the=20
> device.
>
> My investigation shown that there is a process(pnatd) that opens=20
> /dev/ttyGSn devices, so gserial_free_port() hangs on=20
> wait_event(port->close_wait, gs_closed(port)); if I do "cd=20
> /sys/bus/platform/drivers/musb-hdrc && echo musb-hdrc.0.auto > unbind".
>
> Unfortunately I don't have serial debug port connector on my N900, so I=20
> can't capture logs after the reboot command, however, I suspect it hangs=
=20
> on the same place as with unbind.
>
> That looks weird, as one would expect that close() is called when the=20
> kernel kills user processes on reboot/powerdown.

right, care to enable lockup detection and see if you can get more info
out of it ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXFJL/AAoJEIaOsuA1yqREzJQQAJvLhYXXS79RL/BQBnmmDmC7
84iuMjDxeT2MDphKo5cPWLATgJWLsLIHIZqYzl3T0ER68q644SSsJ423ccFZX2nc
APuRJSU8swSZorddT6S+hquDcey+7gmjU5bPVPAGTNP778btVMdBjr9dsJ7/SJv4
5MgaYRNw9fbvcanmWOI3OoW9d5pnKNKpHN1sGdSXG4xPH/mZAcuGz4b2CGcwggkp
vOqMnJHDRQmAAmY91D5S+HY2J0p0pd2YvHZAciZmRmKd/r0b4KyJqeEx4S0UfjDP
QHpl+d7xScUEp2OzXKcgRjk49CbV9gtf55UCcSWfsjzt2gj6BzMsiF+3kvXsHrP8
Y+s8WyQjT0nBipEf3uxEAlBFZzaymH1zoJxr3bySyz4G8zSjiBWPhgfh7eon2UrR
yoaLO0jE3iwDdJJr1coSwzYt+l3kqh2HdYoB4mvhiiqhR3rl/KnXAFDdUZf78eie
GS/9iebW3eGqSCct8lJ+9wnoeq5hvTwyQag0h1xImNC/9a2R6H16UbZ/vX1egLs6
r1BIloI6oDPVy20L1+g5i2yWBBu1l2lXf5xhC6b/bxNdfLO2wJLboKATtuvNjMBl
0kx9NvE+LGzirjMzFLmLK71jABqWojDj9hVTNzOm4Xi9JYk04gXrHSBoq4DHiJoA
mG9gYbU8EN086eFhfPnT
=rRdP
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
