From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Mon, 04 Apr 2016 20:18:19 +0200
Message-ID: <xa1ttwjhi6fo.fsf@mina86.com>
References: <Pine.LNX.4.44L0.1604041038510.1704-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1604041038510.1704-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 04 2016, Alan Stern wrote:
> So there is no way to add a single function to several configurations=
?

There is.  f_mass_storage (and any other usb_function_instance) simply
has to have multiple usb_function structures.

> It sounds like there are two problems then.  The first problem is tha=
t
> struct usb_function has a ->disable() callback but no ->enable()
> callback.  The set_config() routine in composite.c should invoke the
> ->enable() callback for each function in the config when the config i=
s
> installed.

Well, there is set_alt which is called when configuration is chosen (as
well as when interface=E2=80=99s alternative is chosen).  It=E2=80=99s =
not ideal but if
we had to we could work with that.

> The second problem is that f_mass_storage should start the thread in
> the enable callback and stop the thread in the disable callback,
> rather than in fsg_bind() and fsg_free_inst() (or wherever).

[=E2=80=A6]

> Even after the function is bound to a configuration, the thread won't=
=20
> have anything to do until the configuration is installed by the host.

[=E2=80=A6]

> Except that you'll have a bunch of threads hanging around with nothin=
g=20
> to do.  They shouldn't be created until it is known that they will be=
=20
> needed, and they should be destroyed when it is known that they won't=
=20
> have any more work to do.

I=E2=80=99m not sure how big of a deal that is.  The flip side is that =
equating
thread=E2=80=99s lifetime to the lifetime of the function instance is
conceptually easier.  Even with thread started in fsg_bind this is stil=
l
less complex than having the thread pop in and out of existence.

=46urthermore, having it start and stop may lead to unnecessary delays
when host switches configurations.  This may be an esoteric problem
though.

I=E2=80=99m not married to any either idea, but right now my patch is a=
 better
course of action because it brings a quick fix to the bug.  More
dramatic changes to thread=E2=80=99s lifetime should be handled by sepa=
rate
patches.

--=20
Best regards
=E3=83=9F=E3=83=8F=E3=82=A6 =E2=80=9C=F0=9D=93=B6=F0=9D=93=B2=F0=9D=93=B7=
=F0=9D=93=AA86=E2=80=9D =E3=83=8A=E3=82=B6=E3=83=AC=E3=83=B4=E3=82=A4=E3=
=83=84
=C2=ABIf at first you don=E2=80=99t succeed, give up skydiving=C2=BB
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
