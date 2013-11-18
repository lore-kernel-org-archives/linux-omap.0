From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5] mfd: twl-core: Fix passing of platform data in the
 device tree case
Date: Mon, 18 Nov 2013 12:40:29 -0600
Message-ID: <20131118184029.GA10676@saruman.home>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-2-git-send-email-tony@atomide.com>
 <20131118102907.GC13640@lee--X1>
 <20131118172510.GI16038@saruman.home>
 <20131118174638.GQ13640@lee--X1>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1915298537010058595=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131118174638.GQ13640@lee--X1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

--===============1915298537010058595==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 18, 2013 at 05:46:38PM +0000, Lee Jones wrote:
> > > > +static struct of_dev_auxdata twl_auxdata_lookup[] =3D {
> > > > +	OF_DEV_AUXDATA("ti,twl4030-gpio", 0, "twl4030-gpio", NULL),
> > > > +	{ /* sentinel */ },
> > > > +};
> > > > +
> > > >  /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
> > > >  static int
> > > >  twl_probe(struct i2c_client *client, const struct i2c_device_id *i=
d)
> > > > @@ -1271,10 +1276,14 @@ twl_probe(struct i2c_client *client, const =
struct i2c_device_id *id)
> > > >  		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
> > > >  	}
> > > > =20
> > > > -	if (node)
> > > > -		status =3D of_platform_populate(node, NULL, NULL, &client->dev);
> > > > -	else
> > > > +	if (node) {
> > > > +		if (pdata)
> > > > +			twl_auxdata_lookup[0].platform_data =3D pdata->gpio;
> > > > +		status =3D of_platform_populate(node, NULL, twl_auxdata_lookup,
> > > > +					      &client->dev);
> > > > +	} else {
> > > >  		status =3D add_children(pdata, irq_base, id->driver_data);
> > >=20
> > > Why doesn't the TWL driver use the MFD framework for this stuff?
> >=20
> > that's reminiscent from years ago and, surely, needs to be fixed. Should
> > we gate $subject for that, though ? This has been in tree for quite a
> > few years already and Tony's patch is still a step forward, since most
> > omap3 platforms would break on DT-only without it.
>=20
> I didn't say that I would reject the patch. I was just surprised to
> see so much hand-rolling, as the MFD core code does much of it
> automatically. This is the first time I've taken a look at this and it
> seems to be quite the relic.

alright, thanks for confirming.

> > There are quite a few folks who could volunteer to fixing that after
> > Tony's patch is in (me included, although there could be better choices
> > hehe).
>=20
> Well it's not doing any harm. I'll make a note to fix it myself if a)
> no one has done so already and b) I manage to find some spare
> time. The latter issue is less likely to be resolved. :)
>=20
> Are you Acking this patch by the way?

sure:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSil8dAAoJEIaOsuA1yqREp1cP+QHGzl347B0f9VICLDIIwY5l
dE6dhGHMzIY7dZ8EVRU2+sVJs2I/sKVuN8VsncZwiL8zH9eS9XETiNJdnUDCIpwy
Jyj8rB2kRg+FCENcX6Dp4DE6pyyCAZiK3khwIbZVhlPrUXl32cxyeeAKCHg2PWL5
tTNb5lUvfYgmZxotMJfavoqZpDOhVFIltFtqqRPPOjqTheRjudb3RQ+qb4+2sAyp
fboI4kwe+EyffEcJnmcQ95VNQy+YJxmOD9DhHp/hjOXpbuY1IJ5a9MY85KYAIQev
32l4yXEDozX5H29C3jGo3Ciq8R9nIN3pydEQ8PQbO8CVA61p7bJL93ZGubm2U+iP
GekU1CRYzmjSMtgMZ7TL2EPtq7Bhr5v+Y1gRCD+HShpMk7b+eqjqUAxAeBl0udtz
P66fh93kyHZ24HBvTcFseu/2ZYtvbSOPp38MJvUSgdWjDOObUov58UdSI4oVGqJL
YMbMRLi8xjO9RuVyJZXN8G7EviQMvFdG0iBYXIkULvUR21mz7tsmUlQETOmQbHCm
juo/F1jeaYojbRQsygGodIBtHDIiHfa4yX2DUpu1wh2SAecT0TrkALL03y85ExHE
PJg35hAgup5oaPa7Z2cSQVRYgDpTAHVa7mai6XFRbrB3dbKaT6h+FWRGiz6pCv4p
A1j/EmuAYBem28cry+Nj
=r9AG
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--


--===============1915298537010058595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1915298537010058595==--
