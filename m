From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 4/5] ARM: dts: omap5: describe control for ckobuffer
Date: Mon, 9 May 2016 15:10:16 +0300
Message-ID: <145c9917-6a85-292b-c3c9-cf85ceb26f21@ti.com>
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
 <573079F5.7050507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <573079F5.7050507@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Laxman Dewangan <ldewangan@nvidia.com>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

On 05/09/16 14:52, Tero Kristo wrote:
> On 09/05/16 14:18, H. Nikolaus Schaller wrote:
>> Hi,
>>
>>> Am 28.04.2016 um 15:23 schrieb Tero Kristo <t-kristo@ti.com>:
>>>
>>> On 28/04/16 12:12, H. Nikolaus Schaller wrote:
>>>> Hi Tero,
>>>>
>>>>> Am 28.04.2016 um 10:03 schrieb Tero Kristo <t-kristo@ti.com>:
>>>>>
>>>>> On 27/04/16 17:35, H. Nikolaus Schaller wrote:
>>>>>> HI,
>>>>>>
>>>>>>> Am 27.04.2016 um 16:23 schrieb Peter Ujfalusi <peter.ujfalusi@t=
i.com>:
>>>>>>>
>>>>>>> On 04/27/2016 05:10 PM, Tero Kristo wrote:
>>>>>>>> On 27/04/16 16:10, H. Nikolaus Schaller wrote:
>>>>>>>>>
>>>>>>>>>> Am 27.04.2016 um 14:31 schrieb Tero Kristo <t-kristo@ti.com>=
:
>>>>>>>>>>
>>>>>>>>>> On 27/04/16 09:04, H. Nikolaus Schaller wrote:
>>>>>>>>>>>
>>>>>>>>>>>> Am 26.04.2016 um 19:27 schrieb Tony Lindgren <tony@atomide=
=2Ecom>:
>>>>>>>>>>>>
>>>>>>>>>>>> Tero,
>>>>>>>>>>>>
>>>>>>>>>>>> * H. Nikolaus Schaller <hns@goldelico.com> [160418 11:23]:
>>>>>>>>>>>>> OMAP5 has a register to control if the ckobuffer is enabl=
ed
>>>>>>>>>>>>> and defines the polarity. ckobuffer is required to drive =
a twl6040
>>>>>>>>>>>>> with the system clock. Hence, add the pinctrl,single to t=
he
>>>>>>>>>>>>> OMAP5 SoC description so that omap5-board-common can
>>>>>>>>>>>>> set up the ckobuffer as required.
>>>>>>>>>>>>
>>>>>>>>>>>> Is this really a mux or should it be a mux clock?
>>>>>>>>>>>
>>>>>>>>>>> It is a pinmux setting for the clock out buffer to choose w=
hat signal
>>>>>>>>>>> (and polarity) is presented on the fref_xtal_clk pad.
>>>>>>>>>>>
>>>>>>>>>>> The register is part of the CTRL_MODULE_WKUP.
>>>>>>>>>>> The clock signal is the xtal master clock of the whole SoC.
>>>>>>>>>>>
>>>>>>>>>>> Although there is a bit to choose an alternate clock, there=
 is no
>>>>>>>>>>> alternate in the OMAP5 silicon.
>>>>>>>>>>>
>>>>>>>>>>> Therefore I would say it is about padconf and not clock or =
clock mux
>>>>>>>>>>> related.
>>>>>>>>>>>
>>>>>>>>>>> It just happens to be a clock signal which can be routed to=
 this
>>>>>>>>>>> pad.
>>>>>>>>>>
>>>>>>>>>> The two could very well be implemented as clock nodes, a mux=
 and a
>>>>>>>>>> gate.
>>>>>>>>>> This would describe the hardware functionality better imo, i=
f the
>>>>>>>>>> assumptions made here are correct. Implementing the control =
as pinctrl
>>>>>>>>>> hacks looks rather weird to me.
>>>>>>>>>
>>>>>>>>> Why do you consider it a "pinctrl hack"? IMHO it is not a hac=
k, but 100%
>>>>>>>>> proper use of pinctrl.
>>>>>>>>
>>>>>>>> It is just the level of abstraction we are talking about here.=
 If it is a
>>>>>>>> clock we are controlling, we should rather control it as a clo=
ck
>>>>>>>> (higher level
>>>>>>>> abstraction), not a pin.
>>>>>>>
>>>>>>> I second this. I think it is better to have a simple gate clock=
 and handle
>>>>>>> only CONTROL_CKOBUFFER:CKOBUFFER_CLK_EN (bit 28) only as the ot=
her bits
>>>>>>> does
>>>>>>> not have real use.
>>>>>>>
>>>>>>> Then we can add clk API support for this. On most OMAP4 devices=
 the
>>>>>>> clock is
>>>>>>> always on,
>>>>>>
>>>>>> this is why I am raising the question if we really want to contr=
ol it on
>>>>>> the omap5 or just
>>>>>> turn it on for all omap5 boards like the omap4 appears to do... =
I.e. if
>>>>>> turning the pin on
>>>>>> as a pinctrl is IMHO sufficient for all practical purposes.
>>>>>>
>>>>>>> so the board DTS file need to provide a dummy clock, or we can =
make
>>>>>>> the high precision clock also as optional (on panda both OMAP4 =
and twl6040
>>>>>>> uses the same reference clock).
>>>>>>
>>>>>> Hm. It looks as if implementing this (and clock gating) is beyon=
d my
>>>>>> experiences.
>>>>>> But I am happy to test a proposal on our omap5 board.
>>>>>>
>>>>>> BR and thanks,
>>>>>> Nikolaus
>>>>>
>>>>> See the inline patch, this implements the fref_xtal_ck. I had to =
add some
>>>>> kernel code also to cope with the new SCM area, but the same area=
 can now
>>>>> be accessed via syscon also if needed.
>>>>
>>>> Looks interesting, although quite complex to enable a single SoC p=
ad at
>>>> boot time...
>>>
>>> Yea it gives plenty of other things for you also. syscon, integrati=
on with
>>> clock framework, etc.
>>>
>>>>
>>>> Will asap study how it works and test. And of course report result=
s.
>>>
>>> Thanks, Tero.
>>>
>>>>
>>>> Thanks and BR,
>>>> Nikolaus
>>>>
>>>>>
>>>>> From: Tero Kristo <t-kristo@ti.com>
>>>>> Date: Thu, 28 Apr 2016 11:00:57 +0300
>>>>> Subject: [PATCH] ARM: omap5: add support for fref_xtal_ck
>>>>>
>>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>>> ---
>>>>> arch/arm/boot/dts/omap5.dtsi           | 22 +++++++++++++++++++++=
+
>>>>> arch/arm/boot/dts/omap54xx-clocks.dtsi | 10 ++++++++++
>>>>> arch/arm/mach-omap2/control.c          | 20 ++++++++++++++++----
>>>>> include/linux/clk/ti.h                 |  1 +
>>>>> 4 files changed, 49 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/oma=
p5.dtsi
>>>>> index 38805eb..bdc6528 100644
>>>>> --- a/arch/arm/boot/dts/omap5.dtsi
>>>>> +++ b/arch/arm/boot/dts/omap5.dtsi
>>>>> @@ -277,6 +277,28 @@
>>>>>                 pinctrl-single,register-width =3D <16>;
>>>>>                 pinctrl-single,function-mask =3D <0x7fff>;
>>>>>             };
>>>>> +
>>>>> +            omap5_scm_wkup_pad_conf: omap5_scm_wkup_pad_conf@cda=
0 {
>>>>> +                compatible =3D "ti,omap5-scm-wkup-pad-conf",
>>>>> +                         "simple-bus";
>>>>> +                reg =3D <0xcda0 0x60>;
>>>>> +                #address-cells =3D <1>;
>>>>> +                #size-cells =3D <1>;
>>>>> +                ranges =3D <0 0xcda0 0x60>;
>>>>> +
>>>>> +                scm_wkup_pad_conf: scm_conf@0 {
>>>>> +                    compatible =3D "syscon", "simple-bus";
>>>>> +                    reg =3D <0x0 0x60>;
>>>>> +                    #address-cells =3D <1>;
>>>>> +                    #size-cells =3D <1>;
>>>>> +                    ranges =3D <0 0x0 0x60>;
>>>>> +
>>>>> +                    scm_wkup_pad_conf_clocks: clocks@0 {
>>>>> +                        #address-cells =3D <1>;
>>>>> +                        #size-cells =3D <0>;
>>>>> +                    };
>>>>> +                };
>>>>> +            };
>>>>>         };
>>>>>
>>>>>         ocmcram: ocmcram@40300000 {
>>>>> diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi
>>>>> b/arch/arm/boot/dts/omap54xx-clocks.dtsi
>>>>> index 83b425f..f970dac 100644
>>>>> --- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
>>>>> +++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
>>>>> @@ -1388,3 +1388,13 @@
>>>>>         reg =3D <0x021c>;
>>>>>     };
>>>>> };
>>>>> +
>>>>> +&scm_wkup_pad_conf_clocks {
>>>>> +    fref_xtal_ck: fref_xtal_ck {
>>>>> +        #clocks-cells =3D <0>;
>>>>> +        compatible =3D "ti,gate-clock";
>>>>> +        clocks =3D <&sys_clkin>;
>>>>> +        ti,bit-shift =3D <28>;
>>>>> +        reg =3D <0x14>;
>>>>> +    };
>>>>> +};
>>>>> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/=
control.c
>>>>> index 1662071..5956641 100644
>>>>> --- a/arch/arm/mach-omap2/control.c
>>>>> +++ b/arch/arm/mach-omap2/control.c
>>>>> @@ -623,6 +623,7 @@ void __init omap3_ctrl_init(void)
>>>>>
>>>>> struct control_init_data {
>>>>>     int index;
>>>>> +    void __iomem *mem;
>>>>>     s16 offset;
>>>>> };
>>>>>
>>>>> @@ -635,6 +636,10 @@ static const struct control_init_data
>>>>> omap2_ctrl_data =3D {
>>>>>     .offset =3D -OMAP2_CONTROL_GENERAL,
>>>>> };
>>>>>
>>>>> +static const struct control_init_data ctrl_aux_data =3D {
>>>>> +    .index =3D TI_CLKM_CTRL_AUX,
>>>>> +};
>>>>> +
>>>>> static const struct of_device_id omap_scrm_dt_match_table[] =3D {
>>>>>     { .compatible =3D "ti,am3-scm", .data =3D &ctrl_data },
>>>>>     { .compatible =3D "ti,am4-scm", .data =3D &ctrl_data },
>>>>> @@ -644,6 +649,7 @@ static const struct of_device_id
>>>>> omap_scrm_dt_match_table[] =3D {
>>>>>     { .compatible =3D "ti,dm816-scrm", .data =3D &ctrl_data },
>>>>>     { .compatible =3D "ti,omap4-scm-core", .data =3D &ctrl_data }=
,
>>>>>     { .compatible =3D "ti,omap5-scm-core", .data =3D &ctrl_data }=
,
>>>>> +    { .compatible =3D "ti,omap5-scm-wkup-pad-conf", .data =3D &c=
trl_aux_data },
>>>>>     { .compatible =3D "ti,dra7-scm-core", .data =3D &ctrl_data },
>>>>>     { }
>>>>> };
>>>>> @@ -660,15 +666,21 @@ int __init omap2_control_base_init(void)
>>>>>     struct device_node *np;
>>>>>     const struct of_device_id *match;
>>>>>     struct control_init_data *data;
>>>>> +    void __iomem *mem;
>>>>>
>>>>>     for_each_matching_node_and_match(np, omap_scrm_dt_match_table=
, &match) {
>>>>>         data =3D (struct control_init_data *)match->data;
>>>>>
>>>>> -        omap2_ctrl_base =3D of_iomap(np, 0);
>>>>> -        if (!omap2_ctrl_base)
>>>>> +        mem =3D of_iomap(np, 0);
>>>>> +        if (!mem)
>>>>>             return -ENOMEM;
>>>>>
>>>>> -        omap2_ctrl_offset =3D data->offset;
>>>>> +        if (data->index =3D=3D TI_CLKM_CTRL) {
>>>>> +            omap2_ctrl_base =3D mem;
>>>>> +            omap2_ctrl_offset =3D data->offset;
>>>>> +        }
>>>>> +
>>>>> +        data->mem =3D mem;
>>>>>     }
>>>>>
>>>>>     return 0;
>>>>> @@ -713,7 +725,7 @@ int __init omap_control_init(void)
>>>>>         } else {
>>>>>             /* No scm_conf found, direct access */
>>>>>             ret =3D omap2_clk_provider_init(np, data->index, NULL=
,
>>>>> -                              omap2_ctrl_base);
>>>>> +                              data->mem);
>>>>>             if (ret)
>>>>>                 return ret;
>>>>>         }
>>>>> diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
>>>>> index dc5164a..be25aa8 100644
>>>>> --- a/include/linux/clk/ti.h
>>>>> +++ b/include/linux/clk/ti.h
>>>>> @@ -195,6 +195,7 @@ enum {
>>>>>     TI_CLKM_PRM,
>>>>>     TI_CLKM_SCRM,
>>>>>     TI_CLKM_CTRL,
>>>>> +    TI_CLKM_CTRL_AUX,
>>>>>     TI_CLKM_PLLSS,
>>>>>     CLK_MAX_MEMMAPS
>>>>> };
>>>>
>>>
>>
>> finally I found some time to apply your patches. Sorry for the long =
time.
>>
>> Unfortunately, it does not work. Neither on omap5evm nor on our omap=
5 hardware.
>> I get no sound on the twl6040 - just white noise (which can be contr=
olled in
>> level through
>> amixer so it is created on the digital input side of the twl6040).
>>
>> So I think your patch is missing a detail compared to my simple solu=
tion.
>=20
> Did you implement anything on the audio driver side? The audio driver=
 must
> enable the clock implemented by this patch.

I did, can test it in 10 minutes or so...

>=20
> -Tero
>=20
>>
>> BR,
>> Nikolaus
>>
>>
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20


--=20
P=E9ter
