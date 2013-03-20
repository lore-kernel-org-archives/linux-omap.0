From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 01/21] usb: phy: nop: Add some parameters to platform
 data
Date: Wed, 20 Mar 2013 17:55:55 +0200
Message-ID: <20130320155555.GG1567@arwen.pp.htv.fi>
References: <1363794300-31526-1-git-send-email-rogerq@ti.com>
 <1363794300-31526-2-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vSsTm1kUtxIHoa7M"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363794300-31526-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--vSsTm1kUtxIHoa7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2013 at 05:44:40PM +0200, Roger Quadros wrote:
> Add clk_rate parameter to platform data. If supplied, the
> NOP phy driver will program the clock to that rate during probe.
>=20
> Also add 2 flags, needs_vcc and needs_reset.
> If the flag is set and the regulator couldn't be found
> then the driver will bail out with -EPROBE_DEFER.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>

Hi Tony,

maybe you might prefer to merge commit 1f0972f from my next branch which
is exactly this patch. Basically, if you:

$ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git next
$ git merge 1f0972f

you get $SUBJECT and can apply the others without fear of conflicts
later.

cheers

--=20
balbi

--vSsTm1kUtxIHoa7M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSdwLAAoJEIaOsuA1yqREgJYQAIY3t+G6fRpchPvr/f+HsPde
CitbQE5GDINmQDjeVarI719TgQ9+tcGXHu9tujzVI8vCl2/CxERf5PxSqzV7uKOb
XizkI9VKZoCSzvevcf/W0Zvrwn+R7pcLOZ21blKbhK64O+XNgN3zOwPYVpedVIuZ
Gr+OoW9jkb7pQzrHBoDCSj1r//vRB6jHlNeOZDw20Wsgetg0JqhsHOpw+vXLCOeW
pAF3Jty7V8ijPykP0H/sBLqTTpHe3VTrufhFOYfQEUr4dlf7rBHs/5ADFBwntYXC
0jQt8EtIhx//1oz+fHZixLRRdTXbLIoF9zpd9MmALxdvEtn4E+IHzVSu/tNGqz34
dyg4XCdq42x0bXSF8ypVMtLiYG5WEusc58/gnSzLbqyQj98s0DZvXswLF+h9GFp0
YN8fZSmoPTynBtzo3brdjs1AKPnmuRimH4AtdO+9+1fowfKnbUfOTZ37X90K6iap
fAmUs5bbDJJVmY0aOI1Xmi3zEn8ksCZcve7O4hWCTd1oaXnz9WPsUX5z0GJpWThB
oxosDleWnp0hzMPqMS0EQD/tYCOajl9DZrd7hjJwCWqMXYIGA/f16aBC0od8ICV1
my+8SwfM4lKbWk/t7ZP2ockhkvz0FUnzeYljZaKezBXbEzp0/EZMbUq+5wZEEUH8
yVe5Tjdg3qw4b2A0qYdT
=j9hA
-----END PGP SIGNATURE-----

--vSsTm1kUtxIHoa7M--
