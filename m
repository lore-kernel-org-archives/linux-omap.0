From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP2+: only search for GPMC DT child nodes
 on probe
Date: Wed, 17 Apr 2013 17:33:57 -0500
Message-ID: <516F2355.5080501@ti.com>
References: <1366230852-2440-1-git-send-email-javier.martinez@collabora.co.uk> <516F13B8.20601@ti.com> <516F1DC8.2000707@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42847 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965728Ab3DQWeK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Apr 2013 18:34:10 -0400
In-Reply-To: <516F1DC8.2000707@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Lars Poeschel <poeschel@lemonage.de>, devicetree-discuss@lists.ozlabs.org, linux-omap <linux-omap@vger.kernel.org>


On 04/17/2013 05:10 PM, Javier Martinez Canillas wrote:
> On 04/17/2013 11:27 PM, Jon Hunter wrote:
>>
>> On 04/17/2013 03:34 PM, Javier Martinez Canillas wrote:
>>> The GPMC DT probe function use for_each_node_by_name() to search
>>> child device nodes of the GPMC controller. But this function does
>>> not use the GPMC device node as the root of the search and instead
>>> search across the complete Device Tree.
>>>
>>> This means that any device node on the DT that is using any of the
>>> GPMC child nodes names searched for will be returned even if they
>>> are not connected to the GPMC, making the gpmc_probe_xxx_child()
>>> function to fail.
>>>
>>> Fix this by using the GPMC device node as the search root so the
>>> search will be restricted to its children.
>>>
>>> Reported-by: Lars Poeschel <poeschel@lemonage.de>
>>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>> ---
>>>
>>> Changes since v1 (suggested by Jon Hunter):
>>>   - Split the search for GPMC child nodes and only warn if a
>>>     child probe fails on two different patches
>>>   - Don't probe all childs unnecesary if a previous matched
>>>
>>>  arch/arm/mach-omap2/gpmc.c |   33 ++++++++++-----------------------
>>>  1 files changed, 10 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
>>> index ed946df..6166847 100644
>>> --- a/arch/arm/mach-omap2/gpmc.c
>>> +++ b/arch/arm/mach-omap2/gpmc.c
>>> @@ -1520,32 +1520,19 @@ static int gpmc_probe_dt(struct platform_device *pdev)
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
>>> +	for_each_child_of_node(pdev->dev.of_node, child) {
>>>  
>>> -	for_each_node_by_name(child, "onenand") {
>>> -		ret = gpmc_probe_onenand_child(pdev, child);
>>> -		if (ret < 0) {
>>> -			of_node_put(child);
>>> -			return ret;
>>> -		}
>>> -	}
>>> +		if (!child->name)
>>> +			continue;
>>>  
>>> -	for_each_node_by_name(child, "nor") {
>>> -		ret = gpmc_probe_generic_child(pdev, child);
>>> -		if (ret < 0) {
>>> -			of_node_put(child);
>>> -			return ret;
>>> -		}
>>> -	}
>>> +		if (of_node_cmp(child->name, "nand") == 0)
>>> +			ret = gpmc_probe_nand_child(pdev, child);
>>> +		else if (of_node_cmp(child->name, "onenand") == 0)
>>> +			ret = gpmc_probe_onenand_child(pdev, child);
>>> +		else if (of_node_cmp(child->name, "ethernet") == 0 ||
>>> +			 of_node_cmp(child->name, "nor") == 0)
>>> +			ret = gpmc_probe_generic_child(pdev, child);
>>>  
>>> -	for_each_node_by_name(child, "ethernet") {
>>> -		ret = gpmc_probe_generic_child(pdev, child);
>>>  		if (ret < 0) {
>>
>> I think that we need to make sure that "ret" is initialised to 0 at the
>> beginning of the function. We should not have a case where the child
> 
> Hi Jon,
> 
> I didn't set ret  to 0 at the beginning of the function since it is assigned the
> return value of a previous call to of_property_read_u32(). So ret should be 0
> when execution reaches the for loop.

Yes you are right, I overlooked that.

>> name does not match but who knows. Actually that raises another point,
>> should we have an "else" clause at the end that WARNs on
>> "unknown/unsupported child" device?
>>
> 
> Actually I thought about it when I was writing that patch and then I decided to
> not add a WARN for that case since nothing really fail in that case.
> 
> I mean if we want to check that a DT is well formed then I think we will need to
> add much more checks and I don't know if is worth it.
> 
> But I don't have a strong opinion on this so if you want I can add it an send a v3.

Ok, that's fine. I am happy with this version, so no need then to re-do.

Cheers
Jon
