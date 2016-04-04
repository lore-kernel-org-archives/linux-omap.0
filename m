From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Mon, 4 Apr 2016 11:04:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1604041038510.1704-100000@iolanthe.rowland.org>
References: <xa1ty48tilai.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <xa1ty48tilai.fsf-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 4 Apr 2016, Michal Nazarewicz wrote:

> On Sat, Apr 02 2016, Alan Stern wrote:
> > On Sat, 2 Apr 2016, Michal Nazarewicz wrote:
> >> At the same time, mass storage should work fine if it=E2=80=99s bo=
und to
> >> multiple configurations.  Only one configuration can be active at =
any
> >> given time so interfaces on different configurations cannot interf=
ere
> >> with each other.
>=20
> > Yes, it _should_.  But it doesn't with the nokia legacy driver.
> > I don't know if this has any connection with configfs; it could be
> > a problem with the way f_mass_storage interacts with the composite
> > core.
>=20
> I believe the failure is related to the thread being started twice wh=
ere
> it indeed shouldn=E2=80=99t.

Yes, of course.  The questions we need to answer are: Why is the thread=
=20
being started twice, and how can we fix it?

> >> The problem we are having is that when mass storage is added to
> >> a configuration, fsg_bind is called and it starts the thread.
>=20
> > This is what I'm not sure about.  Which callbacks does the composit=
e
> > core invoke when a config is installed or uninstalled?
>=20
> usb_add_config is what is called to create a usb_configuration.  It
> initialises the structure and passes it to a callback bind function
> (most code removed for brevity):

Note: I did not ask what happens when a configuration is _created_; I
asked what happens when a configuration is _installed_ -- that is, when
the host sends a Set-Config request.

> int usb_add_config(struct usb_composite_dev *cdev,
> 		struct usb_configuration *config,
> 		int (*bind)(struct usb_configuration *))
> {
> 	usb_add_config_only(cdev, config);
> 	bind(config);
> 	/* set_alt(), or next bind(), sets up ep->claimed as needed */
> 	usb_ep_autoconfig_reset(cdev->gadget);
> 	return 0;
> }
>=20
> The bind callback calls usb_add_function to add usb_function to a new=
ly
> created usb_configuration (again, most code removed for brevity):
>=20
> int usb_add_function(struct usb_configuration *config,
> 		struct usb_function *function)
> {
> 	function->config =3D config;
> 	value =3D function->bind(config, function);
> 	return 0;
> }

So there is no way to add a single function to several configurations?

> For mass_storage, function->bind is fsg_bind (ditto):
>=20
> static struct usb_function *fsg_alloc(struct usb_function_instance *f=
i)
> {
> 	struct fsg_dev *fsg kzalloc(sizeof(*fsg), GFP_KERNEL);
> 	fsg->function.name	=3D FSG_DRIVER_DESC;
> 	fsg->function.bind	=3D fsg_bind;	/* !!! */
> 	fsg->function.unbind	=3D fsg_unbind;
> 	fsg->function.setup	=3D fsg_setup;
> 	fsg->function.set_alt	=3D fsg_set_alt;
> 	fsg->function.disable	=3D fsg_disable;
> 	fsg->function.free_func	=3D fsg_free;
> 	fsg->common               =3D common;
> 	return &fsg->function;
> }
>=20
> > Those callbacks should be where the thread is started and stopped.
>=20
> Starting thread in that callback is what is happening right now and
> because single usb_function_instance can have multiple usb_function
> structures each binding to separate usb_configuration, this causes
> problem where the thread is started multiple times.

It sounds like there are two problems then.  The first problem is that
struct usb_function has a ->disable() callback but no ->enable() =20
callback.  The set_config() routine in composite.c should invoke the
->enable() callback for each function in the config when the config is
installed.

The second problem is that f_mass_storage should start the thread in=20
the enable callback and stop the thread in the disable callback, rather=
=20
than in fsg_bind() and fsg_free_inst() (or wherever).

> This is also why the thread is not stopped in fsg_unbind but only onc=
e
> fsg_common structure is released.

This design is a holdover from the days before the composite core
existed and g_file_storage was a standalone gadget driver.  It could
stand to be updated.

> Conceptually, the thread should be started when fsg_common structure =
is
> created (which is at the same time when usb_function_instance is
> created) and stopped when fsg_common is released.
>=20
> At this point, I=E2=80=99m not entirely sure if there is a reason why=
 this isn=E2=80=99t
> the case.  The only reason I can think of is that starting the thread
> right away may be considered wasteful since the thread won=E2=80=99t =
have
> anything to do until the function is bound to a configuration.  In th=
e
> current code, there may also be issues where perhaps the thread would
> not get stopped if fsg_bind has never been called.

Even after the function is bound to a configuration, the thread won't=20
have anything to do until the configuration is installed by the host.

> Because of all that, I think the best course of action is to just che=
ck
> whether the thread is running and conditionally start it in fsg_bind,
> i.e.:

> This should get rid of all the confusion and just do the right thing.

Except that you'll have a bunch of threads hanging around with nothing=20
to do.  They shouldn't be created until it is known that they will be=20
needed, and they should be destroyed when it is known that they won't=20
have any more work to do.

That's my opinion; you may disagree.

Alan Stern


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
