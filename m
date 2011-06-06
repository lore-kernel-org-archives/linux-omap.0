From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] cleanup regulator supply definitions in mach-omap2
	to use REGULATOR_SUPPLY
Date: Mon, 6 Jun 2011 20:28:35 +0300
Message-ID: <20110606172832.GM12242@legolas.emea.dhcp.ti.com>
References: <1307342762-25363-1-git-send-email-green@linuxhacker.ru>
	<1307342762-25363-2-git-send-email-green@linuxhacker.ru>
	<20110606092126.GG18731@legolas.emea.dhcp.ti.com>
	<EA5D78AA-5A89-43AC-9D14-F378673F5D41@linuxhacker.ru>
	<20110606171326.GK12242@legolas.emea.dhcp.ti.com>
	<547324C9-4B76-410E-86E6-092D062C95AB@linuxhacker.ru>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1896463169=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <547324C9-4B76-410E-86E6-092D062C95AB@linuxhacker.ru>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Nishant Kamat <nskamat@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, balbi@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org


--===============1896463169==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="00sTfE/IIAT5d2r5"
Content-Disposition: inline


--00sTfE/IIAT5d2r5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2011 at 01:18:41PM -0400, Oleg Drokin wrote:
> Hello!
>=20
> On Jun 6, 2011, at 1:13 PM, Felipe Balbi wrote:
> > On Mon, Jun 06, 2011 at 11:45:29AM -0400, Oleg Drokin wrote:
> >>>> -static struct regulator_consumer_supply sdp4430_vaux_supply[] =3D {
> >>>> -	{
> >>>> -		.supply =3D "vmmc",
> >>>> -		.dev_name =3D "omap_hsmmc.1",
> >>>> -	},
> >>>> -};
> >>>> +static struct regulator_consumer_supply sdp4430_vaux_supply =3D
> >>>> +	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");
> >>> this should be an array, as it was before.
> >>=20
> >> Only one is defined right now.
> >> Whoever needs a second element can convert it to array, I think?
> >> What;s the importance of having it as an array right now?
> > because later patches will be easier to review. Look below:
> ...
> > can you see now ?
>=20
> Ok, I get the idea. Do you think it would be best to convert every supply
> definition to an array then just in case?

I think that while you're doing this big conversion, why not ?

> I wonder what are the chances of additional regulators to appear at all
> in many of these.
> What about supplies that are not going to have additional elements
> (like that cm-t35 board, because there simply are no more regulators in t=
he twl)?

Still, It's the same thing I was discussing with Alan Stern on another
thread, it comes down to uniformity and you never know when someone
might decide to hook up and always on supply to any node :-p

--=20
balbi

--00sTfE/IIAT5d2r5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN7Q5AAAoJEAv8Txj19kN1znoH/2eSesFyc1EPur9pU0DtQbMC
7VIQF95+nA4R8yQbvaLae3/qpieymBsAAkTZQpMDWIHaefdh0NVuCqhBUK4ximcm
Y4Z9QQX3zU/de/c0VWHN/4sD0zdUxE/5oeIYvi6CvMNallKkvTke2RizSUI3cXVV
F4+hAgBrQ23amvfIFbzcJiVWKTwhyPpLuz7OSAIkfg2i6sUGGlgC/7ZdoZZ8S8yN
ic8Bl2vd8vbcpCn96AepSkS4wCuEg2wPfYVGVzHrqR4uWNxFBfGlT+7FOChhxxjR
c0IQdc2Ug4KT5F1IuEbOEb9QKdBjO2ArFZERcsw9u3gepbgBPBp9LfguFSZkOYE=
=qY1I
-----END PGP SIGNATURE-----

--00sTfE/IIAT5d2r5--


--===============1896463169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1896463169==--
