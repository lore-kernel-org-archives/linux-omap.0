From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv4 10/10] arm/dts: am57xx-beagle-x15.dts: add HDMI
Date: Wed, 3 Jun 2015 14:26:27 +0300
Message-ID: <556EE463.6000502@ti.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com> <1433139798-23450-11-git-send-email-tomi.valkeinen@ti.com> <20150601215115.GH30984@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="agKiT81iWUJeuFWQJMpoPfsFCBSGBtUjU"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150601215115.GH30984-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--agKiT81iWUJeuFWQJMpoPfsFCBSGBtUjU
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 02/06/15 00:51, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org> [150531 23:25]:
>> AM57xx Beagle X15 has a HDMI output. This patch adds the device tree
>> nodes required for HDMI.
>=20
> This one does not seem to apply to linux next, did not look
> further where it conflicts.

Looks like the change was also in -rc6. I've rebased my patches on -rc6,
and added the acks:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git dra7-dss-ar=
ch

 Tomi



--agKiT81iWUJeuFWQJMpoPfsFCBSGBtUjU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVbuRjAAoJEPo9qoy8lh71MOgP/jnIL3B8Nj/ejupu6+3LLtY8
+T/cA2W+vX6T+Ea3dUBKPS4EEzzpTQ8eJXKWHS9fxFzvXDb8XNEnLnA+f8cijLa9
+79L2TSpS7ksjXQG4Cyv63BiLlpibLVB5pcCwhYjSL7giUxYAJT7/s65RG/1ASwr
xh57KYUcq0PFVoVPCLfJTQ+0yQdpycY99zoKWyjmstUcMSCqTtw8o0wAFJXZHTKn
pVyA3qdRH1eRmpLFUf9sGz1ttLxTTadqXGG7UuemE2gDIL9mbaAEN35sCLD/vj1I
pz4hXPI7Dg1Qap4yQQKpTAjbFyJ7o0K69C+eHaXamWzAavOR9O8GaXEnldzU2W9F
fBtG08u5gVK06QkV6RZ2JyYvIsAhcEqMnQnG7Jmoi7vOAnlxY9xc/r+/25Tx2TR2
y0+IZcUUwrfALsZnp4qI0LA9AoRRZC5g2quXdJZVXxJ3I1+IUJyweC8WMflI1eCX
F5Q0tfpyS90Y9PLK4tiv7pXXs0pF8UK40aTdl2pkFvGo2lyyjFhloJ85NGOrSZRe
TrptF4rP05K56eF0ShpPggCzO8+LBMrvIqnHcgOSNNBZjanU7E8z2A2utgnpCdgv
mcri+rhjqr63WEKzMWh5xpoAmlttfw5a9IwIKip98Ty2tmyUpTKza2MvjhPX23V7
PYya9XJwRT1H3BD4micm
=ZnC5
-----END PGP SIGNATURE-----

--agKiT81iWUJeuFWQJMpoPfsFCBSGBtUjU--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
