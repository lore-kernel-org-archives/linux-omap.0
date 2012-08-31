From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 01/13] usb: musb: dsps: add phy control logic to glue
Date: Fri, 31 Aug 2012 16:19:17 +0300
Message-ID: <20120831131915.GA25341@arwen.pp.htv.fi>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
 <1346411399-23964-2-git-send-email-ravibabu@ti.com>
 <20120831122342.GC24861@arwen.pp.htv.fi>
 <CAAe_U6LaCiEPB9ET26j2xjLtumKzJGu+CtW=fK_02d30Z-3BgQ@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAe_U6LaCiEPB9ET26j2xjLtumKzJGu+CtW=fK_02d30Z-3BgQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2012 at 06:51:04PM +0530, ABRAHAM, KISHON VIJAY wrote:
> Hi,
>=20
> On Fri, Aug 31, 2012 at 5:53 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > Hi,
> >
> > On Fri, Aug 31, 2012 at 04:39:47PM +0530, Ravi Babu wrote:
> >> From: Santhapuri, Damodar <damodar.santhapuri-l0cyMroinI0@public.gmane.org>
> >>
> >> AM335x uses NOP transceiver driver and need to enable builtin PHY
> >> by writing into usb_ctrl register available in system control
> >> module register space. This is being added at musb glue driver
> >> layer untill a separate system control module driver is available.
> >>
> >> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> >> Signed-off-by: Santhapuri, Damodar <damodar.santhapuri-l0cyMroinI0@public.gmane.org>
> >> Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
> >
> > Kishon, you were adding a real phy driver for OMAP's internal phy logic
> > on one of your patches and I believe this will conflict with your
> > changes, right ?
>=20
> Indeed. My final patch of that series removes some of the functions
> from omap_phy_internal.c (which was taken care in the phy driver).
> >
> > How does this look to you ? Is this at least correct ? I suppose the
> > correct way would be to actually have the system control module driver
> > which we have been waiting, right ?
>=20
> Correct. I think once we have the system control module driver in
> place, we'll have everything wrt control module register writes
> implemented in correct way.

So $SUBJECT will pretty much be thrown away once we have SCM driver, in
that case it's best to wait a bit longer and apply this series once SCM
driver is available and after your series too... you agree ?

--=20
balbi

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQQLnTAAoJEIaOsuA1yqREaAIQAK5IhmpetLlOgoFnOWY57srv
fjIlHc1SHt2k5oDS9CVa3AUy6SyMx8OOGwEBxkSoCU8/NFyCqwVo8opQ1yeXwI3X
QAKI5c6Zkllnc9STp7xeUGe/dv/Bub7noNKVqjMwTFMHocAHDR10zyU2CIwJi5O7
kcZkPqfVyMwE1PZVvd7FyIsXcoPygyv7q9oKt4qNrKw4KLLzVpi1JPVfCWRvOR9a
dxqdHEv6sMz92syVEK8Ct4hWpruZXPHOJSNJO710munM1jdGlRrVjLJ1DLeVVYA4
VJ/KipGomnRYcTZVpzp/RvoP4YDNvuUXkV/BAxY0OpWblIX2e1J6r6wCdGZ9EfRC
ELGGPeyWxi94Kcfv1caiXzv1E27nFNAz6bNvuHPkHTjaqJHYEP902h4kJiQwDCCs
AhBwfcHRIKPuGeoGc1I6O/ZPRM7pl8d6mcP26qOuqOwFMU/4F2nGuBE87m5BTRn2
Rte8Lpha+QXurkwDx8OSM5s4UJXCmDjqK4UasRgEViMb77KEuCQ7eEuXHn9tT6so
LSB0bf9Aslx+qV+pyvSHVuP/xmMPbg8jQVPXDZvbFDLzwfM2vlq//WNjGpObYnsr
puZJRpDxs8aARGaqaOQmxn3IcniI4j54+Ne9bJZWRdq4jjPBRQvFr8OQuv0nCpXT
aMHnwI7b0OlJ+4VJJk2E
=8tfv
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
