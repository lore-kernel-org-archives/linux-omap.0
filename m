From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 9/9] RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN
Date: Mon, 16 Feb 2015 10:28:36 +0200
Message-ID: <54E1AA34.8090205@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>	<1423840286-18377-10-git-send-email-tomi.valkeinen@ti.com> <CAGo_u6p89ot-eNwK65otoYsLM6NXeh929=SBG6uKAsX8Tnd_RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="TdCKEwFb8jInbsL0u6dHLjXrQSP6q1aMI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34539 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbbBPI3U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Feb 2015 03:29:20 -0500
In-Reply-To: <CAGo_u6p89ot-eNwK65otoYsLM6NXeh929=SBG6uKAsX8Tnd_RQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tero Kristo <t-kristo@ti.com>, Felipe Balbi <balbi@ti.com>

--TdCKEwFb8jInbsL0u6dHLjXrQSP6q1aMI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/02/15 17:25, Nishanth Menon wrote:
> On Fri, Feb 13, 2015 at 9:11 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>> DRA7xx's CTRL_CORE_CONTROL_IO_2 register contains bits for various
>> subsystems, including PCIe, DCAN, QSPI and DSS. At the moment only DCA=
N
>> bits are used by the SW via syscon.
>>
>> For DSS there is DSS_DESHDCP_CLKEN bit. This (presumably) enables a
>> clock related to DSS's HDCP. If that clock is off, DSS module does not=

>> start at all, causing OCP errors. This means that the HWMOD code is no=
t
>> able to reset and initialize DSS.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>  arch/arm/mach-omap2/io.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
>> index a1bd6affb508..2206fb13f195 100644
>> --- a/arch/arm/mach-omap2/io.c
>> +++ b/arch/arm/mach-omap2/io.c
>> @@ -700,6 +700,17 @@ void __init dra7xx_init_early(void)
>>         dra7xx_hwmod_init();
>>         omap_hwmod_init_postsetup();
>>         omap_clk_soc_init =3D dra7xx_dt_clk_init;
>> +
>> +       if (soc_is_dra7xx()) {
>=20
> Umm.. this code will only be executed for dra7xx :)

Better safe than sorry! But you're right, I'll remove the if =3D).

>> +               u32 v;
>> +               const u16 ctrl_core_control_io_2 =3D 0x558;
>> +
>> +               /* set CTRL_CORE_CONTROL_IO_2:DSS_DESHDCP_CLKEN */
>> +
>> +               v =3D omap_ctrl_readl(ctrl_core_control_io_2);
>> +               v |=3D 1;
>> +               omap_ctrl_writel(v, ctrl_core_control_io_2);
>> +       }
>>  }
>>
>>  void __init dra7xx_init_late(void)
> just my 2 cents.
> I would probably wait for control module to become syscon and probably
> model this as syscon clk - I thin we should be seeing a series
> sometime soon.

Yep, I hope Tero's work will make this patch not needed. I wanted to
include something in this series that makes the DSS usable.

 Tomi



--TdCKEwFb8jInbsL0u6dHLjXrQSP6q1aMI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU4ao9AAoJEPo9qoy8lh71uX0QAKV+RMqAow5zMOFhx5NEleES
loQkKx7n7FcjHph1ujmJ/ywGnjMHu1KmhM+NQdWYCX5Z4gwaupog03wHvScTwNRu
O0wr6i1G/yaNXEX6vv9k75g8azumBZbewbqYdbFS2O9VDEJ3uWwzeEkLJiUAkLhU
T1QKPNID2N4uAt/4AeDLBrlxre08U3f6f3wg+g24R6LI5c7HCExrpSx/9TnOdENm
nNrQVVOgF1TMGHVwHVkiK9Czk6ARnsgsh9n3iTWZ2jp+DoWEOpO86UD594Ifqs1D
s1s1jQKvprcLp19T7j6xv+A5xM7Jducyd+WMJrxNZR/rPdj8IodkYydzoaQZ+yQ+
Szfyxt0lVgmMjJFlQa0KL/KPYFjgoRRVILZhpE7mB9MxIBNSZbQZzxF+xh5cagUG
M5G3djzsx3LwuTsgKdmo66c8f/5myuUR2sJGR+ljwcNriVnh+z0CfE6uRfqGN7Qy
O1+4Tpyo/smbz5jqZL2pg1lGcQBfZz122PQlzsoMafINA8mjUaC+yH9RIK3cBD68
5rhYhvCn6MpvnQ9fGO+sayv4sqblFQkNS1qK8sL6uk33B3h4a6H5nOFLB6aqjasd
6Utr4/gJtECQ3F7md1qunfAtYEQ4x22j9d49Zu8rNFW878iDE+dhug0XJIDl1swg
Nhnd3z0U14St2vyT+HHQ
=Rvyc
-----END PGP SIGNATURE-----

--TdCKEwFb8jInbsL0u6dHLjXrQSP6q1aMI--
