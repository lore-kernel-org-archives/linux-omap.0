From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PATCH 1/3] i2c: lp5521: remove dead code
Date: Mon, 6 Oct 2008 12:47:22 +0300
Message-ID: <20081006094722.GA23994@intune.research.nokia.com>
References: <1223284291-7675-1-git-send-email-felipe.balbi@nokia.com> <1223284291-7675-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46067 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbYJFJou (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 05:44:50 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m969iOqr031993
	for <linux-omap@vger.kernel.org>; Mon, 6 Oct 2008 12:44:47 +0300
Content-Disposition: inline
In-Reply-To: <1223284291-7675-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Mathias Nyman <mathias.nyman@nokia.com>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2008 at 12:11:29PM +0300, ext Felipe Balbi wrote:
> That LED_CONNECTED_WRONG was never defined so removing.
> If someone needs those hooks, add back via proper
> platform_data instead of nasty ifdefery.
>=20
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Daniel Stone <daniel.stone@nokia.com>

IIRC, LED_CONNECTED_WRONG was only for early hardware builds of the
N810.

Cheers,
Daniel

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjp3qoACgkQ68xJuWtYYdWvRQCfSFulx3N8dWiNxJVxUw8kEuwv
Gx8An3kNzCswJ8iS6gdz8ywAPEExnRRu
=bnBn
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
