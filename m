From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 13/17] Revert "OMAPDSS: APPLY: add fifo-merge support"
Date: Thu, 06 Sep 2012 15:55:42 +0300
Message-ID: <1346936142.2737.55.camel@deskari>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
	 <1346833555-31258-14-git-send-email-tomi.valkeinen@ti.com>
	 <5047570D.1030601@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-+KY5Zb2x+aJ9AepnGnZV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:39744 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755373Ab2IFMzs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 08:55:48 -0400
Received: by lagy9 with SMTP id y9so1066829lag.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 05:55:46 -0700 (PDT)
In-Reply-To: <5047570D.1030601@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-+KY5Zb2x+aJ9AepnGnZV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-09-05 at 19:13 +0530, Archit Taneja wrote:
> On Wednesday 05 September 2012 01:55 PM, Tomi Valkeinen wrote:
> > This reverts commit 1d71f42b35ed66d90a9a39bc515bb16cfe2d4a46.
> >
> > Adding fifo merge feature as an omapdss internal configuration was a
> > mistake. We cannot hide from the users of omapdss the complexities of
> > fifo merge.
> >
> > This commit removes the fifo merge support, which luckily is easily don=
e
> > as it was handled totally inside apply.c.
> >
> > The plan is to try fifo merge again later when it is more clear how the
> > hardware acts in various situations, and how the omapdrm wants to use
> > fifo merge.
>=20
> Nitpick: This isn't an exact revert right? Maybe we should mention that,=
=20
> so that if someone tries to apply the old patch, it doesn't fail.

Yep, I added a note.

 Tomi


--=-+KY5Zb2x+aJ9AepnGnZV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQSJ1OAAoJEPo9qoy8lh71SF0P/0uopqVA0uuEDmp2wxCcj+ak
KAVbAy5vq9Y0GOyHRtWtvszN7i7FC1yHFRmhSisFPfy0SGuEGhXXtoO8ckNAba8p
k7F4Z2ltJyyVGJ2bJeCd7nqHzS3P1K8l1gL/KJEKQxdB0t30WnFOWvNv6+BYi2OZ
Go05XV7ieHcPkXhjJrYyaWVxLjChVfiScML8Wxlne1KhP7NCRPsK4gmYoNvr/ead
/3BlOZSb68Njwdu+fnPHbnfK206n8W3+pzS3tVT/pbEY85bIlOFSYDu9p4xg9enN
P1FnZlN0YZ8qOrzUwC8ZotnPkvak2lkLgsgM3H+R4IB1CFfXT9uEYUFRT5kqHfFK
FccDRnG73mdQc1jeWHsrIHW/K2gH1+qZQMonEWMjQ0E+OrBB1FO7cuRQE+UPnDrg
/F+m2gAyHXUNjmqfPdY2aUsSW6yjmkwvr+UbDu2BaMr/+IpsYQx6c4J1Lh8UmkDz
h4qTwHY8CMnRtJoFCRFBsuoIY0EfktHChCQ7EZ8av77Ivo5MtKvVabfLuH/MrBge
YtEFKfk8Dkl8CvoTlBzz4W9K9u7h7LofBK1DsV4WoNfacbNVMFDRc5iox+r+Dhz/
0Djj7Au+sOqsaXpXNCH1YzHBoF+xmak1Uaf8tdEjC5nCEEhrLr1nr/yRmeysticd
DQ0RvGm/iABM3TtJFsKR
=KQ9r
-----END PGP SIGNATURE-----

--=-+KY5Zb2x+aJ9AepnGnZV--

