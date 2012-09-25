From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 16/18] OMAPDSS: DISPC: Configure writeback FIFOs
Date: Tue, 25 Sep 2012 17:50:52 +0300
Message-ID: <1348584652.21717.7.camel@lappyti>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
	 <1348553993-8083-1-git-send-email-archit@ti.com>
	 <1348553993-8083-17-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-/BG6wGrE22j7iPzsUcJQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:48727 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752676Ab2IYOu6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 10:50:58 -0400
Received: by lbon3 with SMTP id n3so241331lbo.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Sep 2012 07:50:55 -0700 (PDT)
In-Reply-To: <1348553993-8083-17-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-/BG6wGrE22j7iPzsUcJQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-09-25 at 11:49 +0530, Archit Taneja wrote:
> Extend the DISPC fifo functions to also configure the writeback FIFO thre=
sholds.
>=20
> The most optimal configuration for writeback is to push out data to the
> interconnect the moment writeback pushes enough pixels in the FIFO to for=
m a
> burst. This reduces the chance of writeback overflowing it's FIFO.

Hmm, why is this optimal?

The FIFO for WB is the output fifo, right? In mem-to-mem mode the whole
WB pipeline can stall, so the fifo can't overflow? If so, isn't it
better to collect more data and flush all that to the memory, instead of
sending each burst-size piece one by one?

Then again, if the input side is reading pixels from the memory all the
time, even if the output fifo helps to keep the output side idle for
longer periods, it probably doesn't help as the input side keeps the
memory bus awake.

 Tomi


--=-/BG6wGrE22j7iPzsUcJQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQYcTMAAoJEPo9qoy8lh712kkP/3OovpBy+so/ua3DOFGofrsP
sb+g+SHl/kjLx72yFmhD3ENptxjovmbPFK5Hk16kA0K/krlwgKvQWTf3vyThkHZu
Hb2Dv8IPqtK9Wk5nh8DsRGlINt1qAREXqXbFFfiS4TcOrywKYFDchqpqk7IsSI+z
jqSUt1o0nun/UQzc9fgC47RmfOBTw9McPQI86Q7CYJPWiGyLYN2in588Pl2hdq/T
hYbLgkSwA4Ae4qPHMnjxwInOo1SH8TrSE9dTHOL3j2WsuAuQHDOnA/rxnmgv+ACs
TtZwyVuplv8/6FS/XAvaTFmGPAcTZ7oQ7+QY2MZ8Q76U3jHVQHA3jHRigDmxqsBB
AglitTLjMmtC6EmMYCgKoi9+F/b6zuUfLtp7PGWveTF49rfg0764dWyWfGHw/auI
+15Jx9GDiaeaZphBCQRVAqfVuiCSKSn3HJfW1w3xtKhBoB1ObexjA4qazuGhQ6uI
ubXiNLA4NuEz4nw6wKxynYRgGCEE0CdyjnjCslKnuHyePuikUXLOTxs4U8Ka40JR
Vku9H8RmzMmdGd9ytYupoaJ8l6dLWljrKqng5TfIx3R4pYRZOPMOJjbIhcEQJV6U
DxjvAYIfpXRjN/s5ygIfW7C+oSU7xTvx1Dfa/CyZNRZUWt9FAl5nZRLXEOyxzbhB
NlC0ZCGsGYdOHNS+SMiC
=lqOm
-----END PGP SIGNATURE-----

--=-/BG6wGrE22j7iPzsUcJQ--

