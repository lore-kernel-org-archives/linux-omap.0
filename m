From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] nokia n900: update dts with camera support
Date: Thu, 17 Aug 2017 02:08:45 +0200
Message-ID: <20170817000845.agkcuvqaheejm33j@earth>
References: <20170810204923.GA18442@amd>
 <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
 <20170815220349.GA15441@amd>
 <20170816205332.rqcuenvuxfs5jvuw@earth>
 <20170816205915.GA5386@atrey.karlin.mff.cuni.cz>
 <20170816212343.hfd4azb4dq2qrlkc@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="75xnpki7yhyrrcpi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170816212343.hfd4azb4dq2qrlkc@valkosipuli.retiisi.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--75xnpki7yhyrrcpi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 17, 2017 at 12:23:44AM +0300, Sakari Ailus wrote:
> On Wed, Aug 16, 2017 at 10:59:15PM +0200, Pavel Machek wrote:
> > > On Wed, Aug 16, 2017 at 12:03:49AM +0200, Pavel Machek wrote:
> > > > diff --git a/Documentation/devicetree/bindings/media/video-interfac=
es.txt b/Documentation/devicetree/bindings/media/video-interfaces.txt
> > > > index 852041a..aade681 100644
> > > > --- a/Documentation/devicetree/bindings/media/video-interfaces.txt
> > > > +++ b/Documentation/devicetree/bindings/media/video-interfaces.txt
> > > > @@ -119,6 +119,8 @@ Optional endpoint properties
> > > >    as 0 (normal). This property is valid for serial busses only.
> > > >  - strobe: Whether the clock signal is used as clock (0) or strobe =
(1). Used
> > > >    with CCP2, for instance.
> > > > +- clock-inv: polarity of clock/strobe signal. 0 - not inverted, 1 =
- inverted
> > > > +- crc: crc is in use
> > >=20
> > > booleans in DT are not done with <0> and <1>, but as properties witho=
ut
> > > values. True =3D property exists, False =3D property does not exist.
>=20
> Now that you mention it, I remember that now.
>=20
> > Well, strobe property above already uses =3D <0>/<1> format, as do
> > others.
>
> > Problem with "false =3D property does not exist" is that you don't know
> > if it is "someone forgot to define it" or "someone made a typo" or
> > "dts is too old to know about this property" or "the property indeed
> > should be false"...
>
> As this is an established practice, I think we should follow it for bool
> properties.

Yes it's common practice, there is also device_property_read_bool()
to get the value.

> We could change the existing ones, too, and leave some extra checks in
> place to handle old dtbs.

The following should be downward compatible:

var =3D read_bool();
if (var && !read_int())
    var =3D false;

Btw. DT people should be CC'd for DT binding additions/changes.

-- Sebastian

--75xnpki7yhyrrcpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmU3ooACgkQ2O7X88g7
+prp1hAAoAd4wzMwvbZZJAQU7Gphvf/LuvvE9ay0hA1iSsk5Cx/MBy5Mtmk6/hmh
52gpVbZWz3ODP+ptsqycAPMM0mN0Wb8Gq9qj4CRtDhc0ud/jBjqf8/dvAkjqUGLl
kwhhoii2lXbTqtFUkJM/ormmLgxsXRQRFbuJLw9SCduDQ4MWXgTFMUiwSA84cxVw
EtP6RfqVw1xLrbK2IMLeIdHlX/9v0yLFh4+2zwwDWqxAcIMSuJbCxvbJdjkb3keb
r1xy8+312ED3zNSgj5qnZfJlF79ZlXC4zajXWF0Ybs9//2NfKpdGZAK0oQ5APS4l
xd+6931i9rpLXduNeUC+HhbMHO2LLMAAabMtPcSkUTLeMOmfKD/M5NeKQcPYXSxl
3gdi09ue/quTVf9jyUvaQvT2epL6ALtN1Fgc43ZjyKZQ1Zv+zbwKPWMHqIax61tl
ZOXtSeYc5RvbDBP6vVHnYaLNz7/Ka8O2dpZLfRd84gj9uyj2kZF0ArGH+eSiZnBp
V0uqiL4kt3Bkj0sp/XnIDZdBjyoMJ3kEb78H2zGWZvdiXByIFZNyKqYdeaT6jbqQ
qIYFTEwGj7xhW+7DwdEQ/C+B0UkiyyLk2puuiieBqLrAUgVocsk1ZZhJIRZsZhKj
PgjKnxqCzcHSQgcGOYwhXww8NKs4mlGxg9di9/OhRDBVmCo82DM=
=urWq
-----END PGP SIGNATURE-----

--75xnpki7yhyrrcpi--
