From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/4] mfd: smsc: Add support for smsc gpio io/keypad driver
Date: Tue, 21 Aug 2012 16:27:44 +0300
Message-ID: <20120821132741.GI10347@arwen.pp.htv.fi>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-2-git-send-email-sourav.poddar@ti.com>
 <20120821124146.GA21557@sirena.org.uk>
 <20120821124243.GG10347@arwen.pp.htv.fi>
 <20120821132222.GF7995@opensource.wolfsonmicro.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2430233603340970938=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120821132222.GF7995-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============2430233603340970938==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JVYm2bz4YjPqKA1I"
Content-Disposition: inline


--JVYm2bz4YjPqKA1I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2012 at 02:22:22PM +0100, Mark Brown wrote:
> On Tue, Aug 21, 2012 at 03:42:45PM +0300, Felipe Balbi wrote:
> > On Tue, Aug 21, 2012 at 01:41:46PM +0100, Mark Brown wrote:
> > > > +	regmap_read(smsc->regmap, SMSC_DEV_ID, &ret);
> > > > +	dev_dbg(&i2c->dev, "SMSC Device ID: %d\n", ret);
>=20
> > > I'd make these log messages dev_info() or something.
>=20
> > dev_info() ? It'lll just make boot noisier for no good reason. Which
> > user wants to see this during boot up ? That's a debugging feature for
> > develop IMHO.
>=20
> Most of the registers appeared to be chip revision information which is
> most definitely useful to tell people about, though possibly with neater
> formatting ("why is this batch of boards failing...  oh, right").  If
> they're fixed device IDs then the driver should instead be verifying
> that the registers contain the expected values and bombing out if they
> don't.  Either way dev_dbg() isn't too helpful.

I still beg to differ. Even if it fails, dmesg will still contain the
message (provided you have it enabled). I really don't think we want
this to print to console on every boot.

If you're still testing your new batch of boards, you're not just a
simple user and you will have debugging enabled anyway. dev_info() will
be visible to anyone who's got a console running. Not sure how useful
that would be to my neighbor.

--=20
balbi

--JVYm2bz4YjPqKA1I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM4zNAAoJEIaOsuA1yqRE2u0P/1E2CIENR9R9DEuu1Zna1UJ6
hrefGLqEJMtFtQp4FgTb74Ah+yi7UcDBuODTNDR8YLZ81s38ITGp60akRtujuHeX
QkKToGPy6B3pDgD4bQe2DRKJ/om7U+Zw3QiU8GdUpznxO/wDcwSWoucDk5hZjKN6
/hFf/oT1ws60ECBI4zC028hYQ/MXymEy7k16XVvgd7KEHlxqaYmMAWeZaNY9fJlq
JNLVaXblYKj/LiJ9m80PJUrLb7+nrFJGIgftvXwd5pBrFB8UBpy9zSxaKrD6O2Ox
68y9/VFjR6ssHAgI3zL0LofobZMOfaQ2h63TiLI+NoHTz08LnZK/EUHKnT+keTLi
guX0MjXCmM35qm24Ft8IIxMlG+Z6B8obCGjziZTr0vlTgX1yYVw3oWL8EK9oh8GC
iBhicTUrMTYXiX+0nQ0jmOFcrKUnE488a/AFg+1VqMbcW6oOveHzDf5G6kOgEHq7
FTsDodRfi8T6dD3hv7QIWZ0JVHnDSu+PRzWJ6P0hDADiTzheFBIlAzz8ZFN2VueM
6O8/Lrnh//4HSRirCXMPvxLFhQMjXvY7R7+S4pmXCzhc39+wOwQwn9fbk0yxc1jD
hvKJ8odxvS/EkKi58UiW5VfLFHI2K0kHHMKetLlVJPn29YQ7UFbEVTY9YYCmp5QZ
Qeh6KBPriMn7z5jFIh0W
=dtOa
-----END PGP SIGNATURE-----

--JVYm2bz4YjPqKA1I--

--===============2430233603340970938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2430233603340970938==--
