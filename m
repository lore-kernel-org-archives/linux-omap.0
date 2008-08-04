From: Daniel Stone <daniel.stone-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: USB driver issue
Date: Mon, 4 Aug 2008 19:12:20 +0300
Message-ID: <20080804161220.GD25065@intune.research.nokia.com>
References: <20080801063024.GE8634@kroah.com> <604137.34126.qm@web53204.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1WN/MJ7JJGqVzwIW"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <604137.34126.qm-Ll//HCKdAyWB9c0Qi4KiSl5cfvJIxWXgQQ4Iyu8u01E@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Emanoil Kotsev <deloptes-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org" <linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--1WN/MJ7JJGqVzwIW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 02, 2008 at 01:51:59AM -0700, ext Emanoil Kotsev wrote:
> > > Kernel developers should fix bugs in minor kernel
> > versions as they are
> > > meant for this purpous and do major changes only in
> > major version. A
> > > bunch of bugfixes I see (not only usb related) are
> > just not in place
> > > in minor kernel versions. That's my opinion at
> > first place.
> >=20
> > Minor (2.6.x.y) releases happen with only bugfixes every
> > few weeks.
> > Perhaps you should use them.  But realize that they are
> > only supported
> > for about 3-4 months, then you are expected to move to the
> > next major
> > release.
>=20
> This is the issue 3-4 months are enough for ATI or NVidia to bring a new =
driver
> Either change the policy or find a solution!

The policy is 'we do not support proprietary drivers' (both in X.Org and
in the kernel).  The solution is for vendors not to produce proprietary
drivers.  Intel, AMD/ATI, and others have already got the message and
already work with us to provide high-quality open source drivers.

If this bothers you, please tell NVIDIA that you're a customer who's
purchased their product, and that you wish to have acceptable (i.e.,
open source) Linux kernel + X.Org support.  That's the only way it will
ever get fixed, full stop.  (Well, either that or through Nouveau.)

> > Given the rate of change in the Linux kernel (faster than
> > any other
> > software project known to man), how do you really expect us
> > to do that?
> > It's pretty impossible.
>=20
> The question is - what are you doing this for? What's your goal

I think the primary motivation for most people could be summed up by the
title of Linus Torvalds's autobiography: 'Just for Fun'.  As soon as
it's no longer fun (hint: attempting to force people to do things they
don't think are good ideas usually drains some amount of the fun),
people will begin to walk away.

> I'm going to give up linux soon if it goes this way

I've never met you before, so you'll have to understand if myself and
most others on this list aren't dropping everything to ensure you don't
carry out this threat.

> > No, we expect that you would use hardware that works with,
> > and
> > contributes toward the advancement of Linux.  Not hardware
> > that requires
> > closed source modules.
>=20
> I spent a lot of time reading about hardware and linu support when IO bou=
ght my dell notebook, that's why I choose one with intel video vard inside =
=2E.. and what happened - I don't have 3D when using dual screen - GREAT!

Upgrade to Xorg 7.3 or above.  Anything with xorg-server 1.3.0 or above
and xf86-video-intel 2.x.x supports dual screen with 3D just fine, via
XRandR 1.2.  As an added bonus, you get to drop the static configuration
in xorg.conf, and you can have hotplug monitor support, on-the-fly
reconfiguration, etc.  See http://www.intellinuxgraphics.org for more
details.  The Radeon driver also supports this in 6.8.x and above.

> > Again, if you are stuck with such hardware, there is
> > _nothing_ that I or
> > any other kernel developer can do about it.  It is
> > physically
> > impossible.
>=20
> The problem is, that ATI, NVidia and a lot of other hardware producers ar=
e willing to support linux, but can not afford it to bring up drivers for t=
he latest stable kernel in the terms you consider it as stable - and this w=
as my original point.

AMD/ATI already support it in this model, except for fglrx, which is not
actually for home consumers and game players at all, but for people like
Pixar with huge renderfarms, or heavy CAD users.  Hence the extreme
focus on absolute GL spec compliance, et al.  NVIDIA have chosen not to
support that model.  Their loss.

> Then fix the hfs modem for my dell notebook  (oh ... it is closed driver =
by connexant - but they are willing to help me and .... oh, they suggest I =
use the 2.6.24 kernel)

That's not much help then, is it? What happens when NVIDIA have a bug
that forces you to downgrade to 2.6.22, which hfs doesn't support in
that version?

Incidentally, Ubuntu are now having to ship four NVIDIA drivers, because
they keep deprecating support, and the old drivers don't always keep up
with new kernel versions (even stable ones: they receive literally zero
updates once your card is deemed too old).  I assume this is the kind of
'help' and 'support' you keep talking about.

> > We change because the world changes.  In order to survive,
> > we also need
> > to change.
> >=20
> > If we stop, we die.
>=20
> This is true, but out of scope - see above. There is no sence to install =
a new kernel that does not support my hardware and also is outaged when I h=
ave the drivers for this kernel version.

No-one can do anything about third-party drivers.  If the driver for
your NVIDIA chipset, which is written and shipped by NVIDIA, does not
support the newest kernel version, then complain to NVIDIA, not the
people working on the kernel.  As everyone in this discussion has
repeatedly said, there's nothing anyone can do about third-party
drivers.

Incidentally, a senior NVIDIA manager said a while ago that the reason
their driver isn't open source is because everyone who has any idea
about 3D driver development already works for NVIDIA.  This is their
public justification for keeping the code closed, which means you're
unable to migrate to newer kernels.

If you want to support open source, I'd recommend moving away from
vendors such as these, who clearly don't 'help' or 'support' anything to
do with open source at all.

Cheers,
Daniel

--1WN/MJ7JJGqVzwIW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiXKmQACgkQ68xJuWtYYdVypQCgnihA3mfRsD6FxXqdkZ+6aH2e
NJ4AnjkpGxYXxNUgpzbawlrvkyqTR/U1
=58ie
-----END PGP SIGNATURE-----

--1WN/MJ7JJGqVzwIW--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
