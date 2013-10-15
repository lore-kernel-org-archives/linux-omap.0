From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v2 2/5] ARM: dts: omap: Add new bindings for OMAP
Date: Tue, 15 Oct 2013 09:27:10 +0200
Message-ID: <525CEE4E.6010601@baylibre.com>
References: <1381313521-10422-1-git-send-email-rnayak@ti.com> <1381313521-10422-3-git-send-email-rnayak@ti.com> <525572A8.9060401@baylibre.com> <5255872A.30702@ti.com> <52558842.6040409@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <52558842.6040409@baylibre.com>
Sender: linux-doc-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>
List-Id: linux-omap@vger.kernel.org

Hi Rajendra,

On 09/10/2013 18:45, Benoit Cousson wrote:
> + A couple of DT maintainers
>
> On 09/10/2013 18:41, Rajendra Nayak wrote:
>> On Wednesday 09 October 2013 08:43 PM, Benoit Cousson wrote:
>>> Hi Rajendra,
>>>
>>> On 09/10/2013 12:11, Rajendra Nayak wrote:
>>>> On OMAP we have co-processor IPs, memory controllers,
>>>> GPIOs which control regulators and power switches to
>>>> PMIC, and SoC internal Bus IPs, some or most of which
>>>> should either not be reset or idled or both at init.
>>>> (In some cases there are erratas which prevent an IP
>>>> from being reset)
>>>> Have a way to pass this information from DT.
>>>
>>> Did you get some acked-by from the DT maintainers?
>>> Every new bindings must be carefully reviewed now.
>>
>> Nope, I haven't. The patches are on the list for a couple
>> of months now.
>
> Let's see if Mark and Rob are OK with that.

OK, I've just applied it after a small change in the subject:

  ARM: dts: omap: Add reset/idle on init bindings for OMAP

Is that OK for you?

Thanks,
Benoit

>
> Thanks,
> Benoit
>
>>
>>>
>>> Regards,
>>> Benoit
>>>
>>>>
>>>> Update the am33xx/omap4 and omap5 dtsi files with the
>>>> new bindings for modules which either should not be
>>>> idled. reset or both. A later patch would cleanup the
>>>> same information that exists today as part of the hwmod
>>>> data files.
>>>>
>>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>>> ---
>>>>    .../devicetree/bindings/arm/omap/omap.txt          |    3 ++-
>>>>    arch/arm/boot/dts/am33xx.dtsi                      |    2 ++
>>>>    arch/arm/boot/dts/omap4.dtsi                       |    3 +++
>>>>    arch/arm/boot/dts/omap5.dtsi                       |    2 ++
>>>>    4 files changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt
>>>> b/Documentation/devicetree/bindings/arm/omap/omap.txt
>>>> index 91b7049..808c154 100644
>>>> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
>>>> @@ -21,7 +21,8 @@ Required properties:
>>>>    Optional properties:
>>>>    - ti,no_idle_on_suspend: When present, it prevents the PM to id=
le
>>>> the module
>>>>      during suspend.
>>>> -
>>>> +- ti,no-reset-on-init: When present, the module should not be res=
et
>>>> at init
>>>> +- ti,no-idle-on-init: When present, the module should not be idle=
d
>>>> at init
>>>>
>>>>    Example:
>>>>
>>>> diff --git a/arch/arm/boot/dts/am33xx.dtsi
>>>> b/arch/arm/boot/dts/am33xx.dtsi
>>>> index f9c5da9..ec33ea0 100644
>>>> --- a/arch/arm/boot/dts/am33xx.dtsi
>>>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>>>> @@ -607,6 +607,7 @@
>>>>                reg =3D <0x44d00000 0x4000    /* M3 UMEM */
>>>>                       0x44d80000 0x2000>;    /* M3 DMEM */
>>>>                ti,hwmods =3D "wkup_m3";
>>>> +            ti,no-reset-on-init;
>>>>            };
>>>>
>>>>            elm: elm@48080000 {
>>>> @@ -637,6 +638,7 @@
>>>>            gpmc: gpmc@50000000 {
>>>>                compatible =3D "ti,am3352-gpmc";
>>>>                ti,hwmods =3D "gpmc";
>>>> +            ti,no-idle-on-init;
>>>>                reg =3D <0x50000000 0x2000>;
>>>>                interrupts =3D <100>;
>>>>                gpmc,num-cs =3D <7>;
>>>> diff --git a/arch/arm/boot/dts/omap4.dtsi
>>>> b/arch/arm/boot/dts/omap4.dtsi
>>>> index 22d9f2b..e8fe797 100644
>>>> --- a/arch/arm/boot/dts/omap4.dtsi
>>>> +++ b/arch/arm/boot/dts/omap4.dtsi
>>>> @@ -214,6 +214,7 @@
>>>>                gpmc,num-cs =3D <8>;
>>>>                gpmc,num-waitpins =3D <4>;
>>>>                ti,hwmods =3D "gpmc";
>>>> +            ti,no-idle-on-init;
>>>>            };
>>>>
>>>>            uart1: serial@4806a000 {
>>>> @@ -492,6 +493,7 @@
>>>>                reg =3D <0x4c000000 0x100>;
>>>>                interrupts =3D <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
>>>>                ti,hwmods =3D "emif1";
>>>> +            ti,no-idle-on-init;
>>>>                phy-type =3D <1>;
>>>>                hw-caps-read-idle-ctrl;
>>>>                hw-caps-ll-interface;
>>>> @@ -503,6 +505,7 @@
>>>>                reg =3D <0x4d000000 0x100>;
>>>>                interrupts =3D <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
>>>>                ti,hwmods =3D "emif2";
>>>> +            ti,no-idle-on-init;
>>>>                phy-type =3D <1>;
>>>>                hw-caps-read-idle-ctrl;
>>>>                hw-caps-ll-interface;
>>>> diff --git a/arch/arm/boot/dts/omap5.dtsi
>>>> b/arch/arm/boot/dts/omap5.dtsi
>>>> index 7cdea1b..a9d49df 100644
>>>> --- a/arch/arm/boot/dts/omap5.dtsi
>>>> +++ b/arch/arm/boot/dts/omap5.dtsi
>>>> @@ -607,6 +607,7 @@
>>>>            emif1: emif@0x4c000000 {
>>>>                compatible    =3D "ti,emif-4d5";
>>>>                ti,hwmods    =3D "emif1";
>>>> +            ti,no-idle-on-init;
>>>>                phy-type    =3D <2>; /* DDR PHY type: Intelli PHY *=
/
>>>>                reg =3D <0x4c000000 0x400>;
>>>>                interrupts =3D <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
>>>> @@ -618,6 +619,7 @@
>>>>            emif2: emif@0x4d000000 {
>>>>                compatible    =3D "ti,emif-4d5";
>>>>                ti,hwmods    =3D "emif2";
>>>> +            ti,no-idle-on-init;
>>>>                phy-type    =3D <2>; /* DDR PHY type: Intelli PHY *=
/
>>>>                reg =3D <0x4d000000 0x400>;
>>>>                interrupts =3D <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
>>>>
>>>
>>
>


--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
