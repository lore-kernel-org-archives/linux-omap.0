From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v2] mtd: omap: fix mtd devices not showing up
Date: Wed, 29 Oct 2014 10:34:57 -0300
Message-ID: <5450ED01.4010305@vanguardiasur.com.ar>
References: <1414416749-19598-1-git-send-email-frans.klaver@xsens.com> <1414420445-9020-1-git-send-email-frans.klaver@xsens.com> <544F6611.1000801@ti.com> <20141029113612.GA2499@ci00147.xsens-tech.local> <5450ECC1.10701@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CjTc0FgtvjjXbpPfpA7KqWL1kthhBiuUc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:47963 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932729AbaJ2Ngb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2014 09:36:31 -0400
Received: by mail-wi0-f179.google.com with SMTP id h11so4607074wiw.0
        for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2014 06:36:29 -0700 (PDT)
In-Reply-To: <5450ECC1.10701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Frans Klaver <frans.klaver@xsens.com>
Cc: Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CjTc0FgtvjjXbpPfpA7KqWL1kthhBiuUc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/29/2014 10:33 AM, Roger Quadros wrote:
> On 10/29/2014 01:36 PM, Frans Klaver wrote:
>> On Tue, Oct 28, 2014 at 11:46:57AM +0200, Roger Quadros wrote:
>>> On 10/27/2014 04:34 PM, Frans Klaver wrote:
>>>> Since commit 6d178ef2fd5e ("mtd: nand: Move ELM driver and rename as=

>>>> omap_elm"), I don't have any mtd devices present on my am335x. This
>>>> changes the link order of the omap_elm and omap2 objects, causing th=
em
>>>> to probe in the wrong order.
>>>>
>>>> To fix this, make elm_config defer probing until the omap_elm driver=
 is
>>>> actually loaded.
>>>>
>>>> Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
>>>
>>> Acked-by: Roger Quadros <rogerq@ti.com>
>>
>> Thanks. How about Ezequiel's remark about doing both changes?
>=20
> I don't have any strong feeling for or against it. We shouldn't be depe=
nding on module load order anyways.
>=20

Agreed, feel free to disregard my suggestion.

--=20
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar


--CjTc0FgtvjjXbpPfpA7KqWL1kthhBiuUc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUUO0BAAoJEIOKbhOEIHKiGS8QAI4CJ4duQCRMer7rz1M1V44B
WKW0RI7mXRfvYB1suw1mNTxDt2/uIuqNsRxFoJG2XsB945qDLFVe0k713G05qiLc
hsVCKgS0MaBk9rxxWw4bs6+nhVWn09ri2uFunPhHSxNAyyanDd+6PIzHtlL1XjNk
wv4ZPJlc4gyA55yN8mRMnSXymTUAm9feIISPqoaE174Nlhh4VjmEEyHqBQ1uNKu6
AUwvZiWjnLAkAk2QyGX9nKmC1OJoxj+XvrxcX3pX9VahDcaJx7Fe/vcRR603cNXp
cJKqEau8veRpTP/6xkgModVM4UuNv7IO6msVbHxn4+QxY1UJVUepinbXl+GGpBCR
9LRzPiPEyBPeDmJf/s5YtOekg8UDz6wbuKWRfPlgEutOgSaf0kUCSlpwXN8GIMBM
ze3OwYjOu1auV1MWh5SI0IgTGN+1cbkLokLNz7xGBDbXLiI4xsQDMJLJf52CS//R
xhljCpIefcrUKNQibTRb2VAWRCYd1E1gQBSH+I5d64c792bqmlTGiaRke416K5/j
/xTQ3w6De2+cLE7BfPgFnPv/rvTGmHs2XQ4KWVJcH1ZXbLGzTFHzH7iYFo4KppGB
i/J1Avtx6WiqYJIrfb3WUK8NF8C9UwK9CTq26ISU5AiJg5hSP786n+KK04tQaNdr
KeCiYKrpNvS48D4bp/qZ
=Kg0s
-----END PGP SIGNATURE-----

--CjTc0FgtvjjXbpPfpA7KqWL1kthhBiuUc--
