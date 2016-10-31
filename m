From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 2/2] power: bq27xxx_battery: add poll interval
 property query
Date: Mon, 31 Oct 2016 22:38:46 +0100
Message-ID: <20161031213846.GA21014@amd>
References: <1475092512-30555-1-git-send-email-matt@ranostay.consulting>
 <1475092512-30555-3-git-send-email-matt@ranostay.consulting>
 <CAKzfze9uvMvrF=gWph_HKFk_cH0qzRz6Wa2VJafK+H+wdnP0rg@mail.gmail.com>
 <20161024201443.GB5989@amd>
 <CAKzfze_rv29gwuBGctwTONyw8Oy6fwE+xcN0HMh-ZPB47HKzuQ@mail.gmail.com>
 <CAJ_EiSRzmQHLP2PTfzsLF4uWgYgCiRGsSk=MHbtOC5rgXnnFpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJ_EiSRzmQHLP2PTfzsLF4uWgYgCiRGsSk=MHbtOC5rgXnnFpw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Ranostay <matt@ranostay.consulting>
Cc: Matt Ranostay <mranostay@gmail.com>, pali.rohar@gmail.com, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2016-10-31 13:22:18, Matt Ranostay wrote:
> On Tue, Oct 25, 2016 at 11:47 AM, Matt Ranostay <mranostay@gmail.com> wro=
te:
> > On Mon, Oct 24, 2016 at 1:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >> On Mon 2016-10-24 12:58:25, Matt Ranostay wrote:
> >>> Pavel + Sebastian this is the patchset that need I some input on :)
> >>
> >> Better then previous one.
> >>
> >> But my version of bq27xxx_battery.c already contains this:
> >
> > This is for allowing udev rule to set the properties as well.
> > otherwise a kinda crude RUN =3D " echo value >
> > /sys/module/bq27xxx_battery/parameters/poll_interval" is required.
>=20
> Any thoughts on this?
=20
I'd say  echo value >
/sys/module/bq27xxx_battery/parameters/poll_interval .. is quite
adequate solution...?

Alternatively, convince us that something else is useful for everyone,
and we can do the right thing (poll more often when battery is nearly
empty), automatically...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgXueYACgkQMOfwapXb+vI3oQCdGKxyRFiw0nOfAQjZNqut6C6b
mykAoMH32yVKtlaovynPOf5IXTkcOBED
=gMOS
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
