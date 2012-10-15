From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [GIT PULL] OMAP-GPMC related cleanup for common zImage
Date: Mon, 15 Oct 2012 16:55:39 +0300
Message-ID: <1350309339.5769.10.camel@sauron.fi.intel.com>
References: <1350303247-13495-1-git-send-email-afzal@ti.com>
	 <1350304405-14762-1-git-send-email-afzal@ti.com>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-IrINF4GWNf40jg5LZpL2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19232 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073Ab2JONz0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Oct 2012 09:55:26 -0400
In-Reply-To: <1350304405-14762-1-git-send-email-afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, David Woodhouse <David.Woodhouse@intel.com>, Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--=-IrINF4GWNf40jg5LZpL2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-10-15 at 18:03 +0530, Afzal Mohammed wrote:
> The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd=
37:
>=20
>   Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)
>=20
> are available in the git repository at:
>=20
>   git://gitorious.org/x0148406-public/linux-kernel.git tags/gpmc-czimage

FWIW, the mtd changes look OK, and this stuff is very OMAP-specific, so
merging everything through the OMAP tree makes a lot of sense. Thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-IrINF4GWNf40jg5LZpL2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQfBXbAAoJECmIfjd9wqK0+p4QAK2XQhXJOYgJPlcd71ZfUZLn
vVSzBvHCH6AvqpLu11xxs1wHih9SokzBei9mUO6Cvoqk+0qPmuv0tFDBMfqcFxQh
igTg4r8+TOe3RFTslA5JitpMmPuoQrWWoGi/gDziJtQIX/geG6JLhKQuuU7BuGOq
umhmEj4OY6oMfe+X0ddEp4hzOLfvr68zyiMG9Ke067nig/hdleDgZ4HR/q2BdHA9
eenqHG2mc6nYVt18E+N9EKPt+TOEMVZTcp6PO47128A4srOKibvZfWDhDYZISp6f
BuzHzIvpMa5FFWerTdrzTV+Di1lOEWmTH7dQfzc5f4UDOMa4xO4p7k2eInUvid/H
U4FnUL67GydaXxH2TEYJMi1Q2KUuff31sgXS+GpZew4tHG3f6enRm3I46TJuPVmx
T73DBaonvoZ93WEs+00TGWYYiUpmlCoMqIcobKKw4UKb+7UfLtNIuPo97noe3s6t
J8dIkOz9GuOzuB+P29/QfnzAOnfugaDyHmmpCL8nixg4Ua0nNCnd7iaszBdR/RMu
PlNE+BuCIFhvAuxSyIC8x0U2vwVH83zHl9MQNFM1Bik9kdIe7n9hrBVaA4M7yv01
iH1yKNtooYlzOP38dG2Ye4cgB9edBmddnL0w47QITDwoKX+y+L+eQufrM6NEu8QO
DfzUQvxOcTk90EJKTAZw
=Uz3j
-----END PGP SIGNATURE-----

--=-IrINF4GWNf40jg5LZpL2--

