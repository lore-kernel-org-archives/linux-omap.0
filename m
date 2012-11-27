From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4430 produces boot warnings
Date: Tue, 27 Nov 2012 14:21:25 +0200
Message-ID: <50B4B045.7090603@ti.com>
References: <20121121230337.GR3332@n2100.arm.linux.org.uk>  <50AE1DC0.3030002@ti.com>  <50AE2BB6.8080406@ti.com>  <1353594842.786.45.camel@sokoban>  <50AE3A5B.5040603@ti.com> <1353663278.25248.4.camel@sokoban> <50B310D3.9050202@ti.com> <50B35D0E.6000509@ti.com> <50B4A2B7.9080806@ti.com> <50B4AA74.1090300@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig784B781EBD48FC3160B5CA04"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60679 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab2K0MVf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Nov 2012 07:21:35 -0500
In-Reply-To: <50B4AA74.1090300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: t-kristo@ti.com, Rajendra Nayak <rnayak@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

--------------enig784B781EBD48FC3160B5CA04
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-11-27 13:56, Archit Taneja wrote:
> On Tuesday 27 November 2012 04:53 PM, Tomi Valkeinen wrote:

>> Hmm, well this feels like a hack. DISPC driver doesn't know how the DS=
S
>> modules are arranged, which module belongs to which power domain, etc.=

>>
>> If it cannot be fixed in the arch code, I guess we could just have
>> dss_get_ctx_loss_count(void) function which always returns the
>> dss_core's ctx loss count, and define that on all the platforms omapds=
s
>> is used, the dss_core's ctx loss count is the same as ctx loss count f=
or
>> all the dss submodules.
>>
>> I think the above is true for all OMAPs. But it feels like a hack too,=

>> but not as bad as the above patch.
>=20
> Yes, a function taking in no platform device in dss's core.c would be
> less hacky. I guess we would need this for now, because a solution in
> omap_hwmod would be more complex and it may not be ready by the merge
> window.

Ok. Can you cook up a patch and test it?

PM guys, does the above sound like an acceptable work-around?

 Tomi



--------------enig784B781EBD48FC3160B5CA04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQtLBFAAoJEPo9qoy8lh71bBIP/2+Soc2cooq8dPxjh7dZynZc
FCin8FtycrvaY/Fstc56G4ninKUhJnLy6s/Ehx1tohjBmMUBlmBedqe/aKOR5WTZ
2Rntjau1U4WMZ7OCOJJi8SICY4MEl6dApxT6+qT3ZhSgER0arPovfUP7inNB+6eJ
qbthwxukZNO9fX+4DDQ4S/r071y6bj7UngvCkz0r3YW19oYej1WPOCmGnGcqqpaY
niy3ThLsDasVh4fGoSu7E4F43ub8uiilUcTc9yWHKL+J276wMR/BgVkMzdIreTyc
U/sG81DlBwE1rZkmxjRY4sOHpgDy+bRp/V0v6qx/FKgvEDAxolNWmcIKuXa7P4Z1
Yhs44MhOsq9baZadejznn1RTF2Lenq0Pxv4llBu5idTxNfOZ8bZ1uBSQiTFSfuqn
iYEiNMLMLgIN/+wgR5DyVDpPGGfGkwhMPoQC2cxVDAvq01wILMjf6/ZsjrZDP9Ia
1sqZ9LH5ReMjm9TXHq304Nzw1IXMiaUNBESyK4NiGD3KYXHK0ZIIzYwl70L84xWI
nqqld6N772Il7TnxilYwMp7EHH/TLu9fHA1T9tklW6WUJo+eJ/WGDLRbHvE0Stbu
m7QPnWEIqOQ+a2Gu4LtdscP55YFF2cLV8l9i7k1KDGWTji4GpOdDvYlYf7KYZ/D0
iu9DBiFFn4zi1+EwtSri
=vHHs
-----END PGP SIGNATURE-----

--------------enig784B781EBD48FC3160B5CA04--
