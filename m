From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] adp1653: Add device tree bindings for LED controller
Date: Mon, 17 Nov 2014 16:15:19 +0100
Message-ID: <201411171615.34822@pali>
References: <20141116075928.GA9763@amd> <201411171601.32311@pali> <20141117150407.GP8907@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2555655.kPujV8QnPf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141117150407.GP8907-S+BSfZ9RZZmRSg0ZkenSGLdO1Tsj/99ntUK59QYPAWc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, sre-GFxCN5SEZAc@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, freemangordon-uiMcrn6V0Vs@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>freemangordon-uiMcrn6V0Vs@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--nextPart2555655.kPujV8QnPf
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 17 November 2014 16:04:07 Sakari Ailus wrote:
> Hi Pali,
>=20
> On Mon, Nov 17, 2014 at 04:01:31PM +0100, Pali Roh=C3=A1r wrote:
> > On Monday 17 November 2014 15:55:46 Tony Lindgren wrote:
> > > * Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> [141117 02:17]:
> > > > On Mon 2014-11-17 11:09:45, Pali Roh=C3=A1r wrote:
> > > > > On Monday 17 November 2014 11:05:19 Pavel Machek wrote:
> > > > > > Hi!
> > > > > >=20
> > > > > > On Mon 2014-11-17 09:43:19, Pali Roh=C3=A1r wrote:
> > > > > > > On Sunday 16 November 2014 08:59:28 Pavel Machek=20
wrote:
> > > > > > > > For device tree people: Yes, I know I'll have to
> > > > > > > > create file in documentation, but does the
> > > > > > > > binding below look acceptable?
> > > > > > > >=20
> > > > > > > > I'll clean up driver code a bit more, remove the
> > > > > > > > printks. Anything else obviously wrong?
> > > > > > >=20
> > > > > > > I think that this patch is probably not good and
> > > > > > > specially not for n900. adp1653 should be
> > > > > > > registered throw omap3 isp camera subsystem which
> > > > > > > does not have DT support yet.
> > > > > >=20
> > > > > > Can you explain?
> > > > > >=20
> > > > > > adp1653 is independend device on i2c bus, and we
> > > > > > have kernel driver for it (unlike rest of n900
> > > > > > camera system). Just now it is unusable due to lack
> > > > > > of DT binding. It has two functions, LED light and
> > > > > > a camera flash; yes, the second one should be
> > > > > > integrated to the rest of camera system, but that
> > > > > > is not yet merged. That should not prevent us from
> > > > > > merging DT support for the flash, so that this part
> > > > > > can be tested/maintained.
> > > > >=20
> > > > > Ok. When ISP camera subsystem has DT support somebody
> > > > > will modify n900 DT to add camera flash from adp1653
> > > > > to ISP... I believe it will not be hard.
> > > >=20
> > > > Exactly. And yes, I'd like to get complete camera
> > > > support for n900 merged. But first step is "make sure
> > > > existing support does not break".
> > >=20
> > > There's nothing stopping us from initializing the camera
> > > code from pdata-quirks.c for now to keep it working.
> > > Certainly the binding should be added to the driver, but
> > > that removes a dependency to the legacy booting mode if
> > > things are otherwise working.
> > >=20
> > > Regards,
> > >=20
> > > Tony
> >=20
> > Tony, legacy board code for n900 is not in mainline tree.
> > And that omap3 camera subsystem for n900 is broken since
> > 3.5 kernel... (both Front and Back camera on n900 show only
> > green picture).
>=20
> Can you capture raw bayer images correctly? I assume green
> means YUV buffers that are all zero.
>=20
> Do you know more specifically which patch breaks it?

CCing freemangordon (Ivaylo Dimitrov). He tried to debug it=20
months ago but without success. Should know more info about this=20
problem.

I think that commit which broke it was not bisected...

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart2555655.kPujV8QnPf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlRqERYACgkQi/DJPQPkQ1IBYwCgzhsqRQpQfxZG0dnW1YH87R3Q
nxYAnjpVF3iWJp95KDWjl5Xf/mVWpHV+
=nJ+y
-----END PGP SIGNATURE-----

--nextPart2555655.kPujV8QnPf--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
