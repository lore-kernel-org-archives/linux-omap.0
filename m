From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [Kernel] [PATCH v2 4/5] ARM: dts: omap5: describe control for
 ckobuffer
Date: Mon, 9 May 2016 16:52:44 +0300
Message-ID: <3973330a-8a73-89fa-8e09-383407d0eaf9@ti.com>
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
 <71c88d52-3737-6edb-52af-0b0f4a74efb2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <71c88d52-3737-6edb-52af-0b0f4a74efb2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, kernel@pyra-handheld.com, LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, Marek Belisko <marek@goldelico.com>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 05/09/16 15:46, Peter Ujfalusi wrote:
> On 05/09/16 15:32, Peter Ujfalusi wrote:
>> On 05/09/16 15:10, Peter Ujfalusi wrote:
>>
>>>>> finally I found some time to apply your patches. Sorry for the lo=
ng time.
>>>>>
>>>>> Unfortunately, it does not work. Neither on omap5evm nor on our o=
map5 hardware.
>>>>> I get no sound on the twl6040 - just white noise (which can be co=
ntrolled in
>>>>> level through
>>>>> amixer so it is created on the digital input side of the twl6040)=
=2E
>>>>>
>>>>> So I think your patch is missing a detail compared to my simple s=
olution.
>>>>
>>>> Did you implement anything on the audio driver side? The audio dri=
ver must
>>>> enable the clock implemented by this patch.
>>>
>>> I did, can test it in 10 minutes or so...
>>
>> might work, but linux-next is not booting on omap5-uevm :o I don't k=
now why...
>=20
> Applying Tero's alone makes the board not to boot, so something there=
=2E.. I can
> not see anything even with low-level debugging enabled :( I can not d=
ebug it
> further today, will look at this tomorrow.

The crash is in arch/arm/mach-omap2/control.c:omap_control_init()

the syscon_node_to_regmap() returns with error for the new
omap5_scm_wkup_pad_conf node. The other syscon was OK, but becasue of t=
he
return PTR_ERR(syscon) the board will not boot...

Tero: any idea?

>> In any case I have attached the 3 patches I have for this, including=
 Tero's
>> ported to linux-next.
>>
>> Patch 3 might need to be done per board probably, but this should be=
 good for
>> testing.
>>
>>
>>
>> _______________________________________________
>> Kernel mailing list
>> Kernel@pyra-handheld.com
>> http://pyra-handheld.com/cgi-bin/mailman/listinfo/kernel
>>
>=20
>=20


--=20
P=C3=A9ter
