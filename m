From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Mon, 4 Apr 2016 15:37:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1604041458310.1704-100000@iolanthe.rowland.org>
References: <xa1ttwjhi6fo.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <xa1ttwjhi6fo.fsf-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 4 Apr 2016, Michal Nazarewicz wrote:

> On Mon, Apr 04 2016, Alan Stern wrote:
> > So there is no way to add a single function to several configuratio=
ns?
>=20
> There is.  f_mass_storage (and any other usb_function_instance) simpl=
y
> has to have multiple usb_function structures.
>=20
> > It sounds like there are two problems then.  The first problem is t=
hat
> > struct usb_function has a ->disable() callback but no ->enable()
> > callback.  The set_config() routine in composite.c should invoke th=
e
> > ->enable() callback for each function in the config when the config=
 is
> > installed.
>=20
> Well, there is set_alt which is called when configuration is chosen (=
as
> well as when interface=E2=80=99s alternative is chosen).  It=E2=80=99=
s not ideal but if
> we had to we could work with that.

I suppose so.

> > Except that you'll have a bunch of threads hanging around with noth=
ing=20
> > to do.  They shouldn't be created until it is known that they will =
be=20
> > needed, and they should be destroyed when it is known that they won=
't=20
> > have any more work to do.
>=20
> I=E2=80=99m not sure how big of a deal that is.  The flip side is tha=
t equating
> thread=E2=80=99s lifetime to the lifetime of the function instance is
> conceptually easier.  Even with thread started in fsg_bind this is st=
ill
> less complex than having the thread pop in and out of existence.

True.  (Provided one understands that a function instance corresponds=20
to the usb_function structure, not the usb_function_instance=20
structure.)

> Furthermore, having it start and stop may lead to unnecessary delays
> when host switches configurations.  This may be an esoteric problem
> though.
>=20
> I=E2=80=99m not married to any either idea, but right now my patch is=
 a better
> course of action because it brings a quick fix to the bug.  More
> dramatic changes to thread=E2=80=99s lifetime should be handled by se=
parate
> patches.

Okay.  However, I noticed your patch does:

> +	if (!common->thread_task) {
> +		common->state =3D FSG_STATE_IDLE;
> +		common->thread_task =3D
> +			kthread_create(fsg_main_thread, common,

in fsg_bind().  How could thread_task ever be non-NULL at this point? =20
Wouldn't that mean the usb_function structure was registered twice?

Which brings us back to the nokia driver.  Apparently it _does_ manage
to create the thread twice.  How can this happen?  The function that
nokia_bind_config() registers is created dynamically:

	f_msg =3D usb_get_function(fi_msg);

which goes through fsg_alloc().

Aha, and now I see the problem.  fsg_alloc() shares opts->common among
all the fsg structures it creates.  This means all the function
instances will share common->thread_task, because they all share
common.  The same goes for common->state and a bunch of other fields.

It looks like a lot of stuff has to move out of fsg->common and into=20
fsg.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
