From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/2] ARM: dts: OMAP3: Add GPMC controller
Date: Sat, 16 Feb 2013 17:44:12 +0100
Message-ID: <CABxcv=kDw6pSsdE29-dVqkk2cc-RKBZB6GN8cs+M+C4JEeSbdg@mail.gmail.com>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
	<1359395648-2137-2-git-send-email-florian.vaussard@epfl.ch>
	<CAPjKCR_oh25c4NKUTWjU6BYp64GjPoi2LWDpRhTUkBkRmc_HUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:63055 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab3BPQoT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Feb 2013 11:44:19 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm14so2180856wib.16
        for <linux-omap@vger.kernel.org>; Sat, 16 Feb 2013 08:44:17 -0800 (PST)
In-Reply-To: <CAPjKCR_oh25c4NKUTWjU6BYp64GjPoi2LWDpRhTUkBkRmc_HUw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anil Kumar <anilkumar880@gmail.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

On Sat, Feb 16, 2013 at 2:09 PM, Anil Kumar <anilkumar880@gmail.com> wrote:
> Hi Florian,
>
> On Mon, Jan 28, 2013 at 11:24 PM, Florian Vaussard
> <florian.vaussard@epfl.ch> wrote:
>> Add device-tree support for the GPMC controller on the OMAP3.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>> ---
>>  arch/arm/boot/dts/omap3.dtsi |   11 +++++++++++
>>  1 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
>> index 6c63118..2ddae38 100644
>> --- a/arch/arm/boot/dts/omap3.dtsi
>> +++ b/arch/arm/boot/dts/omap3.dtsi
>> @@ -403,5 +403,16 @@
>>                         ti,timer-alwon;
>>                         ti,timer-secure;
>>                 };
>> +
>> +               gpmc: gpmc@6e000000 {
>> +                       compatible = "ti,omap3430-gpmc";
>> +                       ti,hwmods = "gpmc";
>> +                       reg = <0x6e000000 0x1000000>;
>> +                       interrupts = <20>;
>> +                       gpmc,num-cs = <8>;
>> +                       gpmc,num-waitpins = <4>;
>> +                       #address-cells = <2>;
>> +                       #size-cells = <1>;
>> +               };
>>         };
>>  };
>
> Tested on devkit8000 (omap3 based board)
>
> Please take my Tested-by: Anil Kumar <anilk4.v@gmail.com>
>
> Thanks,
> Anil
>

Hello Tony and Benoit,

Could this patch be merged to one of your branches?

It has already my Reviewed-by and now Anil's Tested-by.

Now that Daniel's OMAP GPMC binding were merged, there seems to be
many people working on adding support on their boards DT for
peripherals connected through the GPMC (NAND, OneNAND, SMSC LAN, etc).

I think it will be easier if people can base their work on top of this
patch instead of duplicating the work and sending the same patch to
add a GPMC device node to omap3.dtsi on each patch-set.

Thanks a lot and best regards,
Javier
