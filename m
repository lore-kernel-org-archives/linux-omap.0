From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
Date: Tue, 26 Jun 2012 09:55:58 +0300
Message-ID: <1340693758.2093.15.camel@lappyti>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
				 <1340372890-10091-6-git-send-email-rnayak@ti.com>
			 <1340604478.12683.25.camel@lappyti> <4FE80C43.6090802@ti.com>
		 <1340611133.3395.3.camel@deskari> <4FE85005.4090303@ti.com>
	 <1340630090.3395.85.camel@deskari> <4FE941EA.7050108@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-hVIkG6Fe6B+b2+pjsveK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:40897 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751553Ab2FZG4F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 02:56:05 -0400
Received: by lbom4 with SMTP id m4so202134lbo.2
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 23:56:02 -0700 (PDT)
In-Reply-To: <4FE941EA.7050108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org


--=-hVIkG6Fe6B+b2+pjsveK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-06-26 at 10:30 +0530, Rajendra Nayak wrote:

> > So as far as I see, clocks are never handled in atomic context. Is
> > everything related to the base clk stuff already in mainline? Can I tak=
e
> > the clk_prepare/unprepare patch into my omapdss tree?
>=20
> Well the Common Clk framework is already in mainline, but we still don;t
> have CONFIG_COMMON_CLK enabled for our builds yet. So until we do so,
> clk_prepare/unprepare will just be stubs which do nothing.

But if I understood correctly, clk_prepare and clk_unprepare are anyway
no-ops with dss clocks, even when CONFIG_COMMON_CLK is enabled?

My point was only to understand if I can safely take the patch into
omapdss tree, instead of it going through l-o, to avoid any possible
conflicts.

 Tomi


--=-hVIkG6Fe6B+b2+pjsveK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIbBAABAgAGBQJP6Vz+AAoJEPo9qoy8lh71LVkP+MDDHCgE0zi/a+l2x9LvZf7R
42uzSpJN6iEsS8D5+fL/wKC9ealGbrcIbYKA41okd1vhX3HpZ+UDLG67eRNYmhzL
tztxj+EPWBN4YUM+klnWr9/wV0A+jni+g9ttKqqvCE4GCxJuZimTQ2Wfr3k1gbvD
YTb8l1tRPMGAXphFXKvqv4Pr8wu04ag7julo7s1JPIDGcA+2PngvTQAGoh2g/Sbs
/5ExktYh+MJexTjuKtVXvCf29t+f7jRxYZtKn/jUXTN1ZQjLBiVuy4FyiMqjYGst
O+2LROOztFUAv3sPJYoajMX06xo0iNMSginKNWtDDvMN1HOgDm4fI7SDBOxLCo0n
VF1EHDQWNeFEqnX0381C1aUt5CTBWTqfmJzKkQwew6YNJYVxELX+UhvMahVJJQ23
aMUNmGouBzeAgs4Kfsao4PWzkZXoNfnqpS5KJDtZLWo/MaqipPFIZQXCjF2ZX2GX
mNb3uYXfgUWSP3vS7yOWeLH4AflggFKATuUWPjUW6rlpZIxRoLFQI2yByMxU+XAx
QrCLL3V8w2OeXAoJA79RgaRx72dmLsHQFN/Y/ZTX58QbeKRcc+xibiqM4kgQqwe0
F+jayXLOWqnRkbee6r7+EmQj3B5zQwKgiKKevQ3naddUz/OK51t64zwVAWmV5Ygr
M2PgiMUNyWe7V5FQV+U=
=rQVC
-----END PGP SIGNATURE-----

--=-hVIkG6Fe6B+b2+pjsveK--

