From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCHv6] arm/dts: omap4-sdp: Add keypad data
Date: Fri, 20 Jul 2012 14:04:07 +0530
Message-ID: <CAKdam57Q0aYjN3+SBYZEaRQvXxEogSaQi4Un9NJh8614wz_E-A@mail.gmail.com>
References: <1342191422-8235-1-git-send-email-sourav.poddar@ti.com>
	<CAAe_U6LXB0EdBqG+=W+zKjtZ1av-UWpxJDZSrSOcb4_fNp9gDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:60973 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752007Ab2GTIeK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 04:34:10 -0400
Received: by bkwj10 with SMTP id j10so2947280bkw.5
        for <linux-omap@vger.kernel.org>; Fri, 20 Jul 2012 01:34:07 -0700 (PDT)
In-Reply-To: <CAAe_U6LXB0EdBqG+=W+zKjtZ1av-UWpxJDZSrSOcb4_fNp9gDg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>

Hi Kishon,

On Thu, Jul 19, 2012 at 5:04 PM, ABRAHAM, KISHON VIJAY <kishon@ti.com> wrote:
> Hi,
>
> On Fri, Jul 13, 2012 at 8:27 PM, Sourav Poddar <sourav.poddar@ti.com> wrote:
>> Add keypad data node in omap4 device tree file.
>> Also fill the device tree binding parameters
>> with the required value in "omap4-sdp" dts file.
>>
>> Tested on omap4430 sdp with 3.5-rc6 kernel.
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> ---
>> This patch[1] was initially posted as a series.
>> The first patch[2] of the series is taken into
>> dmitry's input tree.
>> So, posting this as a independent patch .
>>
>> [1]: https://lkml.org/lkml/2012/6/8/239
>> [2]: https://lkml.org/lkml/2012/6/1/75
>>
>> Changes since v5:
>> Few key mappings were missed, added "linux, keymap"
>> data for those key mappings.
>>
>>  arch/arm/boot/dts/omap4-sdp.dts |   70 +++++++++++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/omap4.dtsi    |    5 +++
>>  2 files changed, 75 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
>> index d08c4d1..53ded54 100644
>> --- a/arch/arm/boot/dts/omap4-sdp.dts
>> +++ b/arch/arm/boot/dts/omap4-sdp.dts
>> @@ -70,6 +70,76 @@
>>                         gpios = <&gpio5 11 0>; /* 139 */
>>                 };
>>         };
>> +
>> +       keypad@4a31c000 {
>
> I think you should drop the address in node name since it does not
> have a <reg> property.
>
Ok. Will fix it and post a new version.
>> +               keypad,num-rows = <8>;
>> +               keypad,num-columns = <8>;
>> +               linux,keymap = < 0x00000012
>> +                       0x00010013
>> +                       0x00020014
>> +                       0x00030066
>> +                       0x0004003f
>> +                       0x000500f0
>> +                       0x00060017
>> +                       0x0007002a
>> +                       0x01000020
>> +                       0x01010021
>> +                       0x01020022
>> +                       0x010300e7
>> +                       0x01040040
>> +                       0x010500f0
>> +                       0x01060025
>> +                       0x0107001c
>> +                       0x0200002d
>> +                       0x0201002e
>> +                       0x0202002f
>> +                       0x0203006b
>> +                       0x02040041
>> +                       0x020500f0
>> +                       0x02060034
>> +                       0x0207003a
>> +                       0x0300002c
>> +                       0x0301004e
>> +                       0x03020030
>> +                       0x0303003b
>> +                       0x03040042
>> +                       0x030500f0
>> +                       0x03060018
>> +                       0x03070039
>> +                       0x04000011
>> +                       0x04010015
>> +                       0x04020016
>> +                       0x0403003c
>> +                       0x04040073
>> +                       0x040500f0
>> +                       0x04060026
>> +                       0x04070069
>> +                       0x0500001f
>> +                       0x05010023
>> +                       0x05020024
>> +                       0x0503003d
>> +                       0x05040043
>> +                       0x05050072
>> +                       0x05060032
>> +                       0x0507006a
>> +                       0x06000010
>> +                       0x0601001e
>> +                       0x06020031
>> +                       0x0603009e
>> +                       0x0604000e
>> +                       0x060500f0
>> +                       0x06060019
>> +                       0x06070067
>> +                       0x07000094
>> +                       0x07010095
>> +                       0x070200ca
>> +                       0x070300cb
>> +                       0x0704003e
>> +                       0x070500f0
>> +                       0x07060160
>> +                       0x0707006c >;
>> +               linux,input-no-autorepeat;
>> +       };
>>  };
>>
>>  &i2c1 {
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 359c497..11b72d2 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -273,4 +273,9 @@
>>                         ti,needs-special-reset;
>>                 };
>>         };
>> +
>> +       keypad@4a31c000 {
> same comment here.
>
Ok.
>> +               compatible = "ti,omap4-keypad";
>> +               ti,hwmods = "kbd";
>> +       };
>>  };
>
> Thanks

~Sourav
> Kishon
