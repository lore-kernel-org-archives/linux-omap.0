From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v2] ARM: OMAP2+: gpmc: enable wait-pin monitoring for NAND
 devices via DT
Date: Tue, 20 May 2014 11:24:23 +0200
Message-ID: <CABxcv=ngns6J8iRfqaJohRP9oXF-6YoM=N5fMkn1nRz0aVqQ+g@mail.gmail.com>
References: <1400567064-20033-1-git-send-email-pekon@ti.com>
	<537B0803.6070702@ti.com>
	<20980858CB6D3A4BAE95CA194937D5E73EACE5C0@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:36699 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbaETJYY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 05:24:24 -0400
Received: by mail-we0-f176.google.com with SMTP id q59so201505wes.21
        for <linux-omap@vger.kernel.org>; Tue, 20 May 2014 02:24:23 -0700 (PDT)
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EACE5C0@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "Quadros, Roger" <rogerq@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hello Pekon,

On Tue, May 20, 2014 at 10:46 AM, Gupta, Pekon <pekon@ti.com> wrote:
> Hi Roger,
>
> From: Quadros, Roger
>>On 05/20/2014 09:24 AM, Pekon Gupta wrote:
>>> This patch enables 'wait-pin' monitoring in NAND driver if following properties
>>> are present under NAND DT node
>>>   gpmc,wait-pin = <wait-pin number>
>>>   gpmc,wait-on-read
>>>   gpmc,wait-on-write
>>> As NAND generic framework uses common path nand_chip->dev_ready() for monitoring
>>> completion of Read and Write status, so wait-pin monitoring is enabled only when
>>> *both* 'gpmc,wait-on-read' and 'gpmc,wait-on-write' are specified.
>>>
>>> CC: devicetree@vger.kernel.org
>>> Signed-off-by: Pekon Gupta <pekon@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/mtd/gpmc-nand.txt | 8 ++++++++
>>>  arch/arm/mach-omap2/gpmc-nand.c                     | 8 +++++---
>>>  2 files changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>>b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>>> index eb81435..4039032 100644
>>> --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>>> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>>> @@ -45,6 +45,14 @@ Optional properties:
>>>              ELM hardware engines should specify this device node in .dtsi
>>>              Using ELM for ECC error correction frees some CPU cycles.
>>>
>>> + - gpmc,wait-pin=<pin number>       Specifies GPMC wait-pin number to monitor
>>> + - gpmc,wait-on-read                Enable wait-pin monitoring for Read accesses
>>> + - gpmc,wait-on-write               Enable wait-pin monitoring for Write accesses
>>> +            As NAND generic framework uses single common function
>>> +            nand_chip->dev_ready() for polling wait-pin both for Read and
>>> +            Write accesses. So for NAND devices both 'gpmc,wait-on-read' and
>>> +            'gpmc,wait-on-write' need to be specified together.
>>> +
>>>  For inline partiton table parsing (optional):
>>>
>>
>>
>>>   - #address-cells: should be set to 1
>>> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
>>> index 17cd393..62bc3de 100644
>>> --- a/arch/arm/mach-omap2/gpmc-nand.c
>>> +++ b/arch/arm/mach-omap2/gpmc-nand.c
>>> @@ -123,11 +123,13 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
>>>              }
>>>      }
>>>
>>> -    if (gpmc_nand_data->of_node)
>>> +    if (gpmc_nand_data->of_node) {
>>>              gpmc_read_settings_dt(gpmc_nand_data->of_node, &s);
>>> -    else
>>> +            if (s.wait_on_read && s.wait_on_write)
>>> +                    gpmc_nand_data->dev_ready = true;
>>> +    } else {
>>>              gpmc_set_legacy(gpmc_nand_data, &s);
>>> -
>>> +    }
>>>      s.device_nand = true;
>>
>>NACK.
>>
>>For NAND, we only need the wait-pin property. The wait-on-read/wait-on-write flags are meaningless.
>
> There is a check in arch/arm/mach-omap2/gpmc.c : @@gpmc_read_settings_dt()
> which expects at-least one of the 'gpmc,wait-on-read' or 'gpmc,wait-on-write' to be enabled.
>         if (!p->wait_on_read && !p->wait_on_write)
>                         pr_warn("%s: read/write wait monitoring not enabled!\n",
>                                 __func__);
>

Note that this does not check that you should have at least one of
"gpmc,wait-on-read" or "gpmc,wait-on-write" like you said but expects
both read an write to be enabled since is an && operator and not an
||.

> And gpmc_read_settings_dt() is common for all GPMC devices (NAND, NOR, .. )
> Now, if you remove that check it means you are deviating from the behavior of
> DT binding, so you need to be backward compatible.
> In practice, I agree that a single gpmc,wait-pin binding was enough to both
> - Select the wait-pin
> - Enable wait-pin monitoring for GPMC devices.

I'm confused, I asked exactly this question yesterday and you said the opposite:

    On Mon, May 19, 2014 at 5:00 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
    > So my question is, it's a requirement and these 3 properties need to
    > always be defined together?  If that is the case then I wonder why
    > there are 3 different properties and why not just defining
    > "gpmc,wait-pin" implies "gpmc,wait-on-{read,write}" ?

> But now as we have two extra bindings, you have to maintain backward compatibility.
>

Not really, being backward compatible means that you have to be sure
that old DTB will continue to be working with newer kernels in case a
platform has the DTB on read-only memory or can't be updated.

Removing "gpmc,wait-on-read" and "gpmc,wait-on-write" if they don't
make sense is totally acceptable. Old DTB will still have these
properties but just won't be parsed by the driver.

> If you have better solution, then please send a patch, I'll be happy to test it.
>
>
>>Also, the wait-pin number needs to be communicated to the NAND driver and omap_dev_ready()
>>function updated so that it checks for the right wait pin status.
>>
> Yes, that's true.
> And this was my plan to have it as separate patch.
> Also, the real benefit of wait-pin monitoring will be seen only
> when its implemented as IRQ source. [1]
>

Not related with $subject but I think that the GPMC driver needs a
really big refactoring. It's full of ad-hoc logic for parsing DT
properties for each child device type and it has becoming a
maintenance nightmare.

It would be better to have some sort of GPMC framework that would do
any generic GPMC setup and export an interface that can be used by
child devices drivers in case they need any custom configuration but
still have sane defaults if there is no need for special handling.

By looking at the driver it seems that gpmc_probe_nand_child() has
some similarities with gpmc_probe_onenand_child() and there are
already other kind of devices that use a generic
gpmc_probe_generic_child(). So I think this should be doable.

Sorry for hijacking the thread but I thought it was worth mentioning.

>
> with regards, pekon
>
> [1] http://www.spinics.net/lists/linux-omap/msg107236.html

Best regards,
Javier
