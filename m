From: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Subject: Re: How to handle named resources with DT?
Date: Wed, 31 Aug 2011 12:32:29 +1000
Message-ID: <20110831023229.GF11906@yookeroo.fritz.box>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<877h6173wm.fsf@ti.com> <20110826041200.GD2308@yookeroo.fritz.box>
	<201108261258.32880.arnd@arndb.de> <4E57A9FB.5030404@ti.com>
	<20110830022912.GE4254@yookeroo.fritz.box>
	<20110830092722.GG23907@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3448771816306626849=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110830092722.GG23907-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "G,
	Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--===============3448771816306626849==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 30, 2011 at 12:27:24PM +0300, Felipe Balbi wrote:
> Hi,
>=20
> On Tue, Aug 30, 2011 at 12:29:12PM +1000, David Gibson wrote:
> > So, I actually agree that in the long term getting resource names in
> > the DT would be a generally good thing.
> >=20
> > But doing so is a *huge* change in one of the very core semantics of
> > all the DT bindings.  It's not something that should be done lightly
> > or quickly.  It absolutely should not be tied to how this is handled
>=20
> the longer you take to change, the more complex will it be to
> change.

No, not really.

> The longer we spend discussing the validity of _byname(), more
> boards/archs/whatnot will be converted to DT without _byname() and after
> a certain amount of them are converted, noone will be willing to change
> and validate everything again.

I'm not discussing the validity of _byname (Russell King is, but
that's not an argument I have a position of).  What I'm saying is that
the kernel internal use of byname, and named resources in the DT are
different things which should be approached independently.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5dnT0ACgkQaILKxv3ab8bqcwCfa4KoCnb3WgdzhlAXJAVoHmTU
7GoAn0uHihDif+k4Gi4P182btYdXZfkw
=J3Rf
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

--===============3448771816306626849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============3448771816306626849==--
