From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: Remove cpu_is_xxxx checks
Date: Tue, 07 Aug 2012 16:00:56 +0300
Message-ID: <1344344456.7216.59.camel@lappyti>
References: <cover.1343912532.git.cmahapatra@ti.com>
	  <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
	 <1344336723.7216.44.camel@lappyti> <502108A3.9060903@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-7WVbOYoUtuc5zJj001vG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:50495 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752630Ab2HGNBC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 09:01:02 -0400
Received: by lbbgf7 with SMTP id gf7so1617573lbb.22
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 06:00:59 -0700 (PDT)
In-Reply-To: <502108A3.9060903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-7WVbOYoUtuc5zJj001vG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-07 at 17:52 +0530, Chandrabhanu Mahapatra wrote:

> Yes, this seems good to me. Its better to have all cpu_is checks of
> dispc.c and dss.c in their probe functions and by the time
> implementation of DSS version come to picture these can be move to dss
> features or any other place appropriate. But how to handle OMAP revision
> specific functions. Will Dss version handle that too, as like DSS1,
> DSS1.1, DSS1.1.1, DSS2 say?

Yes, something like that.

I'm not sure how the version numbers should be created, though. If we
had only OMAP, we could use the OMAP version as the DSS major version,
and increasing minor version whenever the DSS is changed. So DSS3.2
could be the DSS used on OMAP3 SoCs, and it's the second revision,
meaning that early OMAP3 versions would have had an different DSS
version.

However, the same DSS is used for other SoCs also, so the versioning is
not that simple. I guess the other SoCs still always use a DSS that is
designed for OMAP, so the major version would be solved by that. For
example, AM3xxx DSS version would be DSS3.x. Minor version is more
tricky, because OMAP and AM3 DSS can evolve separately, which means that
a higher minor version may not contain the fix that exists in a lower
minor version.

Well, at least currently the AM3xxx's DSS is almost the same as OMAP3's,
so perhaps I'm worrying too much.

 Tomi


--=-7WVbOYoUtuc5zJj001vG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQIRGIAAoJEPo9qoy8lh71qPUP/1cBNfEDppV7F0yHhqjDOU5b
RNDMw+H93D13gUO6M887Tg+ik9osqSYyvpgcJtekvFwcEA10MdkyzkSzBw+PdFwo
GmRdZF5e45geRmsBvXcNIGxzs8jhwS/k31qppSiEuSVbwR/WEAnQJ+pNIjyZKAMl
tX1PG768AbBcIid50+aTWsqiBbU1xQdeg9+jhZ9Lz6XBJX0NEps9n6S7DNe9+j1c
EfFAuRfyciVuvuieBMCJQa30VGyDhv75weslMTtEpd32b3R18rWSOhsX3m069iUP
VtG097V+vOsmiopVmXNBhb0f7Wapjnu4Et6k7BKCgSJ+FhgXHl6mwVIqypipj0f2
JKUsPrknkFekHANyZ1ZPiuwXD+/T51BjF+3KIIthclhSC7XBbndrnHCbC2Zx3E6W
RHWmOuF91BYkvBp8fgZT4YrTQQ9YNjNV3Cjl8UAjeqVLD42GTMZ4Xfq2jwMQW4jH
Nc4TAnxMFZqim8dqsZl0/+sMWPxW00iYTYMNpwh73HmeLN2lut+RIlRxKka8npUx
qQMQOK6vORYy7uTG5B7Uu/ggUT/WgI25fmnVozt+iv2dNktnvQmRxgZ3sZ3qzM2x
Y8hkn+OV5Q4IexA9icJbMAMzRZ4DwPn+jXOk6bPnn9F0iFyKXeFq2x8gh7uEHZTr
CW1omFb9QRuWJyPSRr67
=MaAm
-----END PGP SIGNATURE-----

--=-7WVbOYoUtuc5zJj001vG--

