From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/9] regulator: lp873x: Add support for populating input
 supply
Date: Wed, 19 Oct 2016 10:20:59 +0530
Message-ID: <57988545-4319-0bcf-df1a-55c78111aa5b@ti.com>
References: <20161014130033.14172-1-lokeshvutla@ti.com>
 <20161014130033.14172-5-lokeshvutla@ti.com>
 <20161018142743.xfgjuaw4wlssmoxq@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161018142743.xfgjuaw4wlssmoxq@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On Tuesday 18 October 2016 07:57 PM, Rob Herring wrote:
> On Fri, Oct 14, 2016 at 06:30:28PM +0530, Lokesh Vutla wrote:
>> In order to have a proper topology of regulators for a platform, each
>> registering regulator needs to populate supply_name field for identifying
>> its supply's name. Add supply_name field for lp873x regulators.
>>
>> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/mfd/lp873x.txt | 8 ++++++++
>>  drivers/regulator/lp873x-regulator.c             | 1 +
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt b/Documentation/devicetree/bindings/mfd/lp873x.txt
>> index 52766c2..936cba3 100644
>> --- a/Documentation/devicetree/bindings/mfd/lp873x.txt
>> +++ b/Documentation/devicetree/bindings/mfd/lp873x.txt
>> @@ -7,6 +7,9 @@ Required properties:
>>    - #gpio-cells:	Should be two.  The first cell is the pin number and
>>  			the second cell is used to specify flags.
>>  			See ../gpio/gpio.txt for more information.
>> +  - xxx-supply:		Phandle to parent supply node of each regulator
>> +			populated under regulators node. xxx should match
>> +			the supply_name populated in driver.
> 
> xxx-in-supply?

Oops. Right. Ill update it and repost.

Thanks and regards,
Lokesh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
