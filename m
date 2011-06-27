From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2] OMAP4: PANDA, SDP: Fix EHCI regulator supply
Date: Mon, 27 Jun 2011 18:05:44 +0300
Message-ID: <20110627150543.GR2508@legolas.emea.dhcp.ti.com>
References: <1308926240-13888-1-git-send-email-jaswinder.singh@linaro.org>
	<1309186923-29192-1-git-send-email-jaswinder.singh@linaro.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0947720971=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1309186923-29192-1-git-send-email-jaswinder.singh@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: patches@linaro.org, tony@atomide.com, broonie@opensource.wolfsonmicro.com, balbi@ti.com, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============0947720971==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PLOb/g6AMdJ1vPHZ"
Content-Disposition: inline


--PLOb/g6AMdJ1vPHZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 27, 2011 at 08:32:03PM +0530, Jassi Brar wrote:
> VUSB is a fixed level line and hence have no set_voltage
> callback in regulator ops, but has apply_uV set to true.
> As a result it fails to register with the regulator core.
> Remove setting apply_uV.
>=20
> Also, assign name to VUSB supply, without which regulator core
> fails to find it and assigns the default 'dummy' regulator to
> the ehci-omap device.
>=20
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--PLOb/g6AMdJ1vPHZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOCJxHAAoJEAv8Txj19kN1cUkH/09wY8Qyx9VRtQDHzJr/6w1X
AL8n4fnnuSPSrarz2tlbggMEQvrvWYwvD4/u/+tg+Orz34N9Nhf8QzqaHY2KAFbt
Bpko9jChED1LOtRu3dCQkeno7vQahGwRCzWuuw/oKF5gkyvENlGsXFz8PalpKTA/
CsD4NFQbYBlo+pguzNQIiPOjbk8DnvE71eVtyAUlJDNQwBeY/oGPB00sXVR3STHT
UKFT+4Jw75Yp68iShEnOc9XM5ismqJ3ESzfavU8fXK1qS6Hy9To+yTmS06XGADzy
nGi5ZfKeRx/CePtyehz+S1tWdD4hwwh7i+HHw7py40BY2Rj7ovr2ERjH4F7KZJM=
=koi6
-----END PGP SIGNATURE-----

--PLOb/g6AMdJ1vPHZ--


--===============0947720971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0947720971==--
