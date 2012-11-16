From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/4] regulator: fixed: Properly use input_supply parameter
 from device tree
Date: Fri, 16 Nov 2012 12:23:43 +0200
Message-ID: <50A6142F.1070404@ti.com>
References: <1352991396-19589-1-git-send-email-rogerq@ti.com> <1352991396-19589-5-git-send-email-rogerq@ti.com> <50A53E7F.6070705@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50A53E7F.6070705-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "b-cousson-l0cyMroinI0@public.gmane.org" <b-cousson-l0cyMroinI0@public.gmane.org>, "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "keshava_mgowda-l0cyMroinI0@public.gmane.org" <keshava_mgowda-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 11/15/2012 09:11 PM, Laxman Dewangan wrote:
> On 11/15/2012 09:56 AM, Roger Quadros wrote:
>> The device tree node will provide the input supply name as
>> a string. Use that to populate the supply_name parameter of
>> the regulator descriptor.
>>
>> Also correct the documentation to reflect the same.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> CC: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> CC: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
>> ---
>>           regulator-boot-on;
>>           gpio-open-drain;
>> -        vin-supply = <&parent_reg>;
>> +        vin-supply = "input-supply-name";
> 
> This is not correct as per the regulator binding. It says
>  - <name>-supply: phandle to the parent supply/regulator node
> 
> So we need to pass the phandle rather than string.
> 

If you see of_get_fixed_voltage_config() in drivers/regulator/fixed.c,
all it does (without my patch) is

	if (of_find_property(np, "vin-supply", NULL))
		config->input_supply = "vin";

How is this supposed to work? How does phandle supplied in vin-supply
map to config->input_supply?

This config->input_supply is a string which is used in
reg_fixed_voltage_probe() like below

      if (config->input_supply) {
               drvdata->desc.supply_name = kstrdup(config->input_supply,
                                                        GFP_KERNEL);

So I don't understand how supplying phandle would work. Maybe I missed
something?

> Just for curiosity, why do you want this change? What is the issue are
> you facing.
>

Because I could not understood how the original approach would work. But
if you can explain how it works maybe my patch is redundant.

> This change will creates regression on many platform.
> 

Did you test your platform on 3.7-rc5?

regards,
-roger

> 
> -----------------------------------------------------------------------------------
> 
> This email message is for the sole use of the intended recipient(s) and
> may contain
> confidential information.  Any unauthorized review, use, disclosure or
> distribution
> is prohibited.  If you are not the intended recipient, please contact
> the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
