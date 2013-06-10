From: Tomi Valkeinen <tomi.valkeinen@iki.fi>
Subject: Re: [PATCH V2 14/14] ARM: OMAP4: hwmod data: Clean up the data file
Date: Mon, 10 Jun 2013 13:38:30 +0300
Message-ID: <51B5ACA6.2010101@iki.fi>
References: <1370606175-22599-1-git-send-email-r.sricharan@ti.com> <alpine.DEB.2.02.1306071230500.5589@utopia.booyaka.com> <20130607162927.GA3331@atomide.com> <20130607175005.GB3331@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2MSDESSBTTAQTIBFIOSPP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:52310 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab3FJKif (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 06:38:35 -0400
Received: by mail-la0-f52.google.com with SMTP id fo12so3613006lab.25
        for <linux-omap@vger.kernel.org>; Mon, 10 Jun 2013 03:38:33 -0700 (PDT)
In-Reply-To: <20130607175005.GB3331@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, rnayak@ti.com, b-cousson@ti.com, t-kristo@ti.com, ambresh@ti.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2MSDESSBTTAQTIBFIOSPP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/06/13 20:50, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [130607 09:35]:
>> * Paul Walmsley <paul@pwsan.com> [130607 05:38]:
>>> On Fri, 7 Jun 2013, Sricharan R wrote:
>>>
>>>> - The IO resource information like dma request lines, irq number and=

>>>>   ocp address space can be populated via dt blob. So such data is st=
ripped
>>>>   from OMAP4 SOC hwmod data file.
>>>>
>>>> - The devices which are still missing the device tree bindings,
>>>>   address space entries are not removed yet. When such devices add
>>>>   the dt bindings, respective address space data can be deleted.
>>>>
>>>> - Also other unnecessary hwmods like firewalls are removed as a part=
 of this.
>>>>   Since emif was getting registered only because of this firewalls l=
inks,
>>>>   the mpu->emif direct link is added now.
>>>>
>>>> The above update, results in reduction of about ~1650 lines of code.=

>>>>
>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> Signed-off-by: Sricharan R <r.sricharan@ti.com>
>>>
>>> Acked-by: Paul Walmsley <paul@pwsan.com>
>>>
>>> Can't test this one since I don't have an OMAP4 DT config set up in t=
he testbed
>>> yet.  Maybe will add that to the testbed after the v3.10 release.
>>
>> OK thanks, applying into omap-for-v3.11/cleanup.
>=20
> I had to undo the following parts to avoid regressions on omap4sdp.
> Can you please follow up on fixing the related issues so the fixup
> won't be needed?
>=20
> Seems to work now the same way as earlier for both omap4sdp and blaze
> es, except for DSS, which seems to be a separate issue as posted by
> Tomi. Pushed out now to omap-for-v3.11/cleanup.

What issue do you refer to?

DSS does not have DT bindings, and removing DSS from hwmod data will
break DSS for omap4.

 Tomi



------enig2MSDESSBTTAQTIBFIOSPP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRtaymAAoJEPo9qoy8lh71wKAP/3x9L94lk6Axn0yl4JWAoBpC
MpQuBFB62wOSve5tpvtQtO902T5bmUwZOb8yeBnsxS+nzv2N8Juml0rxgT1xbPyd
POTMKs48bsYfhOB3lHjR32qnCA75YfxCe/FmDxhNbsBm5LnGGSVjFyLSOIj/5Iwb
coi+DgvKk16V/iwaWtBhHWZIVTS0oYRyuA00z/JCGHaHw+HKCWxlGqo63qEaZQqq
iJR5n19zYZezeJbQSN0gRc7PXrRlICHL7kEqtkoDdCj4EX1lNEg8iL24+dT9HSbm
i+OgzWYkS4UxQ45qJLPHIAbVOHVUdSDtRH/fT2YTpLXqMTuqjmfgZDa7zM3rV3Nl
I9duknmJsHo9QpDuSaoKnzy5QD7TxdEhANnwW9hf+6ZJuhbHQNzedWdIAtelEBnP
mgwLjnWqXX/Sdgrdhm71mwgUXGpe1li3u/4ahD6bMvuhOYtm7ZWBop4tz26zonOD
t+X2tjKYjZQBJrpMCYFiwBkqozjWjfJf5hqGiY0LMsM1AryJfCA8w6eXjjvQqYZn
vZXmdP8Cf1ImMWBlnSCtDFVpLxWa7ShNh3LF9UqqPj3axwpkR8hseZVn2KCrDihv
QEkFb1WDjOgjQKClL19/SfT42mUVNPpkO5MMbIVfBnBw/jl8PwuI7TKUUgCfsbw8
9+KBkpKqyA49nZgNWyIm
=rOjD
-----END PGP SIGNATURE-----

------enig2MSDESSBTTAQTIBFIOSPP--
