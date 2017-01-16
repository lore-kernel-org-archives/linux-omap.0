From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v2 2/3] can: ti_hecc: Add TI HECC DT binding documentation
Date: Mon, 16 Jan 2017 11:59:17 +0100
Message-ID: <CAGm1_ksspvFG+ScMjtw6uXAL2cAuB5ZsawaH1nYPVwQEQVE9HA@mail.gmail.com>
References: <1484143521-4898-1-git-send-email-yegorslists@googlemail.com>
 <1484143521-4898-3-git-send-email-yegorslists@googlemail.com> <20170113195633.7igh7fdlcsw5ov6g@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <20170113195633.7igh7fdlcsw5ov6g@rob-hp-laptop>
Sender: linux-can-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, Andrey Skvortsov <andrej.skvortzov@gmail.com>, hs@denx.de, Anton Glukhov <anton.a.glukhov@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "Grim, Dennis" <dennis.grim@teejet.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 13, 2017 at 8:56 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Jan 11, 2017 at 03:05:20PM +0100, yegorslists@googlemail.com wrote:
>> From: Anton Glukhov <anton.a.glukhov@gmail.com>
>>
>> DT binding documentation for TI High End CAN Controller
>>
>> Signed-off-by: Anton Glukhov <anton.a.glukhov@gmail.com>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> ---
>> Changes v1 -> v2:
>>       change compatible to "ti,am3505"
>>
>>  .../devicetree/bindings/net/can/ti_hecc.txt        | 31 ++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/can/ti_hecc.txt b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
>> new file mode 100644
>> index 0000000..ce015cf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/can/ti_hecc.txt
>> @@ -0,0 +1,31 @@
>> +* Texas Instruments High End CAN Controller (HECC)
>> +
>> +This file provides information, what the device node
>> +for the hecc interface contains.
>> +
>> +Required properties:
>> +- compatible: "ti,am3505"
>> +- reg: offset and length of the register set for the device
>> +- interrupts: interrupt mapping for the hecc interrupts sources
>> +- clocks: clock phandles (see clock bindings for details)
>
>> +- ti,scc-ram-offset: offset to scc module ram
>> +- ti,hecc-ram-offset: offset to hecc module ram
>> +- ti,mbx-offset: offset to mailbox ram
>
> Is there not a common case that would be the default?

So far HECC is only implemented in two SoCs am3505/am3517. Both are
identical in this regard and differ in having/not having a 3D graphics
engine. So perhaps it makes sense just to move these offsets to the
driver itself?

>> +
>> +Optional properties:
>> +- ti,int-line: interrupt line

Marc suggested to convert this option to bool. Though it should be
also renamed then. HECC has basically two interrupts HECC0 and HECC1.
The one is for mailbox interrupts the other for system interrupts. But
one can map all interrupts to one "pin". This is also made in the
driver. The user can decide which one to use for all interrupts.

I'd suggest following name:

ti,use-hecc1int: if provided configures HECC to produce all interrupts
on HECC1INT interrupt line. By default HECC0INT interrupt line will be
used.

Yegor

> Needs a better description. What are valid values? This is some internal
> setting about which pin to route the interrupt output to I'm guessing.
>
>> +
>> +Example:
>> +
>> +For am3517evm board:
>> +     hecc: can@0x5c050000 {
>> +             compatible = "ti,am3505";
>> +             status = "disabled";
>> +             reg = <0x5c050000 0x4000>;
>> +             interrupts = <24>;
>> +             clocks = <&hecc_ck>;
>> +             ti,scc-ram-offset = <0x3000>;
>> +             ti,hecc-ram-offset = <0x3000>;
>> +             ti,mbx-offset = <0x2000>;
>> +             ti,int-line = <0>;
>> +     };
>> --
>> 2.1.4
>>
