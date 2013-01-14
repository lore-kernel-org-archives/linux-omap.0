From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v2] pwm: pwm-tiehrpwm: Update the clock handling of
 pwm-tiehrpwm driver
Date: Mon, 14 Jan 2013 08:29:23 +0100
Message-ID: <20130114072923.GC21994@avionic-0098.adnet.avionic-design.de>
References: <1357823126-19333-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58531 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab3ANH3a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jan 2013 02:29:30 -0500
Content-Disposition: inline
In-Reply-To: <1357823126-19333-1-git-send-email-avinashphilip@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Avinash <avinashphilip@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, gururaja.hebbar@ti.com


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2013 at 06:35:26PM +0530, Philip Avinash wrote:
> From: "Philip, Avinash" <avinashphilip@ti.com>
>=20
> The clock framework has changed and it's now better to invoke
> clock_prepare_enable() and clk_disable_unprepare() rather than the
> legacy clk_enable() and clk_disable() calls. This patch converts the
> pwm-tiehrpwm driver to the new framework.
>=20
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>

Applied, thanks.

Thierry

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ87PTAAoJEN0jrNd/PrOhTwkQAKQUUxrSevZhSjjlucnt5nCp
foOxd3GYph8sBR7Vlm9wJ1N+YHFNVAVj2lxGbhg4QCJFfG5k9m03eRNz6x11OByW
lBqK8OhsN2iU9QEpQxj+ptxwwRrL3tjYb8JhjDD7NghQLeQJ3ODLx/WSsNG8Eklr
LRWJ8jaLN6/U3Vy2n3ZB27zKIr4mEoANPmaupChgmkFcwKR7sFMVPbob1pyNSS59
4qXCsXpFea7B22NKAC8IR0n9eZeiTnaQFbS31gUfSFFleYezTKp59tPwsRSs3/8j
KbzugMnVRQ9vujY51CMmEqcTn5s90xOKz9qdRYe3XLSzWgIZSwpW9ahceOivvdlZ
sT1bBnr7zP36gMkCmiYetzXmqj3tvhaz9MFMLb9wDhlDqgImscgdkgQER6g0ktWi
ePzDAY4JjOMuXletGdDhMRQtbF6SgH8NHLW1Qrfmd7Z9l11ExIh8fhC1RTigqcKY
JK4lma6oRTpZRKquWx+Ic9rYcgJFQ8o7nWSicIrX37t1t3Wu4ORNeILqYgJma4tP
u706mrvLD/ReXxe4nBdI3PfbwzLzAaVD5+iL1NhuwJ77PGIpQQg/ESvpjXj/ET83
UOhfSvrXBxgrUUo+7HX1ARgyrossJk/mdjXKM1KfJ7Q6DqlLvhUKarMxHADqdUbv
NJx7bV7Bt4IGsn6qaNOL
=iAs9
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
