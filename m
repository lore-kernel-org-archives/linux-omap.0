From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Thu, 14 May 2015 10:54:55 -0500
Message-ID: <20150514155455.GE24269@saruman.tx.rr.com>
References: <20150514020634.GB20006@saruman.tx.rr.com>
 <Pine.LNX.4.44L0.1505141145530.1107-100000@iolanthe.rowland.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1505141145530.1107-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2015 at 11:51:10AM -0400, Alan Stern wrote:
> On Wed, 13 May 2015, Felipe Balbi wrote:
>=20
> > This brings up a question, actually. What to do with devices which were
> > already runtime suspended when user initiated suspend-to-ram ? Do we
> > leave wakeups enabled, or do we revisit device_may_wakeup() and
> > conditionally runtime_resume the device, disable wakeup, and let its
> > ->suspend() callback be called ?
>=20
> In theory, the subsystem/device drivers already have code do this. =20
> They're supposed to, anyway.  The USB host stack does it in
> drivers/usb/core/driver.c:choose_wakeup().

that answers the question, specifically, this comment and piece of code
do:

1395 static void choose_wakeup(struct usb_device *udev, pm_message_t msg)
1396 {

[...]

1409         /* Enable remote wakeup if it is allowed, even if no interface=
 drivers
1410          * actually want it.
1411          */
1412         w =3D device_may_wakeup(&udev->dev);
1413=20
1414         /* If the device is autosuspended with the wrong wakeup settin=
g,
1415          * autoresume now so the setting can be changed.
1416          */
1417         if (udev->state =3D=3D USB_STATE_SUSPENDED && w !=3D udev->do_=
remote_wakeup)
1418                 pm_runtime_resume(&udev->dev);
1419         udev->do_remote_wakeup =3D w;
1420 }

so that's something that also needs to be taken into consideration.

Thanks

--=20
balbi

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVVMVPAAoJEIaOsuA1yqREkVMP/3MlisffsDInBEqJDJ0HqEBC
FvVtT1ffp39F5ogbrk5oBdGr0FyOZqqNNjLU6rd+W3nVYWWxD/FXdtSJT6A/XNAe
i8QZjy1t1DrDYKluyWylRdctR/eXyWtFFV/RE5S4Mz+Fd9b6NmdQY8C66y3489/N
lKANIt0zlOSQEV1V6BZ7Qto4W6f4OX+fsoDlpovpXvILZskJBsxe14YtQvH5aSVY
Ta/1WDz+J0QX2eyTpm2mG6OrlKMvJlNZEwgzWINl/FQCxWdjdFYjOon0HzsVgUvZ
5i+v4VF6HAEmhdKZeTkbcw5rQZHE83GFtWr9xpttCGssj9Nh3YnrYwOXyrWjONcN
Ih1exf9ScTLJDCKaHQsyjkTn807hAsJHwIbpr0rCC4OuMdJoXNGkFwdwUFg8EVLr
Ybwol1maOWFOOzMhnB99qiVT/St2ip4imgJZPe7wWCXe3Wj85ORx9j2jlPACeZSr
o1eK6sFrydBJIBOT/ZSjELRc5ABfFCnbRt2rg+xYE/hQPyHp3t7iiDelqFoMCzye
yhuSJptZIa0dwPuWaZVVE9ErBwFXgKhdPNlkv/WlNR7gqnYKjrpvaPrXBcjEKLZc
QIp908id3ij4yQlM5wk8LkbjfPUQFGV6GJOXUI3gbvuafaZtcWmCZAUAyrWTqgr8
Brb0Bsn7QeyVQm4C4/9B
=Dtnx
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
