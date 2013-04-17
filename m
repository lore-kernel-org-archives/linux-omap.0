From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v3 3/3] ARM: OMAP2+: Add GPMC DT support for Ethernet
 child nodes
Date: Wed, 17 Apr 2013 13:33:07 -0500
Message-ID: <516EEAE3.5060007@ti.com>
References: <1363298051-24574-1-git-send-email-javier.martinez@collabora.co.uk> <201304171140.52529.poeschel@lemonage.de> <516E9026.8070804@collabora.co.uk> <516EA838.3010003@ti.com> <516EACBB.9020607@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45695 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754914Ab3DQSd2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Apr 2013 14:33:28 -0400
In-Reply-To: <516EACBB.9020607@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Lars Poeschel <poeschel@lemonage.de>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org


On 04/17/2013 09:07 AM, Javier Martinez Canillas wrote:
> On 04/17/2013 03:48 PM, Jon Hunter wrote:
>>
>> On 04/17/2013 07:05 AM, Javier Martinez Canillas wrote:
>>
>> ...
>>
>>> Yes, in fact I just realized that for_each_node_by_name() expand to:
>>>
>>> #define for_each_node_by_name(dn, name) \
>>>         for (dn = of_find_node_by_name(NULL, name); dn; \
>>>              dn = of_find_node_by_name(dn, name))
>>>
>>> which means that it will search for a node with "name" on the complete
>>> DeviceTree and this is wrong. It should only search on GPMC childs.
>>
>> Good catch. I guess we could have flash & ethernet devices connected to
>> other interfaces such as SPI.
>>
> 
> Yes, in fact this is the case for omap4-sdp.dts which has an ethernet controller
> connected through SPI:
> 
> &mcspi1 {
>         eth@0 {
>                 compatible = "ks8851";
>                 spi-max-frequency = <24000000>;
>                 reg = <0>;
>                 interrupt-parent = <&gpio2>;
>                 interrupts = <2>; /* gpio line 34 */
>                 vdd-supply = <&vdd_eth>;
>         };
> };
> 
> it just didn't fail because the device node name is "eth" and not "ethernet".

Yes we got lucky here or unlucky as this would have tripped us up
earlier ;-)

> which makes me wonder if is OK to rely on a device node name or we should use
> compatible properties instead such as "ti,gpmc-{eth,nand,nor,onenand}" and do
> something like:
> 
> for_each_compatible_node(pdev->dev.of_node, NULL, "ti,gpmc-eth") and so on.

Yes I was wondering about that too. However, it does seem simpler to
just search through the child devices and that would be an easier fix.

>>> Could you please test the following patch? If it works for you I'll add a proper
>>> description and submit it as a PATCH.
>>>
>>> Thanks a lot and best regards,
>>> Javier
>>>
>>> From d8dab9ae9a0284f17553875c2fddd806d9f6ab2e Mon Sep 17 00:00:00 2001
>>> From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>> Date: Wed, 17 Apr 2013 13:50:30 +0200
>>> Subject: [PATCH] ARM: OMAP2+: only search for GPMC DT child nodes on
>>>  probe
>>>
>>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>> ---
>>>  arch/arm/mach-omap2/gpmc.c |   51 ++++++++++++++++++++-----------------------
>>>  1 files changed, 24 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
>>> index ed946df..58e2415 100644
>>> --- a/arch/arm/mach-omap2/gpmc.c
>>> +++ b/arch/arm/mach-omap2/gpmc.c
>>> @@ -1520,35 +1520,32 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>>>  		return ret;
>>>  	}
>>>
>>> -	for_each_node_by_name(child, "nand") {
>>> -		ret = gpmc_probe_nand_child(pdev, child);
>>> -		if (ret < 0) {
>>> -			of_node_put(child);
>>> -			return ret;
>>> -		}
>>> -	}
>>> -
>>> -	for_each_node_by_name(child, "onenand") {
>>> -		ret = gpmc_probe_onenand_child(pdev, child);
>>> -		if (ret < 0) {
>>> -			of_node_put(child);
>>> -			return ret;
>>> -		}
>>> -	}
>>> +	for_each_child_of_node(pdev->dev.of_node, child) {
>>> +		if (child->name) {
>>
>> Minor nit ... how about ...
>>
>> +		if (!child->name)
>> 			continue;
>>
> 
> Yes, much better. I just cooked a quick patch so Lars could test it ;-)
>  		
>>> +			if (of_node_cmp(child->name, "nand") == 0) {
>>> +				ret = gpmc_probe_nand_child(pdev, child);
>>> +				if (ret < 0) {
>>> +					of_node_put(child);
>>> +					return ret;
>>> +				}
>>> +			}
>>>
>>> -	for_each_node_by_name(child, "nor") {
>>> -		ret = gpmc_probe_generic_child(pdev, child);
>>> -		if (ret < 0) {
>>> -			of_node_put(child);
>>> -			return ret;
>>> -		}
>>> -	}
>>> +			if (of_node_cmp(child->name, "onenand") == 0) {
>>> +				ret = gpmc_probe_onenand_child(pdev, child);
>>> +				if (ret < 0) {
>>> +					of_node_put(child);
>>> +					return ret;
>>> +				}
>>> +			}
>>>
>>> -	for_each_node_by_name(child, "ethernet") {
>>> -		ret = gpmc_probe_generic_child(pdev, child);
>>> -		if (ret < 0) {
>>> -			of_node_put(child);
>>> -			return ret;
>>> +			if (of_node_cmp(child->name, "ethernet") == 0 ||
>>> +			    of_node_cmp(child->name, "nor") == 0) {
>>> +				ret = gpmc_probe_generic_child(pdev, child);
>>> +				if (ret < 0) {
>>> +					of_node_put(child);
>>> +					return ret;
>>> +				}
>>> +			}
>>>  		}
>>>  	}
>>
>> I am also wondering if the probe should fail if one of its children
>> fails. The panic that Lars reported occurred because the nand
>> successfully probed and so the nand device was registered, but because
>> the ethernet device probe failed, the gpmc probe fails, and then when
>> the nand device is probed by the mtd driver the kernel panics. I wonder
>> if it would be better to WARN on child devices that fail to probe but
>> not return error from the gpmc probe.
>>
> 
> I wonder the same. Probably is better to just WARN so a user could at lest use
> some of the peripherals connected to the GPMC. This is specially important for
> flash memory devices since the rootfs could have to be mounted from there.
> 
> Do you want me to split the child node search and the WARN_ON() replacement in
> two different patchs or should I send both changes in one patch?

Probably best to make these two separate patches as I think that will be
clearer.

Cheers
Jon
