From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 7/7] ARM: OMAP2+: Mark omap_hsmmc_init and omap_mux
 related functions as __init
Date: Mon, 19 Mar 2012 11:08:36 +0200
Message-ID: <1332148116.2144.1.camel@deskari>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com>
	 <1329997247-27342-8-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-JZDFNNkHk1vse4rI4R9/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:53837 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754726Ab2CSJIq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 05:08:46 -0400
Received: by mail-lpp01m010-f54.google.com with SMTP id v3so6342225lag.13
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 02:08:40 -0700 (PDT)
In-Reply-To: <1329997247-27342-8-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>


--=-JZDFNNkHk1vse4rI4R9/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2012-02-23 at 17:10 +0530, Rajendra Nayak wrote:
> From: Tony Lindgren <tony@atomide.com>
>=20
> Now that omap hsmmc init is split into two functions, it's safe
> to mark omap_hsmmc_init and omap_mux related functions to __init.
>=20
> This basically reverts the following fixes for the case where
> TWL was compiled as a module:
>=20
> a98f77b (ARM: omap: fix section mismatch warning for sdp3430_twl_gpio_set=
up())
> 8930b4e (ARM: omap: fix section mismatch warnings in mux.c caused by hsmm=
c.c)
>=20
> Additionally it fixes up the remaining section warnings for
> all callers of omap_mux functions.

I only now noticed this patch. This breaks DSI, as the DSI muxing
functions are used during runtime and cannot be marked as __init.

Shall I make a new patch for dss tree that fixes this?

 Tomi


--=-JZDFNNkHk1vse4rI4R9/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPZveQAAoJEPo9qoy8lh71rVQP/RRTzwiaqplMpTFZdvLtHcnl
r5/5gyN0a9C+yIO6CEwO0oleXwNJt643tJX4d8L0biioO1+/UcvjEqvP1rvwoWdI
bRxbIR1S+WaUqecOvqMViU8l6/TYVghxq5b+lSUplDwWf6Vh/P+fYLo2v7rIIrYD
JYhhwinQKZ5iu98om6tbGI3F6dQLtg0fThjBwVATw1lOidi+MWz3GqVPBV9JNDv4
ORnwIm4WshJpSu8YAbpvsXN7X307qdQTpvy50qcbSpUuhRs+2bDhjUJ/NS6Qsfec
r8dSulhYD0RfrEjrSh1gbStOZjhGs4zd+8hoVK7r5BZnVjX9AWYuMzQ8FW153Zr4
sFY11Q3kw9Rl9YhVxXtySurGwK+cWt21boQscWN8ud7mYyqZB80f3DLrOupQ90XC
ZxKRmelhmL92rPRwmXegRytEP5ljqmsvlDWAS5Ds9ExgmT1oCt9DTWp4pbdg/ED2
+EZV+QpM3g49meSk3Nk3dkOK0UiW/76RVzXIlzS+9rDxKIGYTgnQ++LSCeqSQYRi
yJ1LPQBypgO1hW2Reip27PgWXlgoz/U1Etr9CUj6u61Rr7CplqZ18a9kL4f+PLfX
3mt1pfxSpJ+waYv1qS05riAmq0+y9vgxtJqrSJfzEfhKtz8aVMdzi9kHlFD1JtLS
ZiHvMjSLyuz8yCtp2nlF
=OrhA
-----END PGP SIGNATURE-----

--=-JZDFNNkHk1vse4rI4R9/--

