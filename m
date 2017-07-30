From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/8] ARM: OMAP2+: board-generic: add support for dra76x
 family
Date: Sun, 30 Jul 2017 16:49:32 +0530
Message-ID: <f0d5b151-c699-c683-97ce-d6689135e3ac@ti.com>
References: <20170718195503.1700-1-lokeshvutla@ti.com>
 <20170718195503.1700-2-lokeshvutla@ti.com>
 <20170724190236.k3xbxrmgdfc5nogj@rob-hp-laptop>
 <5fcdf90c-4630-0834-ff09-46339dce90f6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5fcdf90c-4630-0834-ff09-46339dce90f6-l0cyMroinI0@public.gmane.org>
Content-Language: en-GB
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Praneeth Bajjuri <praneeth-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Rob,

On 7/25/2017 12:10 PM, Lokesh Vutla wrote:
> 
> 
> On 7/25/2017 12:32 AM, Rob Herring wrote:
>> On Wed, Jul 19, 2017 at 01:24:56AM +0530, Lokesh Vutla wrote:
>>> Adding board generic support for dra76 family.
>>>
>>> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
>>> ---
>>>  Documentation/devicetree/bindings/arm/omap/omap.txt | 3 +++
>>>  arch/arm/mach-omap2/board-generic.c                 | 1 +
>>>  2 files changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
>>> index 8219b2c6bb29..ffe02755a285 100644
>>> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
>>> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
>>> @@ -80,6 +80,9 @@ SoCs:
>>>  - OMAP5432
>>>    compatible = "ti,omap5432", "ti,omap5"
>>>  
>>> +- DRA762
>>> +  compatible = "ti,dra76", "ti,dra7"
>>
>> 76 or 762?
> 
> Just wanted to cover all variants of dra76x with this compatible. Okay
> ill use 762.
> 
>>
>> How many of these 2 or 3 compatible strings actually get used? I'd 
>> prefer to see one of these less specific compatibles get dropped.
> 
> ti,dra76 is being used. Ill try not to include ti,dra7 and post it again.

ti,dra7 is being used by cpufreq driver . So, I would like to use both
ti,dra762 and ti,dra7 as compatible.

Thanks and regards,
Lokesh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
