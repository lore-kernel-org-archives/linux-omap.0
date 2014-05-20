From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] ARM: OMAP2+: gpmc: enable wait-pin monitoring for NAND
 devices via DT
Date: Tue, 20 May 2014 10:34:34 +0200
Message-ID: <CABxcv=k_6gk2QhZj3LVaNgPkg7HnSwfskgJa3y7ORDSFZNRcmA@mail.gmail.com>
References: <1400567064-20033-1-git-send-email-pekon@ti.com>
	<537B0803.6070702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <537B0803.6070702-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 20, 2014 at 9:45 AM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> Hi Pekon,
>
> On 05/20/2014 09:24 AM, Pekon Gupta wrote:
>> This patch enables 'wait-pin' monitoring in NAND driver if following properties
>> are present under NAND DT node
>>   gpmc,wait-pin = <wait-pin number>
>>   gpmc,wait-on-read
>>   gpmc,wait-on-write
>> As NAND generic framework uses common path nand_chip->dev_ready() for monitoring
>> completion of Read and Write status, so wait-pin monitoring is enabled only when
>> *both* 'gpmc,wait-on-read' and 'gpmc,wait-on-write' are specified.
>>
>> CC: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Signed-off-by: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/mtd/gpmc-nand.txt | 8 ++++++++
>>  arch/arm/mach-omap2/gpmc-nand.c                     | 8 +++++---
>>  2 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> index eb81435..4039032 100644
>> --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> @@ -45,6 +45,14 @@ Optional properties:
>>               ELM hardware engines should specify this device node in .dtsi
>>               Using ELM for ECC error correction frees some CPU cycles.
>>
>> + - gpmc,wait-pin=<pin number>        Specifies GPMC wait-pin number to monitor
>> + - gpmc,wait-on-read         Enable wait-pin monitoring for Read accesses
>> + - gpmc,wait-on-write                Enable wait-pin monitoring for Write accesses
>> +             As NAND generic framework uses single common function
>> +             nand_chip->dev_ready() for polling wait-pin both for Read and
>> +             Write accesses. So for NAND devices both 'gpmc,wait-on-read' and
>> +             'gpmc,wait-on-write' need to be specified together.
>> +
>>  For inline partiton table parsing (optional):
>>

Pekon,

Please do not add Linux specific information in Device Tree binding
documents. Remember that DT are meant to be used by any operating
system that implements DT parsing so we should not leak Linux
implementation details in the documents. They should just describe the
hardware and how each property configures it.

In fact Device Tree source files and documents will be split from the
kernel repository in the future to make this more clear.

>
>
>>   - #address-cells: should be set to 1
>> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
>> index 17cd393..62bc3de 100644
>> --- a/arch/arm/mach-omap2/gpmc-nand.c
>> +++ b/arch/arm/mach-omap2/gpmc-nand.c
>> @@ -123,11 +123,13 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
>>               }
>>       }
>>
>> -     if (gpmc_nand_data->of_node)
>> +     if (gpmc_nand_data->of_node) {
>>               gpmc_read_settings_dt(gpmc_nand_data->of_node, &s);
>> -     else
>> +             if (s.wait_on_read && s.wait_on_write)
>> +                     gpmc_nand_data->dev_ready = true;
>> +     } else {
>>               gpmc_set_legacy(gpmc_nand_data, &s);
>> -
>> +     }
>>       s.device_nand = true;
>
> NACK.
>
> For NAND, we only need the wait-pin property. The wait-on-read/wait-on-write flags are meaningless.
> Also, the wait-pin number needs to be communicated to the NAND driver and omap_dev_ready() function updated so that it checks for the right wait pin status.
>

Thanks a lot for your explanations Roger.

>>
>>       err = gpmc_cs_program_settings(gpmc_nand_data->cs, &s);
>>
>
> cheers,
> -roger

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
