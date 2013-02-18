From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: OMAP3: Add GPMC controller
Date: Mon, 18 Feb 2013 13:26:24 +0100
Message-ID: <51221DF0.2050705@ti.com>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch> <1359395648-2137-2-git-send-email-florian.vaussard@epfl.ch> <CAPjKCR_oh25c4NKUTWjU6BYp64GjPoi2LWDpRhTUkBkRmc_HUw@mail.gmail.com> <CABxcv=kDw6pSsdE29-dVqkk2cc-RKBZB6GN8cs+M+C4JEeSbdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54962 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426Ab3BRM0m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 07:26:42 -0500
In-Reply-To: <CABxcv=kDw6pSsdE29-dVqkk2cc-RKBZB6GN8cs+M+C4JEeSbdg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Anil Kumar <anilkumar880@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Hi Javier,

On 2/16/2013 5:44 PM, Javier Martinez Canillas wrote:
> On Sat, Feb 16, 2013 at 2:09 PM, Anil Kumar <anilkumar880@gmail.com> wrote:
>> Hi Florian,
>>
>> On Mon, Jan 28, 2013 at 11:24 PM, Florian Vaussard
>> <florian.vaussard@epfl.ch> wrote:
>>> Add device-tree support for the GPMC controller on the OMAP3.
>>>
>>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>>> ---
>>>   arch/arm/boot/dts/omap3.dtsi |   11 +++++++++++
>>>   1 files changed, 11 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
>>> index 6c63118..2ddae38 100644
>>> --- a/arch/arm/boot/dts/omap3.dtsi
>>> +++ b/arch/arm/boot/dts/omap3.dtsi
>>> @@ -403,5 +403,16 @@
>>>                          ti,timer-alwon;
>>>                          ti,timer-secure;
>>>                  };
>>> +
>>> +               gpmc: gpmc@6e000000 {
>>> +                       compatible = "ti,omap3430-gpmc";
>>> +                       ti,hwmods = "gpmc";
>>> +                       reg = <0x6e000000 0x1000000>;
>>> +                       interrupts = <20>;
>>> +                       gpmc,num-cs = <8>;
>>> +                       gpmc,num-waitpins = <4>;
>>> +                       #address-cells = <2>;
>>> +                       #size-cells = <1>;
>>> +               };
>>>          };
>>>   };
>>
>> Tested on devkit8000 (omap3 based board)
>>
>> Please take my Tested-by: Anil Kumar <anilk4.v@gmail.com>
>>
>> Thanks,
>> Anil
>>
>
> Hello Tony and Benoit,
>
> Could this patch be merged to one of your branches?

I'll take it.

> It has already my Reviewed-by and now Anil's Tested-by.
>
> Now that Daniel's OMAP GPMC binding were merged, there seems to be
> many people working on adding support on their boards DT for
> peripherals connected through the GPMC (NAND, OneNAND, SMSC LAN, etc).
>
> I think it will be easier if people can base their work on top of this
> patch instead of duplicating the work and sending the same patch to
> add a GPMC device node to omap3.dtsi on each patch-set.

Regards,
Benoit

