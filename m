From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] dt-bindings: power: Introduce suspend states supported
 properties
Date: Wed, 12 Sep 2018 12:37:13 +0100
Message-ID: <2c08c85f-a3e0-c1ce-3f87-0866868bd7e4@arm.com>
References: <1536725372-29174-1-git-send-email-j-keerthy@ti.com>
 <781b2eb2-1568-b4e5-46f2-c4612862d728@arm.com>
 <5c49cb0c-a436-c957-e6b3-5f3aa7af92f9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5c49cb0c-a436-c957-e6b3-5f3aa7af92f9@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, mark.rutland@arm.com, robh+dt@kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org



On 12/09/18 12:19, Keerthy wrote:
> 
> 
> On Wednesday 12 September 2018 04:32 PM, Sudeep Holla wrote:
>>
>>
>> On 12/09/18 05:09, Keerthy wrote:
>>> Introuduce linux generic suspend states supported properties.
>>> It is convenient for the generic suspend path to have
>>> the knowledge of the suspend states supported based on the
>>> device tree properties based on which it can either be suspended
>>> or safely bailed out of suspend if none of the suspend states
>>> are supported.
>>>
>>
>> NACK for any bindings that are linux specific. The suspend feature is so
>> platform dependent that I see no need for generic Linux bindings for the
>> same.
> 
> suspend to mem and suspend to disk are pretty generic states and i agree
> implementation is platform dependent so why not have properties that
> convey if they are supported?
> 

We already have power domains and idle states for that. If you need to
restrict few states on some platform for whatever reasons, just disable
those states. I don't see the need to add any more bindings for the same.

> Is the disagreement over making the properties being linux specific?
> 

Yes.

-- 
Regards,
Sudeep
