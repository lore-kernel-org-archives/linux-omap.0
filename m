From: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2] ARM: OMAP2+: gpmc: enable wait-pin monitoring for
 NAND devices via DT
Date: Tue, 20 May 2014 08:46:08 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EACE5C0@DBDE04.ent.ti.com>
References: <1400567064-20033-1-git-send-email-pekon@ti.com>
 <537B0803.6070702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <537B0803.6070702-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Quadros, Roger" <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger,

From: Quadros, Roger
>On 05/20/2014 09:24 AM, Pekon Gupta wrote:
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
>> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> index eb81435..4039032 100644
>> --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> @@ -45,6 +45,14 @@ Optional properties:
>>  		ELM hardware engines should specify this device node in .dtsi
>>  		Using ELM for ECC error correction frees some CPU cycles.
>>
>> + - gpmc,wait-pin=<pin number>	Specifies GPMC wait-pin number to monitor
>> + - gpmc,wait-on-read		Enable wait-pin monitoring for Read accesses
>> + - gpmc,wait-on-write		Enable wait-pin monitoring for Write accesses
>> +		As NAND generic framework uses single common function
>> +		nand_chip->dev_ready() for polling wait-pin both for Read and
>> +		Write accesses. So for NAND devices both 'gpmc,wait-on-read' and
>> +		'gpmc,wait-on-write' need to be specified together.
>> +
>>  For inline partiton table parsing (optional):
>>
>
>
>>   - #address-cells: should be set to 1
>> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
>> index 17cd393..62bc3de 100644
>> --- a/arch/arm/mach-omap2/gpmc-nand.c
>> +++ b/arch/arm/mach-omap2/gpmc-nand.c
>> @@ -123,11 +123,13 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
>>  		}
>>  	}
>>
>> -	if (gpmc_nand_data->of_node)
>> +	if (gpmc_nand_data->of_node) {
>>  		gpmc_read_settings_dt(gpmc_nand_data->of_node, &s);
>> -	else
>> +		if (s.wait_on_read && s.wait_on_write)
>> +			gpmc_nand_data->dev_ready = true;
>> +	} else {
>>  		gpmc_set_legacy(gpmc_nand_data, &s);
>> -
>> +	}
>>  	s.device_nand = true;
>
>NACK.
>
>For NAND, we only need the wait-pin property. The wait-on-read/wait-on-write flags are meaningless.

There is a check in arch/arm/mach-omap2/gpmc.c : @@gpmc_read_settings_dt()
which expects at-least one of the 'gpmc,wait-on-read' or 'gpmc,wait-on-write' to be enabled.
	if (!p->wait_on_read && !p->wait_on_write)
			pr_warn("%s: read/write wait monitoring not enabled!\n",
				__func__);

And gpmc_read_settings_dt() is common for all GPMC devices (NAND, NOR, .. )
Now, if you remove that check it means you are deviating from the behavior of
DT binding, so you need to be backward compatible.
In practice, I agree that a single gpmc,wait-pin binding was enough to both
- Select the wait-pin
- Enable wait-pin monitoring for GPMC devices.
But now as we have two extra bindings, you have to maintain backward compatibility.

If you have better solution, then please send a patch, I'll be happy to test it.


>Also, the wait-pin number needs to be communicated to the NAND driver and omap_dev_ready()
>function updated so that it checks for the right wait pin status.
>
Yes, that's true.
And this was my plan to have it as separate patch.
Also, the real benefit of wait-pin monitoring will be seen only
when its implemented as IRQ source. [1]


with regards, pekon

[1] http://www.spinics.net/lists/linux-omap/msg107236.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
