From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 7/8] ARM: dts: omap4: update omap-control-usb nodes
Date: Mon, 23 Sep 2013 14:43:25 -0500
Message-ID: <20130923194325.GD309@radagast>
References: <1377529713-19762-1-git-send-email-rogerq@ti.com>
 <1377529713-19762-8-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1377529713-19762-8-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 26, 2013 at 06:08:32PM +0300, Roger Quadros wrote:
> Split otghs_ctrl and USB2 PHY power down into separate
> omap-control-usb nodes. Get rid of "ti,type" property.
>=20
> Also get rid of "ti,has-mailbox" property from usb_otg_hs
> node and provide the ctrl-module phandle.
>=20
> CC: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

Benoit ? Any comments here ?

--=20
balbi

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSQJndAAoJEIaOsuA1yqREtogP/jfWIciNInVv5K4gl7y6ObRU
kTauaD6eux3u+MzIJ34Rn3+q9p4BvOPgmo0XNnfJtOLW86x6Mj0i2KafK/tUhvHg
w88XXKPoiSAq3g6FghkB9TjUCNEQ6pjceiYLNuDAUeXPYD3tfBm7GHCMZjdEiH6U
Qb3dqV9NXcYfOhmnZj03h6+jNk1uVzVSURfyha3ARlZ4MikPCq3yWSHC3NGQ20vL
AZW7bJM9AsneHdB8EGpF5ernIlEFv7kRMolH74zi6ZVX04LqkEi3m4fszYuUlkKX
dO2oLyxzU79+1qgeTt4bCoNzLsrrzGoq5G9mLVB0sGuMB17ligdxiCH0viJhcuVf
HmqN0ixwWnolqQX/oYVYMhDtPMVapLmL08cg9GYlynY3t78kVPagdaqPEGNqhiqo
5aDyFsmHh6QB/5RSTrb981of1c9wLG2fzOnHMVd99umlVDCRWtNgEOi5gstAEMBZ
oDdd2DHz594kSzOLnUWKUKKlSHNr7MiiKODsEABplNYrIvRpjqfjtHmGoBuzUZKk
VNv8Pbm9wsMYHEcompqn2w9cFMnnDGKPHzDXahNg3HmSibGV545g61yFuqkpbe2u
YYQsOz++0UPOV+bDMBFiShYLJWBaQYsA/yIyBgEKOge+b7YRr94UTBXEKe7oB7F9
G5wpUnbhEnrM1q2BfxN4
=DIC/
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
