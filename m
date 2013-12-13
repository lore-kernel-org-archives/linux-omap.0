From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 16/26] ARM: omap4-sdp.dts: add display information
Date: Fri, 13 Dec 2013 12:15:32 +0200
Message-ID: <52AADE44.4030005@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1386160133-24026-17-git-send-email-tomi.valkeinen@ti.com> <52AAD2F1.2040208@ti.com> <52AAD5CE.3010609@ti.com> <52AADA55.20309@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="HjL15iStpTn77viaLBsJ3xWfScOehNFlb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50483 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319Ab3LMKPf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 05:15:35 -0500
In-Reply-To: <52AADA55.20309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

--HjL15iStpTn77viaLBsJ3xWfScOehNFlb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-13 11:58, Archit Taneja wrote:

>>>> +    };
>>>> +
>>>> +    lcd0: display@0 {
>>>> +        compatible =3D "tpo,taal", "panel-dsi-cm";
>>>> +
>>>> +        gpios =3D <&gpio4 6 0>;    /* 102, reset */
>>>> +
>>>> +        lcd0_in: endpoint {
>>>> +            remote-endpoint =3D <&dsi1_out_ep>;
>>>> +        };
>>>> +    };
>>>
>>> Is there a reason why lcd0 and lcd1 are children nodes of dsi1 and ds=
i2
>>> respectively? I don't see this for panels on other boards.
>>
>> Yes. The panels are _controlled_ with DSI. We model the child-parent
>> relationships in DT data based on the control. So an i2c peripheral is=

>> controlled via i2c master, and is thus a child of the i2c master. Same=

>> here. The ports/endpoints are used to define the data path, which is
>> separate thing from the control path.
>>
>> DPI panels which don't have any way to control them (except basic thin=
gs
>> like gpios) are platform devices without any parent.
>>
>> If the DPI panel would be controlled with i2c, it'd be a child of an i=
2c
>> master.
>=20
> Ah, I thought the port/endpoint stuff had something to do with this. I
> forgot about the parent-child relationship for the control path.
>=20
> In that case, for the sake of accuracy, the dsi-cm panel could get the
> "in" parameter via the parent node wherever it's used for control, like=

> setting a DCS command for sleep out. And via
> omapdss_of_find_source_for_first_ep() when it's used to start data
> transfer, even though both the "in's" are finally the same dsi device?

Don't mix the DT data and the current driver =3D). The current driver doe=
s
not handle things properly. The driver still uses the current model,
where we don't have separate control and data path handling. I.e. both
control and data are handled via the single API, using the "in" field.

The important thing with this DT data is that in the future we can
change the driver model, if we so want, to manage data and control
separately. Or maybe add a DSI bus, as has been proposed elsewhere.

It's true that we could change the driver as you describe, but I don't
think it helps anything, as the current model in the driver only has a
single control-data path.

 Tomi



--HjL15iStpTn77viaLBsJ3xWfScOehNFlb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqt5EAAoJEPo9qoy8lh71dYsP/27SlWxY//ccwwoqZtNDjCZd
oaAm+mETvB5hRQrx4Uyx8rqzCrw1ZWiFLUzI8tvpnG1ZlucBjkqSc/y0zIPs6sV3
6xtn/zKk5+/EFQ5lEi4tECvsDeCtyd3tN4yRXK5IRbB3S1/QL++49HaoSbXTlBjN
NZuPqRPw/m9ms0/QkNlCYoVDLfjC+jfALOCMLufZuQEHvqsroXxmmS2RSU0Bke3z
cP5MfUDarkObZp1TJtCDc/9QkXBQFAM6oi2fQuBXB1WZEJQZnO8Gx8GJBrJ9M9w0
wwPk5qnvwVCpM3fvjLKzp1xJsnTuKy7zoGA4CsGzbUWLUi0XE2Q63Zh3zZQwUw8L
ZyXBeRA6zzmAWWMZJYjzPnA9XNl8zPziMmq+/m82qFBvtHnp5CW/etM/UVNA3Q9Q
giHUzWwYdCBSh7Qd/i4ei7HHM3curNzYaEp6vOcwDZ/fNtOgevCXX+5xGBgA4M9v
q7MpNchnDSmqY8a+kQZiSqgQ78loPfV2gsbr6nGog5q2RaLo9GJ1Zauwwgmsf8TM
uBd8CLwtj3Y7hFnt5VkaZTOMSkujrKzMOsRmfP4THPPbr+EAyLYnXBNkSvRtJsLh
0LGpp55SO2l+en9KGILhsnBmVbIr8yrJaNHNrGtdM9WlCuFaksIFigyF1UNTB0P6
E/8faw52jnxeDukBVsUa
=DNjo
-----END PGP SIGNATURE-----

--HjL15iStpTn77viaLBsJ3xWfScOehNFlb--
