From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [Kernel] [PATCH v2 4/5] ARM: dts: omap5: describe control for
 ckobuffer
Date: Mon, 9 May 2016 15:46:12 +0300
Message-ID: <71c88d52-3737-6edb-52af-0b0f4a74efb2@ti.com>
References: <cover.1461003660.git.hns@goldelico.com>
 <a5fb89737594a656318896a8e43814c21ca992eb.1461003660.git.hns@goldelico.com>
 <20160426172710.GI5995@atomide.com>
 <70572DA1-BEB4-4681-BA6C-2E1C9002D730@goldelico.com>
 <5720B107.4000907@ti.com>
 <A90F1BFC-A834-4EC0-81F9-2C8222AAA010@goldelico.com>
 <5720C85B.9010701@ti.com> <ce9a7840-e86f-0d0c-3ed6-a571eec6659d@ti.com>
 <40536322-073F-48BD-9D07-32B9A9F07AF2@goldelico.com>
 <5721C3D4.7040401@ti.com>
 <2A9D82CD-9ACA-49F6-9D2B-9EACFC517914@goldelico.com>
 <57220EDD.7080903@ti.com>
 <F2BCD4BA-E4E4-43F4-B65C-B625ED3B2D13@goldelico.com>
 <573079F5.7050507@ti.com> <145c9917-6a85-292b-c3c9-cf85ceb26f21@ti.com>
 <f66cd508-fe53-af58-bda5-822c8213cf7d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f66cd508-fe53-af58-bda5-822c8213cf7d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Kumar Gala <galak@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, Marek Belisko <marek@goldelico.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

On 05/09/16 15:32, Peter Ujfalusi wrote:
> On 05/09/16 15:10, Peter Ujfalusi wrote:
>=20
>>>> finally I found some time to apply your patches. Sorry for the lon=
g time.
>>>>
>>>> Unfortunately, it does not work. Neither on omap5evm nor on our om=
ap5 hardware.
>>>> I get no sound on the twl6040 - just white noise (which can be con=
trolled in
>>>> level through
>>>> amixer so it is created on the digital input side of the twl6040).
>>>>
>>>> So I think your patch is missing a detail compared to my simple so=
lution.
>>>
>>> Did you implement anything on the audio driver side? The audio driv=
er must
>>> enable the clock implemented by this patch.
>>
>> I did, can test it in 10 minutes or so...
>=20
> might work, but linux-next is not booting on omap5-uevm :o I don't kn=
ow why...

Applying Tero's alone makes the board not to boot, so something there..=
=2E I can
not see anything even with low-level debugging enabled :( I can not deb=
ug it
further today, will look at this tomorrow.

> In any case I have attached the 3 patches I have for this, including =
Tero's
> ported to linux-next.
>=20
> Patch 3 might need to be done per board probably, but this should be =
good for
> testing.
>=20
>=20
>=20
> _______________________________________________
> Kernel mailing list
> Kernel@pyra-handheld.com
> http://pyra-handheld.com/cgi-bin/mailman/listinfo/kernel
>=20


--=20
P=C3=A9ter
