From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHV3 2/4] OMAP: I2C: Remove the reset in the init path
Date: Thu, 21 Jul 2011 16:59:39 +0300
Message-ID: <20110721135938.GC30943@legolas.emea.dhcp.ti.com>
References: <1311256381-25548-1-git-send-email-shubhrajyoti@ti.com>
	<1311256381-25548-3-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0228291527=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1311256381-25548-3-git-send-email-shubhrajyoti@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: khilman@ti.com, balajitk@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============0228291527==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 21, 2011 at 07:22:59PM +0530, Shubhrajyoti D wrote:
> The reset in the driver at init is not needed
> anymore as the hwmod framework takes care of
> reseting it.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

this is still doing two things:

a. remove the reset from init path
b. add and use ->device_reset() when needed.

--=20
balbi

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOKDDKAAoJEAv8Txj19kN1wvQH/1EYfhsK+kob7QSUDHCRdJxR
lsxTFNLKvb9CFhWKYQPVJ65COLyurinXmrQac2Jw65uStmscuE3p4ljUTRjTUbUn
5t7frLzEpEqURctkV52+++xlRJ18bNyXLbWoMP6zIb2mIRlsYdi8J6Kl/OMaXHDA
ZMF7sONfyT0B3FXJMW7X3VaIi9NzUoBLUzIPigdR2zo2J5gHLEP1+LYpPLozNBp3
5hw4AEQoZ8sulN4rAJbdlpSXVuyvje+3rE18KT9XfmW1D3wICUfpVn5vjTYPZnXd
rnIbwwGsnYO7qPOw7IJWoj9vlHppOQpr3N+Lb/LnQbgmrwRqykUGiEbUZxweOkE=
=lfec
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--


--===============0228291527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0228291527==--
