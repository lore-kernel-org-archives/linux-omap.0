From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 16/30] usb/musb: HDRC depends on TWL4030_CORE for OMAP3/4
Date: Sun, 2 Oct 2011 21:59:54 +0300
Message-ID: <20111002185953.GB25690@legolas.emea.dhcp.ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-17-git-send-email-arnd@arndb.de>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1965775576=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317566760-25681-17-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============1965775576==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 02, 2011 at 04:45:46PM +0200, Arnd Bergmann wrote:
> The musb_hdrc driver tries to select TWL4030_USB or TWL6030_USB
> on some platforms, but those symbols in turn depend on TWL4030_CORE.

the very fact that MUSB tries to select those is wrong. That's also some
buggy legacy crap which is still floating around...

MUSB does not depend on TWL4030. MUSB depends on a PHY being available,
no matter which one.

IMHO, this would be better moved to board definition, ideally with an
option for selecting some symbol as module (as I have suggested before).

Ideally, all those broken dependencies on MUSB would be cut down to
depends on USB && USB_GADGET.

--=20
balbi

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOiLSpAAoJEAv8Txj19kN18DcH+wSGtsmnq2ROFyLlYU8FYK+4
1+yjEznbrqsifO0SfhiO1fI3QO9uNcMtxjuvbmvcpQErTUfx3omubM1Gwv/ea3YT
y5WbxScvwyqhWtXqNhSwPz9XeF1xRkxqyPHRD+IkQhbA8PMFW0Iyfev2jHJuRcua
T/xdPGw/9z6igxjj6AYQvWP1mUJJDI0POavpm8nqhM5IS3nKqd1i2C/ydyz5PBqV
aatvMsSFyzjuyMq5qW4zeQB+p8FTvX3voerwhCrvJqm0XL3wQeiPppkVKVoekNsm
vlSKemqAyRnjbsqENLcv50yYQTIj1Tn7yVkZJuj9ur68UuBUelDB6xGJFSTSpCs=
=Pw7r
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--


--===============1965775576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1965775576==--
