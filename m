From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Sat, 2 Apr 2016 10:55:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1604021031030.19366-100000@netrider.rowland.org>
References: <xa1tbn5tynyp.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <xa1tbn5tynyp.fsf-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sat, 2 Apr 2016, Michal Nazarewicz wrote:

> > I'm not so sure about this.  Earlier I was undecided about what to =
do
> > if there are multiple mass-storage interfaces in the same config, b=
ut
> > now I realize that one thread won't work in that situation.  The
> > difficulty is exception handling.  If an error occurs in one of the
> > interfaces, it shouldn't affect the others -- but with only one thr=
ead
> > you can't make that work.
> >
> > I don't know the details of how the composite core works (I don't e=
ven
> > remember the difference between a usb_function and
> > a usb_function_instance).
>=20
> configfs made things quite confusing, yes.  IIRC, usb_function roughl=
y
> corresponds to an interface while usb_function_instance corresponds t=
o
> a module/function driver, except you can easily create multiple
> instances.

That sounds right.  I vaguely remember when I did look at this stuff
years ago, the names were backward -- usb_function refers to an
instance while usb_function_instance refers to a driver (which
obviously doesn't have instances).

> > Suppose there are several interfaces in one config, each bound to t=
he
> > mass-storage driver.  Then won't the driver's bind routine get call=
ed
> > several times whenever the config is installed?
> >
> > If so, then each of those calls should create a new thread.  There'=
s no
> > need to check if the thread has already been started.
> >
> > If not, then there's no way to use f_mass_storage on multiple
> > interfaces in a single config.  The driver should refuse to run on
> > more than one interface at a time.
>=20
> Right, but that=E2=80=99s not what is happening.  We have a situation=
 where
> single mass storage instance is bound to two interfaces on two differ=
ent
> configs:
>=20
> 	mkdir functions/mass_storage.0
> 	echo $file > functions/mass_storage.0/lun.0/file
> 	ln -s functions/mass_storage.0 configs/c.1
> 	ln -s functions/mass_storage.0 configs/c.2
>=20
> configfs doesn=E2=80=99t even allows to express situation where a sin=
gle
> instance of a function is bound to multiple interfaces in a single
> configuration (IIRC).

That doesn't matter for our purposes now.

> At the same time, mass storage should work fine if it=E2=80=99s bound=
 to
> multiple configurations.  Only one configuration can be active at any
> given time so interfaces on different configurations cannot interfere
> with each other.

Yes, it _should_.  But it doesn't with the nokia legacy driver.  I=20
don't know if this has any connection with configfs; it could be a=20
problem with the way f_mass_storage interacts with the composite core.

> The problem we are having is that when mass storage is added to
> a configuration, fsg_bind is called and it starts the thread.

This is what I'm not sure about.  Which callbacks does the composite
core invoke when a config is installed or uninstalled?  Those
callbacks should be where the thread is started and stopped.

> If someone wanted to have two mass storage interfaces on a single
> configuration they would have to create two mass storage instances an=
d
> each instance has it=E2=80=99s own fsg_common struct (see fsg_alloc_i=
nst
> function).
>=20
> PS. It seems that legacy/multi is broken because it calls
>     fsg_common_run_thread twice.

Perhaps because f_mass_storage calls fsg_common_run_thread from the
wrong place.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
