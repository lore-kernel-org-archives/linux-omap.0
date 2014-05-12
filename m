From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 5/5] Doc/DT: hdmi-connector: add HPD GPIO documentation
Date: Mon, 12 May 2014 09:30:12 +0300
Message-ID: <53706A74.7050601@ti.com>
References: <1399638727-23254-1-git-send-email-tomi.valkeinen@ti.com> <1399638727-23254-5-git-send-email-tomi.valkeinen@ti.com> <53705DC8.1050903@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Hx7225UnrR0xk0xpK9HGkaa1geXTsKwOU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58481 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803AbaELGaX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 02:30:23 -0400
In-Reply-To: <53705DC8.1050903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org

--Hx7225UnrR0xk0xpK9HGkaa1geXTsKwOU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/05/14 08:36, Archit Taneja wrote:
> Hi,
>=20
> On Friday 09 May 2014 06:02 PM, Tomi Valkeinen wrote:
>> Add binding documentation for HDMI connector's HPD GPIO.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: devicetree@vger.kernel.org
>> ---
>>   Documentation/devicetree/bindings/video/hdmi-connector.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/video/hdmi-connector.txt
>> b/Documentation/devicetree/bindings/video/hdmi-connector.txt
>> index ccccc19e2573..acd5668b1ce1 100644
>> --- a/Documentation/devicetree/bindings/video/hdmi-connector.txt
>> +++ b/Documentation/devicetree/bindings/video/hdmi-connector.txt
>> @@ -7,6 +7,7 @@ Required properties:
>>
>>   Optional properties:
>>   - label: a symbolic name for the connector
>> +- hpd-gpios: HPD GPIO number
>=20
> Would there ever be more than one HPD gpio?

No. HDMI spec specifies that there is one HPD pin in the connector.

 Tomi



--Hx7225UnrR0xk0xpK9HGkaa1geXTsKwOU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTcGp7AAoJEPo9qoy8lh71B6cP/0pyCgw5U1ZHi6rAragZU5C0
VSfrDQwyuo02DE/RqreTuYBlbRxVk5yLL+u8z+AQPRp7UnS6MTIgPCrMmPda2Eey
6NK4p1jzDXxcyai+r9FP8UCcW9O2qGf0i6SZ14/z/Rv1i+e3hSI1HCLw+fqgTy8N
tnS8m8kkQJaJgghVrpdJJCpd7W0BjBCAGD4KuP9QNmM9HcOYKO7tjopPN2YvpMyo
/sDJ9UnEsIwaQGzqwtNbov4XtNc5NICGc6RF54LobeYxQFI8PGlpeLAb841QVKlh
v464Fytp2LG/1Cq/kWtVNNrGlEHHdpcIA5ZL0iPEl+JXQ8XRZaTUoOzClHnhpOxp
dJzO/v9JLbfJ0/iIbX8BiRbXlyS7r4BmwgEMcSi16HtC/ckaaGx6WXH17Wq/IjWl
5H0w8D03wskq7ovPxEc0sF8a56OIzdyxwI+GnFGuVQToLSCQcP59EwMSax/bI1ng
+x5zzhBkrwfqpAKsmImCrfJgdjU2GKpFVmHwVCYdXdDAki/nQu6F0YugPlAxiwwm
GOSSM6iM4sQXtPkc/cif1Bpq75FtrGTzKlXQKh6o2tUcT61SJsWwgf1BOnEqbZ2w
kizZFySWgwCRUZZ6+iFkz7jCsqdXuP53+7HimxymIlPqvpEYbyCVtnMuZHiibOi8
odNm6GbHcnTT+LfbyfDZ
=gbe2
-----END PGP SIGNATURE-----

--Hx7225UnrR0xk0xpK9HGkaa1geXTsKwOU--
