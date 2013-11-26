From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 00/11]: add remaining support for IGEP boards
Date: Tue, 26 Nov 2013 13:18:49 +0200
Message-ID: <52948399.7070407@ti.com>
References: <1384909575-19108-1-git-send-email-javier.martinez@collabora.co.uk> <CABxcv=k+Lk=PFONKLvXab5iHExG7WCJRfE6BzEkv_YtPVwB8Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Sl51BJ9T5CScjE0a8NCfJIs7bRKRWivQ8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53662 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756206Ab3KZLTq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 06:19:46 -0500
In-Reply-To: <CABxcv=k+Lk=PFONKLvXab5iHExG7WCJRfE6BzEkv_YtPVwB8Dw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Sebastian Reichel <sre@ring0.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--Sl51BJ9T5CScjE0a8NCfJIs7bRKRWivQ8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-11-25 17:30, Javier Martinez Canillas wrote:
> On Wed, Nov 20, 2013 at 2:06 AM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>> In order to make mach-omap2 Device Tree only, the board file for
>> IGEP boards was removed even when support for wifi and display
>> was still not supported by its DTS.
>>
>> This is a second version of a patch-set that adds support for
>> these remaining peripherals and also adds support for USB,
>> HDMI and user LED for the am33xx SoC based IGEP Aquila board.
>>
>> The patch-set is composed of the following patches:
>>
>> Enric Balletbo i Serra (7):
>>       ARM: dts: omap3-igep: Fix bus-width for mmc1.
>>       ARM: dts: omap3-igep: Add support for LBEE1USJYC WiFi connected =
to SDIO.
>>       ARM: dts: omap3-igep: Update to use the TI AM/DM37x processor.
>>       ARM: dts: AM33XX BASE0033: add pinmux and hdmi node to enable di=
splay
>>       ARM: dts: AM33XX BASE0033: add pinmux and user led support.
>>       ARM: dts: AM33XX BASE0033: add 32KBit EEPROM support.
>>       ARM: dts: AM33XX IGEP0033: add USB support.
>>
>> Javier Martinez Canillas (4):
>>       ARM: dts: omap3-igep0020: Add pinmux setup for i2c devices
>>       ARM: dts: omap3-igep0020: Add pinmuxing for DVI output
>>       ARM: OMAP: dss-common: change IGEP's DVI DDC i2c bus
>>       ARM: dts: omap3-igep0020: name twl4030 VPLL2 regulator as vdds_d=
si
>>
>> Changes since v1:
>>
>>  Don't add a workaround in drivers/video/omap2/dss/dpi.c to use the
>>  VPLL2 regulator from twl4030 if VDDS_DSI regulator is not linked to
>>  the DPI device since the used regulator is a per board configuration.=

>>
>>  Instead add a regulator-name =3D "vdds_dsi" property to the regulator=

>>  in the IGEPv2 DTS file as suggested by Tony Lindgren.
>>
>> Tony,
>>
>> Most of these patches are just DTS changes so they have to be picked
>> by Benoit besides the following patch that has to go through your tree=

>>
>> [PATCH 10/11] ARM: OMAP: dss-common: change IGEP's DVI DDC i2c bus
>>
>> Since we have removed the board file for IGEP boards I think these
>> can be considered as regression fixes for 3.13 although I don't mind
>> if you prefer to wait for 3.14.
>>
>> Thanks a lot and best regards,
>> Javier
>> --
>=20
> Hi Benoit and Tony,
>=20
> Now that 3.13-rc1 is out, do you think that it would be possible to
> include this series as a fix for the -rc cycle?
>=20
> Otherwise we will have missing functionality for IGEP boards on 3.13
> due the board file removal. The changes are mostly DT and won't affect
> other boards.

The DSS related parts look fine to me.

 Tomi



--Sl51BJ9T5CScjE0a8NCfJIs7bRKRWivQ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSlIOZAAoJEPo9qoy8lh71nsEQAJsrHQAZD/KvYcCwkHa46KpX
Cfq2g/jArTkVRUk+0rpRtphEJBypd+IU8/oZfNuPBemIPvFEJhvun8wtanDnT/aX
BNrpto9OF/prPFIDWELmxklC2OyrVIDB6ZdAMThX7WlqwzI85e3Zotepp9es2a8C
wM1ZTDNx98epG2GWjuaPp1MvpYckEcWJyfuV7eOg5f43Fi+VWFdCaqTyyhr0hyv0
qP9x1t/M+BXcdc288A09exh/A6HxWwfNPh3xXAg051TLkUcE+P9gMTL05QpKHTfc
rEKuXxV0QYF7NbcUwftehefrHpAOXGtrF8LrUtSwuX7cGuQ/glE92qxjUPrpYls/
sQJFvikMZhlWrfAJsAQAGIfMone5fHd4VS/hZzCyP05BAp407+nEh//bF5flgvfP
MCJ3xK8v1K09HVT8P5LMNvD9IBQINtPfmZPUrs0EjxwNS0NGaCU6aWExfJ9tTNDc
ruU2qFsFqcxg5jPLGkl1oACYaMcnhRLS4y/HYgAuO6u9t0aFwwLB1IuzW0kZEDyf
OGFh9aTM4dwyPQ18iSFcB7Z5oe1zJGQqSgTCmfQTdFGbB1i9wDOrLjjIvZogSoDq
Pe4W5JGmkjB/My1hz9W4sW3SdQXxpeu6NnGm8q2rOOekxiuTqamGau0pmKAnBW0O
OI7SXex1JpiII0NsXG3V
=prgE
-----END PGP SIGNATURE-----

--Sl51BJ9T5CScjE0a8NCfJIs7bRKRWivQ8--
