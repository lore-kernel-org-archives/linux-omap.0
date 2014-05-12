From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/11] ARM: OMAP: OMAP5 & AM43x DSS
Date: Mon, 12 May 2014 17:57:54 +0300
Message-ID: <5370E172.20009@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com> <5370CBD5.3060107@ti.com> <20140512143604.GB31772@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="2EGnwN2Tp86nKdrNBxoCuwsPsHSW6fA65"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53273 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758227AbaELO6V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 10:58:21 -0400
In-Reply-To: <20140512143604.GB31772@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Archit Taneja <archit@ti.com>, Tero Kristo <t-kristo@ti.com>

--2EGnwN2Tp86nKdrNBxoCuwsPsHSW6fA65
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/05/14 17:36, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140512 06:26]:
>> Hi Tony,
>>
>> On 09/05/14 14:56, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> Here are arch/arm/ patches to add display support for OMAP5 and AM43x=
=2E
>>>
>>> I have these in my tree, in a branch I will send to Tony for merging.=
 Most of
>>> these patches have already been around the lists, but I wanted to sen=
d them one
>>> more time to verify that all looks right and everybody is fine with t=
hem.
>>
>> I have pushed these to:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git 3.16/oma=
p
>>
>> If you're fine with these, I think we can consider that branch stable.=

>> There are probably still a few display related .dts changed for the
>> board coming up, but I'll add those on top of the current commits.
>=20
> Please coordinate things with Paul and Tero so you at least have proper=

> acks for the hwmod and and clock patches. In general we really want to
> queue hwmod and clock changes separately as those can easily mess up th=
ings
> in a bad way like we've already seen with overlapping hwmod entries in
> the .dts files.

Ok. I'm fine with splitting the series if that's easiest way to manage it=
=2E

Paul, Tero?

> Also, I'm wondering why we still have .clk and .opt_clks entries in the=

> hwmod data for am43xx and omap5 which are both device tree based with
> all the clocks coming from .dts files?

I think they are needed for the omap_device/hwmod stuff to work. Only
omapdss driver knows about the clocks defined in the .dts files, and the
omap_device/hwmod code still needs to do the reset and maybe some other
tasks that require the clocks.

 Tomi



--2EGnwN2Tp86nKdrNBxoCuwsPsHSW6fA65
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTcOFyAAoJEPo9qoy8lh71riYP/jVWA8PqhJF4icXtWT+jrXSD
DFhmhi9A9naGOWJyn//b1WFAoPOTvrxUaEhF2K5lFhK2DzJrJHuL1+yIek7m2PLX
yg8mhY8THo2Bru9ljDmvJzp3Yl5zum4R33S3BLRiq8RQsCwGxrbpcKliSEoy2dyn
B7YsyJ+OScG2/qr2koYQPDu5g3XoxqUxUDx3dYS0hLFrtFLd35LOGFC6mLMOfnsb
14lp1b+hb3Kz98e1chM1gB893BE1BNxYrEQH3T2FaFwM3jZ2i9iuEcDzp35rtoka
sIW/f4Qy+GVV4+msN2ugr5MRPcVtfYmuYNdU5mDD1sTXOTYpW41aPj4aCWvquQLv
GNhgZpQVQqgZgx2wBhGFxf1a02MSeCAPAa0DWsIrBUh3BecmMlZ55irRFu22Lytj
xi7gKvV3G1hVeTz9jGeSLFru/MoSmEhf2GtcB1Ixifu5tvrXKhgyUjR9RMf3xrE/
D0lPR7Av7r21OprsFkbpFTB/ye+MykkxRswz3mO94XkDCR0todmNGJdhONjAnurQ
Pu9NZlTMwW1puXt5uHMfzU9NKjOE7/lGFINnFbyssp1BlZZE0U6biNCmojnxmczE
VWxdaGTwYVtYWqzpyB/eJRw9gEMSnnf4nw1wHbk9TfA38kTKTlTPQmcTu2kCbzx0
zCTMXzEoShICpFhhf0Al
=Tp0Z
-----END PGP SIGNATURE-----

--2EGnwN2Tp86nKdrNBxoCuwsPsHSW6fA65--
