From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V4 3/6] OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
Date: Mon, 20 Aug 2012 11:42:04 +0300
Message-ID: <1345452124.2684.7.camel@deskari>
References: <1344859176-4512-1-git-send-email-cmahapatra@ti.com>
	 <1345115913-6773-1-git-send-email-cmahapatra@ti.com>
	 <1345211692.3158.160.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-4ZmKEQr5AnnWLbAMg10a"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:45829 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751882Ab2HTImJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 04:42:09 -0400
Received: by lbbgg13 with SMTP id gg13so140822lbb.41
        for <linux-omap@vger.kernel.org>; Mon, 20 Aug 2012 01:42:07 -0700 (PDT)
In-Reply-To: <1345211692.3158.160.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-4ZmKEQr5AnnWLbAMg10a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-08-17 at 16:54 +0300, Tomi Valkeinen wrote:
> On Thu, 2012-08-16 at 16:48 +0530, Chandrabhanu Mahapatra wrote:
> > All the cpu_is checks have been moved to dss_init_features function pro=
viding a
> > much more generic and cleaner interface. The OMAP version and revision =
specific
> > initializations in various functions are cleaned and the necessary data=
 are
> > moved to dss_features structure which is local to dss.c.
> >=20
> > Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>=20
> > +static int __init dss_init_features(struct device *dev)
> > +{
> > +	dss.feat =3D devm_kzalloc(dev, sizeof(*dss.feat), GFP_KERNEL);
> > +	if (!dss.feat) {
> > +		dev_err(dev, "Failed to allocate local DSS Features\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	if (cpu_is_omap24xx())
> > +		dss.feat =3D &omap24xx_dss_features;
> > +	else if (cpu_is_omap34xx())
> > +		dss.feat =3D &omap34xx_dss_features;
> > +	else if (cpu_is_omap3630())
> > +		dss.feat =3D &omap3630_dss_features;
> > +	else if (cpu_is_omap44xx())
> > +		dss.feat =3D &omap44xx_dss_features;
> > +	else
> > +		return -ENODEV;
> > +
> > +	return 0;
> > +}
>=20
> This is not correct (and same problem in dispc). You allocate the feat
> struct and assign the pointer to dss.feat, but then overwrite dss.feat
> pointer with the pointer to omap24xx_dss_features (which is freed
> later). You need to memcpy it.
>=20
> I also get a crash on omap3 overo board when loading omapdss:

The crash happens because dss_get_clocks uses the feat stuff, but the
dss_init_features is only called later. Did you test this? I can't see
how that can work on any board.

Also, in the current place you have dss_init_features call, in case
there's an error you can't just return, you need to release the
resources. The same problem is in the dispc.c.

 Tomi


--=-4ZmKEQr5AnnWLbAMg10a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQMfhcAAoJEPo9qoy8lh71w0EP/RI+8sPuYBQjdd0sX+aOmrDW
Vr4tbMj4p1vDLZY743Sovx16yUvgiEZnc0I9q5pR/LeUGayGlQq0pNTWR/xjR+wY
FUF9VRcIl4r+ywdQtKUABDpji/jXI1yC3oS9qIjpekD1rh+K+8CMyCA+RXhOepRr
fm0oHtgfEswQ86A0SRftkIdbd+plRdv4w82LoioF6tfmLhVeipj1q9fwMAxAY24g
MjnTHEd1d+ucRBvEkG6YkdxiBcBdvJjWRPCU+I/yLULD78grUlSmWS/AmE4LvzHp
l/AWsPQbdpSiiylRN7xBQ6srT7daoj1pf8iLAlspZXw+We+bVrvwV+8a4bVZNGpe
Iz9cuAq3JXhBOcejLWy35QUKCwhmE6sSbCQmvBSkstb3LPzkJ4Gd7k2dZMNBURZa
S10HYl9gha5BUNtGiz0KCuWQ/bUml9psyhriPpG6D2/Clw4seH0dLK7mID8X/o+R
h3LxjFi2q+MPrURThA2VhTKObTncwFQrsh8bs289YinU+jqxAX8wnX/ysLFZsZox
s7z9CIiU3tJZazuzjYq0PuqyaOnHAojiIG0M02V7Tm5DFgdAYEqz+2nrayAbCyXa
GTV8kHwyo0UEA3nDD0590+86ytmUehcgWPoLS1tW4GRkgiY67zV4BC8UBF2Akyms
HNBXonhlfYU9JtTsF3/5
=JhDh
-----END PGP SIGNATURE-----

--=-4ZmKEQr5AnnWLbAMg10a--

