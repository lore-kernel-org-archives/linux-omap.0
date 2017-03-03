From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/8] Droid4 DTS update
Date: Fri, 3 Mar 2017 12:01:44 +0100
Message-ID: <20170303110144.seoxa6xwago7q5ir@earth>
References: <20170302010900.28532-1-sre@kernel.org>
 <20170302013707.GK20572@atomide.com>
 <20170302014910.GM20572@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p25hkyngtgb5qu5m"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170302014910.GM20572-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--p25hkyngtgb5qu5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 01, 2017 at 05:49:11PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170301 17:45]:
> > * Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170301 17:10]:
> > > Hi,
> > >=20
> > > Tony, since your omap4-droid4 dts patches were not
> > > yet in a public repository and they would merge conflict
> > > with my patches I put them all together into a single
> > > patchset. I also added my Tested-By to your patches.
> >=20
> > OK
> >=20
> > > The mounting-matrix for the sensors and the touchscreen's=20
> > > rotation assume, that the phone's default rotation is vertical.
> > > I think that's sensible, because
> > >=20
> > >  * Android on the phone uses this as default rotation
> > >    (like almost? all other phones)
> > >  * volume buttons make sense (in horizontal position one
> > >    would expect, that left button means lower volume. I
> > >    know at least Maemo swaps them)
> > >=20
> > > That should cover all mainline drivers.
> >=20
> > Heheheh cool looks like you configured compass and accelerometer :)
> >=20
> > I have a better touchscreen patch that also configures the wakeirq
> > that I did not post yet at http://muru.com/linux/d4/patches/ in the
> > updated set droid4-wip-next-20170217.tar.gz.
> >=20
> > I have few more interesting ones coming, I got the HDMI working
> > reliably over the weekend. I was planning on waiting until -rc1 to
> > post them but let's see if I can send few patches out before that.
>=20
> Oh and I have the poweroff-gpio patch and tmp105 patch.
>=20
> And the LMU backlight patch should be OK to go as the binding was
> already acked a while back.
>=20
> Some of the command mode LCD patches could be sent out too, and
> if the timing patch is OK then we can configure the LCD in the dts
> too. Have you had a chance to look at those related to what all I
> broke for n950?

I took your patchset and fixed it for N950. The main problem was,
that you dropped the fifo size update, which is required for OMAP3
(HW bug). Here is a branch based on recent master branch from
torvalds. I had a quick test with droid4 and dmesg still looked fine,
but I did not have the lm3532 patches in that branch and nothing is
visible without display backlight. Can you check if the branch works
for you on D4?

http://git.kernel.org/cgit/linux/kernel/git/sre/linux-n900.git/log/?h=3Dn95=
0-display-tony

-- Sebastian

--p25hkyngtgb5qu5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAli5TRYACgkQ2O7X88g7
+pq3Lw//Xw9W+/pAYK8R3PX3IsXsmGNKcnAdeY/VstsKnUP2HXvx2YCuDKN2vto2
Xw/jRHWCdZmHJEdhER1bkgbFNnc4k5jyvtn4Nc2sO2ffwdrUaiblIO9DlZnKDYLV
QQHAlw1uUPxNiBnj0DgK4doYcYAMaMsEn8m2X75mXJuvR1NvXmT6wpKvF8PT7RN+
jqUBR6rlKjE43/fH/Cad9hBIenH4b9csOGc9wAbQC6gOumTs6sL5b27mTmO4HcTl
bf/klD37F7wS/QnhfP8NnmqU7tmmm89TtX32PbxlSq60RQf6Qs+IsiupubtrfvtN
gFXT/+hnk/cRl3+0ppjD2ihmzA3f8oPyEQVC8w0JF8wP/bNWlhRaOfKd8gTdnoJR
Nc39mDbWOjpIO9z2Vrr9vjKDGpUN+Pq68kOCxMnq/J66DP82TMSToQ0h3A5nHImf
hM2lkxTXBFdWmMcJuIVknLk6+JPqYUPbvL3bJlVjEG/qFwJO6t+VTfKiL+efhRxe
avt/uz1JBFfq3Ro0THhOtAzQnawFFaYJ2wlpzXFfw/EjKbU8xcIbbiWQSy75gFRn
knW1SWdh5dja0hd/6pIMbnVYommClGMcK6La7sEN5s/jV0QU9ukP2SfnrCMYi5Yk
MimI8xJEMg/pG+UTcU9ZSmZc6e454l9xQvcdlcFSy1Bd5557jPQ=
=fsSH
-----END PGP SIGNATURE-----

--p25hkyngtgb5qu5m--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
