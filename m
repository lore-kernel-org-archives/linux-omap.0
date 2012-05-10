From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omapfb-main.c: check result of simple_strtoul
Date: Thu, 10 May 2012 11:23:14 +0300
Message-ID: <1336638194.5182.28.camel@deskari>
References: <4FAA838A.3040106@yahoo.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-DAtSn24HeZjDhZwvrhIN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:55267 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757013Ab2EJIXU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 04:23:20 -0400
Received: by lbol5 with SMTP id l5so885881lbo.6
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 01:23:17 -0700 (PDT)
In-Reply-To: <4FAA838A.3040106@yahoo.es>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hein Tibosch <hein_tibosch@yahoo.es>
Cc: linux-omap <linux-omap@vger.kernel.org>


--=-DAtSn24HeZjDhZwvrhIN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-09 at 22:47 +0800, Hein Tibosch wrote:
> Tomi,
>=20
>=20
> In drivers/video/omap2/omapfb/omapfb-main.c:
>=20
>  static int omapfb_parse_vram_param(const char *param, int max_entries,
>  		unsigned long *sizes, unsigned long *paddrs)
>  {
>  	int fbnum;
>  	unsigned long size;
>  	unsigned long paddr =3D 0;
>  	char *p, *start;
>   	start =3D (char *)param;
>  	while (1) {
>  		p =3D start;
>   		fbnum =3D simple_strtoul(p, &p, 10);
> -		if (p =3D=3D param)
> +		if (p =3D=3D start)
>=20
> correct?

Yes, looks like a correct fix. I'll cook up a patch.

How did you encounter the bug? What was the outcome?

 Tomi


--=-DAtSn24HeZjDhZwvrhIN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPq3ryAAoJEPo9qoy8lh71eewP/3R3Cz6rXoiARgjPhdPJOjY0
sfB7pw/+fPxEMFzFnnYL3ZEiKL3wVokypXrzVMt6aUEK8DX65bXI004x9xJL/ZqJ
isEFZGtqBTLhCBt6XxSp+ZxHF/hpSRRMuQlbjv7Kr/hmFSi0OdUnaqBN8ykL2idx
Oibt7mKBVhKIP+m3LMg7+PG/EcXTFToUSWR+pdJMbRihOJYjMJGBqWXO97RSqlne
sxGLuTi9gzMhLS2gaM4ABS2Xnzzyr3SCFr1F7kb32LNFHvq6QVJaKom1HTNHrq0A
URYMFUlOTMA5aBE+51PVTC5q83xaObdv4GcliM7dPXAExOzlWvFa2LEbIrns3zsc
HVKrts81VDaNqSr4VT/gJ4OPmi7RxNYFUEbfdN9DZHJb4ZSNfdZdjqOKiNf7O7EM
OOGCQe705Va/ZJNbzqCtVWCin22oPUnMOAg6MRP26juJSB/6VOEtRfEPiucj9W+H
UfaDsna4enNK26ODcxHT5CvVrK2Zf/hZq5nXo/pdtktjroFyqTTvQElha9zGhcKY
tgtanC4JFTOsh/s/ONUqDa8gt1Zn92bwFhVLy4ZLm+SjHYzcHEOXpW9xYmqunUA7
ASg+pOLe9ivVaC6yN3/c/oyDGOGL199Eb4NpgpZpRDjdMneC8d1UkMKd2TI5WklK
41orPKnlwIIwTfVknXgR
=T2A/
-----END PGP SIGNATURE-----

--=-DAtSn24HeZjDhZwvrhIN--

