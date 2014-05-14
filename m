From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 3/6] ARM: dts: dra7: add support for parallel NAND
 flash
Date: Wed, 14 May 2014 12:00:03 +0300
Message-ID: <53733093.6000904@ti.com>
References: <1399668412-10818-1-git-send-email-pekon@ti.com>	<CABxcv=nNuMLDCbNimWWR6yBbq3dHV6i87vBu69ZXGcYE-c9bmA@mail.gmail.com>	<20980858CB6D3A4BAE95CA194937D5E73EACC26A@DBDE04.ent.ti.com> <CABxcv==SGZ1fReXkgT769Z70ek_guMVn6nSK0FFgzjoksLGBrw@mail.gmail.com> <20980858CB6D3A4BAE95CA194937D5E73EACC2C2@DBDE04.ent.ti.com> <53732896.6060109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52187 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbaENJAL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 May 2014 05:00:11 -0400
In-Reply-To: <53732896.6060109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, Minal Shah <minalkshah@gmail.com>

On 05/14/2014 11:25 AM, Roger Quadros wrote:
> Hi Pekon,
>=20
> On 05/12/2014 12:05 PM, Gupta, Pekon wrote:
>>> From: Javier Martinez Canillas [mailto:javier@dowhile0.org]
>> [...]
>>
>>>> Newer platforms have upgraded version of GPMC engine which support=
s
>>>> BCH16 ECC scheme in hardware. Thus the GPMC address space was
>>>> expanded to include some extra registers required for BCH16 ECC [2=
].
>>>>
>>>>
>>>
>>> I see and did the GPMC register space became that big to need to ma=
p 8KB?
>>>
>>> Although the smallest unit for ioremap is PAGE_SIZE and using any o=
f
>>> these reg sizes:
>>>
>>> reg =3D <0x6e000000 0x02d0>;
>>> reg =3D <0x6e000000 0x0400>;
>>> reg =3D <0x6e000000 0x1000>;
>>>
>>> in practice have the same effect, DTS should describe the hardware =
and
>>> not an implementation detail so I think that we should use only the
>>> register size that is defined in the TRM.
>>>
>> Yes, I agree with you.
>> I have fixed this in newer version of the patch and will be sending =
it soon.
>> But this series will only contain updates for new platforms with add=
ition
>> of NAND node in DTS, so that this series is not stalled for any reas=
on.
>> For fixing existing platform/boards DTS I'll send another series soo=
n.
>>
>> For now, I'll use GPMC address-space size =3D 0x380 as it matches wi=
th
>> actual hardware and is working.
>=20
> How did you get 0x380?
>=20
> From DRA7 TRM, GPMC address range is 0x5000 0000 : 0x5000 02D0
> So the address-space size should be 0x2D4 (as last register@2D0 is 32=
-bits wide)

Sorry for the noise.
Just figured out that the register space is not numerically arranged in=
 the TRM.

The last register is P GPMC_BCH_RESULT6_i
	0x5000  0308  +  (0x0000   0010  *  i)
	i =3D 0 to 7

So size should be 0x37C.

cheers,
-roger
=20
>=20
> For the ELM module it should be 4KB i.e. 0x1000
>=20
> cheers,
> -roger
>=20
>>>>
>>>> [1] http://www.ti.com/lit/gpn/am3359    (Section 7.4 to 7.4.5)
>>>>
>>>> [2] http://www.ti.com/lit/gpn/am3359    (Section 7.1 to 7.1.5)
>>>> (Though the AM335x address space mentions 0x368 as last address,
>>>>  it should be 0x378. I have raised documentation bug for it).
>>>>
>>>>
>>>> with regards, pekon
>>>
>>> Best regards,
>>> Javier
>>>
>>> [0]: http://lxr.free-electrons.com/source/arch/arm/mm/ioremap.c#L33=
4
>> =04=EF=BF=BD{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD+%=EF=BF=BD=EF=BF=BDlzwm=EF=BF=BD=EF=BF=BDb=EF=BF=BD=EB=
=A7=B2=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDzX=EF=BF=BD=EF=BF=BD=1A&j=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=17=EF=BF=BD=EF=BF=BD=DC=A8}=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=C6=A0z=EF=BF=BD&j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD+zf=EF=BF=BD=EF=BF=BD=EF=BF=BD=
h=EF=BF=BD=EF=BF=BD=EF=BF=BD~=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDi=EF=BF=
=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=
?=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD&=EF=BF=BD)=DF=A2=1Bf
>>
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
