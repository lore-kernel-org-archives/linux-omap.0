From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/6] AM43xx & OMAP5 DSS DT changes
Date: Wed, 21 May 2014 18:31:51 +0300
Message-ID: <537CC6E7.6010103@ti.com>
References: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com> <20140521150231.GH17417@atomide.com> <537CC376.5050501@ti.com> <20140521152613.GJ17417@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="PJU0SRQeu2U1loGowfagUugbs6N11vlTa"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55868 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbaEUPcX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2014 11:32:23 -0400
In-Reply-To: <20140521152613.GJ17417@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--PJU0SRQeu2U1loGowfagUugbs6N11vlTa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 21/05/14 18:26, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140521 08:18]:
>> On 21/05/14 18:02, Tony Lindgren wrote:
>>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140521 05:51]:
>>>> Hi,
>>>>
>>>> Here are the AM43xx and OMAP5 display DT changes again. I've sent th=
e clock
>>>> related changes separately, and I removed OMAP5's RFBI node, which d=
epends on
>>>> more clock changes. The RFBI driver doesn't work at the moment anywa=
y, so
>>>> removing the RFBI node should not be an issue.
>>>>
>>>> Tony, if these look fine (the rfbi change is the only one compared t=
o the
>>>> previous versions), can you queue them for 3.16?
>>>
>>> Probably best that you do a late branch again after arm-soc dts chang=
es
>>> have been merged. Sounds like you have at least that macro dependency=

>>> to omap-for-v3.16/dt-v2 so you should probably base your branch on
>>
>> There are no dependencies that I know of. Which macro dependency is th=
at?
>=20
> Oh for the "[PATCH v2] ARM: dts: duovero-parlor: Add HDMI output" that
> now uses the OMAP4_IOPAD macro.

Ok.

But generally, isn't it better if the .dts changes go through your tree?
None of the display related .dts changes have any dependencies to
omapdss as such.

I can collect the patches, as I've done, to let them mature a bit in my
tree, but I'd rather get them merged via your dt branch.

 Tomi



--PJU0SRQeu2U1loGowfagUugbs6N11vlTa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTfMbnAAoJEPo9qoy8lh71ISkP/1nXnnvzj65Htv+JmafHn0X6
ufA7GXJYWrNQRQ3yQ6/c2xHcdzFK5hUI74aqZil6+hEWDeCeCK/wZfeSOjKsHE5Q
T4CJfxCDmGEnH7Jh5ERVhh22s/i1Jkb3Rnh+CybY1Me4MEMefHH7IdiiD4FRLCSY
Dga4dyxXRSIJ5Xmq5LqZgWFeuqqFSrZ7xv1urA0i0GzVmsnBvPYU5J+Ct82oL1mu
Sh2803leeo6Dgmwt4xSfNqb9o4dydT/rAFCzB8I1ib0EPDU2gR4sJy5R7Q+3pYtg
NPRWhabVTJyNMgfwaXSJyTUCq5EaZj6R/K3WLznY9eTI7+VAHG4JlET6EmyaVaOt
ERp0FbLC3bj29V+9LA2W1hV8nkZ/L4nOEPEz34u225ikz8iO0MoFhPg3Z6s1yH+9
r/j1/knH0nrOfRFZKtHNKG9HR84CNT/lUCRDiAfqKaE/n1cZUCJiwQNniXJlgK11
WBoxZsE5kbnOGFaqs97Z+91WByQMN9TI90QW4MYAoBAYLevm5jqhbtOb8O1TGnD9
QY9hMFWq2ADqW4SdHJ/TY2/+YV76MlLphvIRjSbfk/4Y9x00w0sky+dO+6jSU1Cr
34jJfCHOrLoReOOpQtSTut+XEt4BDYDthrsTJZC0Z9vVF39i8gQG2iiLUcBgcHcE
uzHqRpoNqlRXoOKWyvXS
=8z5q
-----END PGP SIGNATURE-----

--PJU0SRQeu2U1loGowfagUugbs6N11vlTa--
