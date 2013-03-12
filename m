From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/8] usb: phy: nop: Add some parameters to platform data
Date: Tue, 12 Mar 2013 15:17:03 +0100
Message-ID: <513F38DF.5040404@pengutronix.de>
References: <1363087466-32444-1-git-send-email-rogerq@ti.com> <1363087466-32444-2-git-send-email-rogerq@ti.com> <513F177D.40500@pengutronix.de> <513F37DD.9030301@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2VKTUQOOAFXLDGOKPQWDE"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <513F37DD.9030301@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, tony@atomide.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2VKTUQOOAFXLDGOKPQWDE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/12/2013 03:12 PM, Roger Quadros wrote:
> On 03/12/2013 01:54 PM, Marc Kleine-Budde wrote:
>> On 03/12/2013 12:24 PM, Roger Quadros wrote:
>>> Add clk_rate parameter to platform data. If supplied, the
>>> NOP phy driver will program the clock to that rate during probe.
>>>
>>> Also add 2 flags, needs_vcc and needs_reset.
>>> If the flag is set and the regulator couldn't be found
>>> then the driver will bail out with -EPROBE_DEFER.
>>
>> Is there a platform which fills out pdata.needs_vcc and
>> pdata.needs_reset? IMHO it makes no sense to add features for the non =
DT
>> case, if there isn't any user for it.
>>
>=20
> There can be a user in the non DT case as well. Consider the following =
example:

I'm just saying, let the implementation up to a real user for the non DT
case. Beagleboard is ARM and there's no point of implementing non DT
fall backs for ARM, IMHO.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2VKTUQOOAFXLDGOKPQWDE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE/OOcACgkQjTAFq1RaXHMCIQCfQ0QryTHifYl3WtDEDhkyFcbR
QmcAn3Idz6HRgHj6+COKo/sBk7o1hOP/
=LXqL
-----END PGP SIGNATURE-----

------enig2VKTUQOOAFXLDGOKPQWDE--
