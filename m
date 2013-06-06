From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource
 flags
Date: Thu, 06 Jun 2013 10:47:55 +0200
Message-ID: <51B04CBB.1000405@collabora.co.uk>
References: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk> <20130605233422.3D6DE3E10E4@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:36104 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932240Ab3FFIsL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jun 2013 04:48:11 -0400
In-Reply-To: <20130605233422.3D6DE3E10E4@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: jgchunter@gmail.com, Rob Herring <rob.herring@calxeda.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@nvidia.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On 06/06/2013 01:34 AM, Grant Likely wrote:
> On Fri,  5 Apr 2013 09:48:08 +0200, Javier Martinez Canillas <javier.martinez@collabora.co.uk> wrote:
> [...]
>> irq_of_parse_and_map() calls to irq_create_of_mapping() which calls to
>> the correct xlate function handler according to "#interrupt-cells"
>> (irq_domain_xlate_onecell or irq_domain_xlate_twocell) and to
>> irq_set_irq_type() to set the IRQ type.
>> 
>> But the type is never returned so it can't be saved on the IRQ struct
>> resource flags member.
>> 
>> This means that drivers that need the IRQ type/level flags defined in
>> the DT won't be able to get it.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> [...]
>> diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
>> index 535cecf..98aec57 100644
>> --- a/include/linux/of_irq.h
>> +++ b/include/linux/of_irq.h
>> @@ -66,6 +66,10 @@ extern int of_irq_map_one(struct device_node *device, int index,
>>  extern unsigned int irq_create_of_mapping(struct device_node *controller,
>>  					  const u32 *intspec,
>>  					  unsigned int intsize);
>> +extern unsigned int irq_create_of_mapping_type(struct device_node *controller,
>> +					       const u32 *intspec,
>> +					       unsigned int intsize,
>> +					       unsigned int *otype);

Hi Grant, thanks a lot for your feedback.

> 
> I count 11 users of irq_create_of_mapping(). That's a managable number
> to update.

Yes, but since of_irq_to_resource() doesn't call irq_create_of_mapping()
directly but it does though irq_of_parse_and_map(), then this function signature
has to be modified too.

I'm counting 223 users of irq_of_parse_and_map() so the change is not that small
anymore. Another approach is to call of_irq_map_one() and
irq_create_of_mapping() directly from of_irq_to_resource() instead of using
irq_of_parse_and_map() but I don't like that...

> Instead of creating a new function, please modify the
> existing one and split it off into a separate patch.

But that won't break git bisect-ability? or do you mean to first just change the
functions signatures by adding an argument and update its users and then in a
separate patch do the actual change to the functions to store the IRQ?

> Otherwise the patch looks fine to me.
> 
> g.
> 

Best regards,
Javier
