From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 9/9] RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN
Date: Fri, 20 Feb 2015 15:48:13 +0200
Message-ID: <54E73B1D.3050908@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>	<1423840286-18377-10-git-send-email-tomi.valkeinen@ti.com> <CAGo_u6p89ot-eNwK65otoYsLM6NXeh929=SBG6uKAsX8Tnd_RQ@mail.gmail.com> <54DE1B7E.10505@ti.com> <54E71EA2.3030803@ti.com> <54E72FB0.6000604@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="H4rbfIEdtUOjWFfljn1hTrR4QP67S9iDb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35474 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753893AbbBTNsp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Feb 2015 08:48:45 -0500
In-Reply-To: <54E72FB0.6000604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

--H4rbfIEdtUOjWFfljn1hTrR4QP67S9iDb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/02/15 14:59, Tero Kristo wrote:
> On 02/20/2015 01:46 PM, Tomi Valkeinen wrote:
>> On 13/02/15 17:42, Tero Kristo wrote:
>>> On 02/13/2015 05:25 PM, Nishanth Menon wrote:
>>
>>>> I would probably wait for control module to become syscon and probab=
ly
>>>> model this as syscon clk - I thin we should be seeing a series
>>>> sometime soon.
>>>
>>> Yeah, I will be posting a series in a bit, just running some final te=
sts
>>> on it.
>>
>> I did the above with Tero's series. Adding the DES HDCP clock works ok=
=2E
>>
>> However, I'm not able to do this in HWMOD framework. To enable the DSS=

>> IP block I need to enable both the DSS func clock and the DES HDCP
>> clock, but the HWMOD framework only allows one mainclock.
>>
>> I added the HDCP clock as an opt clock, but those are not enabled
>> intially by the HWMOD framework, and the call in omap_hwmod.c:_enable(=
)
>> to soc_ops.wait_target_ready(oh) calls fails.
>>
>> So... Any ideas how to proceed?
>=20
> Add the clock enable at the end of dra7xx_dt_clk_init()?
>=20
> You need to disable the clock at some point though.

Where would I disable it? And if the clock is disabled, doesn't this
again fail when the dss driver tries to enable the IP block? The driver
can enable the HDCP opt clock only later, when the IP block should be up
already.

 Tomi



--H4rbfIEdtUOjWFfljn1hTrR4QP67S9iDb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5zsdAAoJEPo9qoy8lh71acwP/3NV7Fx+b8hDdJnayag6+/JK
4MhrKJ6DZbLbL1sJA+O+fYTsF07Y6d8NXElhwMCWpIbq7ANGjIYrA+HS7NKc/ETD
ckbwagHfKVvVzhR8CsYp+PEf6FG76NRPdeIcZXfd9vScQIcdH22d/0BXaiZj5RZr
bcr7ObbxCiMP7JmMCmDj/JgTVEcZ8g+86dXhC9ZochZ9SsirbqnfHzA61hzJy2Q3
xDJkSh0xiwQvrCf6BjaY3PPheqAxc4ivZftIeZUyprrWzF54wDTI4lja6oAu63Ud
iJ3iFi+FuiKHGgeOaODZOU2WU4cX210bQE6NqyQZhvSAGbFXvSHkiv2ea5AnhhKt
NH79SSrr/cIC7dKm8JHKktpfKNRSTZttebpmG9NRb9VhT5bozCwiqJ/NFqTIH7te
NvGXdTkLaJ1o3Z9q4wxytJnNOarEjgOUTTk6ho4U+YY2PsEaaf52tBqZdNdWlxT0
TlLM4Qv6E/HP4oUKrr368DFz7aEEGiPi8kBpwKLuTfcbR6oMhCgPG2QRFLWcFq+a
KTWAk6yOVhPnHnZKq3BX7tv0oDSWX85NUI/m784a+BSve3OZ0DxUy2QHJY0260N1
9cztbwPu8zdtQRiFr3MwjN2fVq4vcreB/khKrNUle00qeati2UrI7S0VrzCDUhNo
gWy9o0DYN/pwzk3TRo4F
=E18O
-----END PGP SIGNATURE-----

--H4rbfIEdtUOjWFfljn1hTrR4QP67S9iDb--
