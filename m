From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/5] usb: musb: dsps: remove the hardcoded phy pieces
Date: Thu, 25 Jul 2013 17:28:34 +0300
Message-ID: <20130725142826.GF16106@radagast>
References: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de>
 <1373031178-8871-4-git-send-email-bigeasy@linutronix.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvznHscUikHnwW2p"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52413 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755609Ab3GYO2p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Jul 2013 10:28:45 -0400
Content-Disposition: inline
In-Reply-To: <1373031178-8871-4-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Felipe Balbi <balbi@ti.com>, george.cherian@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Benoit Cousson <benoit.cousson@linaro.org>

--GvznHscUikHnwW2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 05, 2013 at 03:32:56PM +0200, Sebastian Andrzej Siewior wrote:
> dsps uses a nop driver which is added in dsps itself and does the PHY
> on/off calls within dsps. Since those calls are now moved the nop driver
> itself, we can now request the phy proper phy and remove those calls.
> Currently only the first musb interface is used so we only add one phy
> node for now.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

looks good, just wondering if this won't pose a regression since you're
not substituting PHY handling with proper usb_phy_set_suspend() calls.

--=20
balbi

--GvznHscUikHnwW2p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR8TYSAAoJEIaOsuA1yqRE2AQP/i6Uo2WfaCSVVp8gQx57QN56
q1HsO6ZzorZ+ttFq0Gwwi50C6woWx93plQhXj9B3iqghki902pz5M6G28h0il4D2
ObHZHZszx4DScfCp7X0efOuGkBKcfpvQUNbhXSlNH+T3Tw9Ti0C1Q4KICTbtOjRg
1NXWiRkOLXdtKnk3QLjK3wZsB7fy8hwQoPBtCBjQcAH93/GvI6d/QfIvYA/aqwN4
mEUe0MHKI8gqA8dTx8VmK9bsx+eaq33P19w5pO+VdH5oHBo413sUgHiLKSP/pOcH
wkcKxxn+G19whfNptOkgbTv4pNqeZHaXnhquISMEe9jbQbikuYz+cVIoJisv0IKL
uFD33EFxBWKAVkgDS4wxH+5dt6KB6VJ31GuN7NSVacuVhNdlYQQU1mPq6gyKE7k+
QshoOjPZ2H9wHBuGW7JNKb6kDOs89Q9CaCH3h7BTcrMoYmuBgWClIi2FmbFxG8M1
4f8S3Ht4maP60Lxk8d6Q3jJdLfi5Cqi8OQ5lsPOQ1uxHEuAp/71oytfk/PxBUWE2
jkLm2OsCL52SReb2epjj0elStPId6l6JCeNiieRrbvvusw0XtAvnTbvsCLV1K8Qh
vm6H8tfvO/JJv4u0O+o6FgEnGMaWO7Cj4hVAM0QvMxE07kyqWlYk2M9w4m3xncHg
KFrrmcS7IMTBdNUK1cvU
=jC0u
-----END PGP SIGNATURE-----

--GvznHscUikHnwW2p--
