From: Ben Hutchings <ben@decadent.org.uk>
Subject: Build failure with DMA_OMAP=m and a caller built-in
Date: Sun, 06 Jan 2013 05:26:09 +0000
Message-ID: <1357449969.4324.25.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-qVrB+pEIPUyWpn7qVQcR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49038 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750734Ab3AFF0U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Jan 2013 00:26:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kbuild@vger.kernel.org, linux-omap@vger.kernel.org


--=-qVrB+pEIPUyWpn7qVQcR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Various drivers use omap_dma_filter_fn() but don't depend on DMA_OMAP.
This is fine because there is a trivial inline definition in case
DMA_OMAP is disabled... until the caller is built-in and DMA_OMAP=3Dm.

I tried adding the rather weird 'select DMA_OMAP if DMA_OMAP!=3Dn' to
these drivers' kconfig symbols to promote it to built-in if necessary.
This sort of works but kconfig complains about the circular dependency
and it becomes impossible to disable DMA_OMAP in the 'make nconfig'
menu.  So that's not the right thing to do.

Any ideas?

Ben.

--=20
Ben Hutchings
Sturgeon's Law: Ninety percent of everything is crap.

--=-qVrB+pEIPUyWpn7qVQcR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUOkK8ee/yOyVhhEJAQop9A/6AkRZR96GmK9wuyiLAFk6BAUVlVDHsWs1
0H6eH7L400RFpFya/f7N9loGqYzNnaFdTXieO+HwJ/kxuEyE4+xtrsS4mVQeFydT
tEj9NdrxrBa2adxgrWXlyBd6/otCJF2xhtaN6d2PbqocA9tB/Py+DculfyupEB7s
ZLvpN5YUqBPiJ892heKJVhKJd71avWjvPOkFHEgxWDYoEj/3nrUqlsaJneCnk3L7
cAneRxFclR90J1EfKrVfhQ0G+SRkd6xuQ+Ln5oMof8MNoXRGWSw9h8QeXE1rzTDK
akZz5ngPT+ylpTGl5ly/mjL87SrXRbrEf8d+PMCe69U4NIeTlhhpW7Qd38knG3OI
NaGYWTSKoXB5BkEMgnOotVchiU/5ZuSxokZELxbcgr1vimPRyt6fx6lTFZ9VBnW1
/w/97QM20s39y5yesycKv/c5KmnTnnH7cf9+5vpw7J13oTB2uVDKhr5tFQ97HuKK
h8y6BToQZSmJC6UcE9NYL5H+jxNUgNtc0E/Vd4aoj7hlbrzYvb3s97258p55PPCu
HVTDULzQFn143j30sKaZm0S0IbPLN29FLq84OznQtj+L4yMa2oN056CSRpKSHuyV
2wxGvQQKnQpfbamZ7961DHBDCKFzhKDBR60MjbtEC8fgGxSYg7Qj+BDeaNvmT7LW
mFEVeCKgZiM=
=YhF1
-----END PGP SIGNATURE-----

--=-qVrB+pEIPUyWpn7qVQcR--
