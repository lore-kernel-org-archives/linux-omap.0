From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 3/6] ARM: dts: dra7: add support for parallel NAND
 flash
Date: Wed, 14 May 2014 11:25:58 +0300
Message-ID: <53732896.6060109@ti.com>
References: <1399668412-10818-1-git-send-email-pekon@ti.com>	<CABxcv=nNuMLDCbNimWWR6yBbq3dHV6i87vBu69ZXGcYE-c9bmA@mail.gmail.com>	<20980858CB6D3A4BAE95CA194937D5E73EACC26A@DBDE04.ent.ti.com> <CABxcv==SGZ1fReXkgT769Z70ek_guMVn6nSK0FFgzjoksLGBrw@mail.gmail.com> <20980858CB6D3A4BAE95CA194937D5E73EACC2C2@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37737 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbaENI0E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 May 2014 04:26:04 -0400
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EACC2C2@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, Minal Shah <minalkshah@gmail.com>

Hi Pekon,

On 05/12/2014 12:05 PM, Gupta, Pekon wrote:
>> From: Javier Martinez Canillas [mailto:javier@dowhile0.org]
> [...]
>=20
>>> Newer platforms have upgraded version of GPMC engine which supports
>>> BCH16 ECC scheme in hardware. Thus the GPMC address space was
>>> expanded to include some extra registers required for BCH16 ECC [2]=
=2E
>>>
>>>
>>
>> I see and did the GPMC register space became that big to need to map=
 8KB?
>>
>> Although the smallest unit for ioremap is PAGE_SIZE and using any of
>> these reg sizes:
>>
>> reg =3D <0x6e000000 0x02d0>;
>> reg =3D <0x6e000000 0x0400>;
>> reg =3D <0x6e000000 0x1000>;
>>
>> in practice have the same effect, DTS should describe the hardware a=
nd
>> not an implementation detail so I think that we should use only the
>> register size that is defined in the TRM.
>>
> Yes, I agree with you.
> I have fixed this in newer version of the patch and will be sending i=
t soon.
> But this series will only contain updates for new platforms with addi=
tion
> of NAND node in DTS, so that this series is not stalled for any reaso=
n.
> For fixing existing platform/boards DTS I'll send another series soon=
=2E
>=20
> For now, I'll use GPMC address-space size =3D 0x380 as it matches wit=
h
> actual hardware and is working.

How did you get 0x380?

=46rom DRA7 TRM, GPMC address range is 0x5000 0000 : 0x5000 02D0
So the address-space size should be 0x2D4 (as last register@2D0 is 32-b=
its wide)

=46or the ELM module it should be 4KB i.e. 0x1000

cheers,
-roger

>>>
>>> [1] http://www.ti.com/lit/gpn/am3359    (Section 7.4 to 7.4.5)
>>>
>>> [2] http://www.ti.com/lit/gpn/am3359    (Section 7.1 to 7.1.5)
>>> (Though the AM335x address space mentions 0x368 as last address,
>>>  it should be 0x378. I have raised documentation bug for it).
>>>
>>>
>>> with regards, pekon
>>
>> Best regards,
>> Javier
>>
>> [0]: http://lxr.free-electrons.com/source/arch/arm/mm/ioremap.c#L334
> =04=EF=BF=BD{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD+%=EF=BF=BD=EF=BF=BDlzwm=EF=BF=BD=EF=BF=BDb=EF=BF=BD=EB=
=A7=B2=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDzX=EF=BF=BD=EF=BF=BD=1A&j=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=17=EF=BF=BD=EF=BF=BD=DC=A8}=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=C6=A0z=EF=BF=BD&j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD+zf=EF=BF=BD=EF=BF=BD=EF=BF=BD=
h=EF=BF=BD=EF=BF=BD=EF=BF=BD~=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDi=EF=BF=
=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=
?=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD&=EF=BF=BD)=DF=A2=1Bf
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
