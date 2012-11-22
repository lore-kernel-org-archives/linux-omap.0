From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v4 11/11] ARM: dts: AM33XX: Add PWM backlight DT data to
 am335x-evmsk
Date: Thu, 22 Nov 2012 22:12:45 +0100
Message-ID: <20121122211245.GJ16716@avionic-0098.adnet.avionic-design.de>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-12-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOmey7/79ja+7F5w"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353503469-18634-12-git-send-email-avinashphilip@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, hvaibhav@ti.com, anilkumar@ti.com, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, gururaja.hebbar@ti.com, vaibhav.bedia@ti.com
List-Id: linux-omap@vger.kernel.org


--BOmey7/79ja+7F5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2012 at 06:41:08PM +0530, Philip, Avinash wrote:
> PWM output from ecap2 uses as backlight source. Also adds low threshold
> value to have a uniform divisions in brightness-levels scales with
> inverse polarity.
>=20
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> ---
> :100644 100644 f5a6162... 6f3de83... M	arch/arm/boot/dts/am335x-evmsk.dts
>  arch/arm/boot/dts/am335x-evmsk.dts |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)

Same comments as for the previous patch, but otherwise:

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

--BOmey7/79ja+7F5w
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQrpVNAAoJEN0jrNd/PrOhcPgP/1p/7a9c6H6GRrA9W+jR/Sqs
vdTklISbK7bgZNBh5gaUfQENRf02F42WJr+gXSjybI7jRlrfjBJ27L9N8QhSQxNs
wxhkQA4hqSwx6SzeN/ercXFVJMmRObrUG4WLFB9PhphzVxiF/dGBk+6ivGWR4Lmg
cHXrcO3xQCAzhbX3GIIUt4uxigm8Ux9nt9fwv/DxJyuj8CkQRvq+s5zlN06nuJBV
EP49T9XMsP9MEsMhRpl7H8JxcYA8sBQEQJmBh8FdZMlRQiVyRtznUIwogDk6xCN5
Ev3X9KpRe/n6hJwttgIwAk9Gx22+5uyWgfZbWuisfn2mHGEQF+6kVJTn/fCiwjbW
gB9Vr6YZjQHO9m3ecut3fG8CON9b1Z1m+tXZlp7MuFlHzMXF2tawg2gQ+gbw7eEB
CHEkxqr2XoaKuw5zmNbdt6hswzA4JkChMCP/LtJnqhVoqp6NwU1RElMLRterfduz
p8cDDTkrLTu6t1EpfTRbG6EgIN9eeGpwndUc3/esCwAavsjP52lWykifNkGw1s+4
GKpx+Tp+JJ7S/+nsOf3Pfums9APeRvgSFMgdpfY9CAmOI4yozzoC1ruYgiV1KwbE
ySkAj7V/zxv//TWCPjlObHIlXxtrdDKu3pLUDFT1rzF2lfTwa8lY6vAeMhs43+kE
ro0neCgf+IV8Ibw/R6yI
=T3HN
-----END PGP SIGNATURE-----

--BOmey7/79ja+7F5w--
