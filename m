From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv1 00/14] omapdrm: DSI command mode panel support
Date: Tue, 24 Oct 2017 00:01:00 +0200
Message-ID: <20171023220100.cso5sbxcx7itcj5r@earth>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
 <20170929132649.63dy7mzjgknaevoa@earth>
 <b66ec006-e998-b8c6-8ef1-5bf19208c100@ti.com>
 <20171013171207.GO4394@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pqmjrjnt6s4l2c6l"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171013171207.GO4394@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--pqmjrjnt6s4l2c6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 13, 2017 at 10:12:08AM -0700, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [171012 01:46]:
> > On 29/09/17 16:26, Sebastian Reichel wrote:
> > > Hi Tomi & Laurent,
> > >=20
> > > ping?
> >=20
> > I've been having quick glances at this every now and then, but I'm not
> > sure what to do with the series.
> >=20
> > We have one work item that more or less overrides everything but
> > critical fixes: moving to common DRM encoder/panel drivers. Anything
> > that makes that work more difficult should be postponed.
> >=20
> > Especially patch 6 in this series most likely falls into that category,
> > and might require a very different implementation with common DRM
> > drivers. Also everything in panel-dsi-cm needs to be ported to a common
> > DRM panel driver when can use them.
> >=20
> > So my gut feeling is that it's best to keep this out for now, and rework
> > it after Laurent gets the common DRM drivers working with omapdrm.
>=20
> Laurent, got any other comments?
>=20
> Maybe some of patches can be already applied to shrink down this
> set a bit?

I talked with Laurent at ELCE about this patchset and he is fine
with this series going in before his work assuming its fine
otherwise. He has not yet reviewed it, though and is busy the
next two weeks.

Regarding the panel-dsi-cm porting work: I will take care of this
once the driver uses common DRM drivers. I don't expect major
problems once omapdrm implements common drm's mipi_dsi_host. I
do use the standard DT properties already.

I do agree, that not applying this series makes Laurent's porting
work easier, since he can rip out all of DSI. It's not used by
anything except panel-dsi-cm, which is broken without this patchset.
I don't think that's a fair thing to do, though.

P.S.: I got asked by different people about the status of this
patchset, which is required for display support on N9, N950 and
Droid 4. It's not just me and Tony, that are interested in this :)

-- Sebastian

--pqmjrjnt6s4l2c6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnuZpkACgkQ2O7X88g7
+pqbNA//YbRMWW3RdN1T8ljs8z8ssRQ885hvU6j3ykUkcDL/CN3MwcoJnjQj4niq
Y8QpZChQBvHxYGyVYzhg/hZcdaKLZoqQcskO7cKRjdeRLQuNzz5TLQ+/7x5ITFAr
8jWqYoFbemdhBNPYp8nkelYSjkpxN4hGLNABDTg9/UI2HaBJ8J0BnCOyLW4QIFAT
ecpYVxNIDIG4n17yAx3u61hdetdpzHe7yNUIPRGIh3UfUG4dXQGNHoTfFPS7cObR
eHhb9JcD0a3yO0ygNPYnBRt5IHg5PUkyMZF5/LZqb1bWf0HuFtMngqIQMnZ1NxCE
7bF5p4iBYUM0a8Og1PG5GsP8K8AQO4SrkJOey8G7h6IGBxzMTPaYNuWVKWMMl5C9
HoLOnW3619KOLiIcFuEI15/ZyS62F7ExNq7uAns9Z+63Or42AHucIiezjEZuIIoe
O+XHuoPHQLgplaP3rGNrHzQvOGffylWLc/q/e0099O3XvFTLvEAE8Fe00ug/w2Gd
J63zy4uuqzdv7XvJfz9LSoapXWYuDgiGe0OiNOqX6QfqwovqHgbsknkUpiM4hWAK
v3peX5t9lDEyGNDB1WqRiJrKdHIDiKnkAN6SW0FbnrQx6XaVytCvlUWk0vENtmDy
rasAbvVxJjA51iWymSdXS1dLME05B8DyQ/NykpXjhqPiv69cJJM=
=nq+b
-----END PGP SIGNATURE-----

--pqmjrjnt6s4l2c6l--
