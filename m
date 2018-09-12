From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] dt-bindings: power: Introduce suspend states supported
 properties
Date: Wed, 12 Sep 2018 14:42:56 +0100
Message-ID: <19ae9d20-46aa-25d7-87aa-ea4270f0162b@arm.com>
References: <1536725372-29174-1-git-send-email-j-keerthy@ti.com>
 <781b2eb2-1568-b4e5-46f2-c4612862d728@arm.com>
 <5c49cb0c-a436-c957-e6b3-5f3aa7af92f9@ti.com>
 <2c08c85f-a3e0-c1ce-3f87-0866868bd7e4@arm.com>
 <20180912133228.GI5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912133228.GI5662@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Keerthy <j-keerthy@ti.com>, mark.rutland@arm.com, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On 12/09/18 14:32, Tony Lindgren wrote:
> * Sudeep Holla <sudeep.holla@arm.com> [180912 11:41]:
>> On 12/09/18 12:19, Keerthy wrote:
>>> suspend to mem and suspend to disk are pretty generic states and i agree
>>> implementation is platform dependent so why not have properties that
>>> convey if they are supported?
>>>
>>
>> We already have power domains and idle states for that. If you need to
>> restrict few states on some platform for whatever reasons, just disable
>> those states. I don't see the need to add any more bindings for the same.
> 
> Oh do you mean the "domain-idle-states" property as mentioned in the
> Documentation/devicetree/bindings/power/power_domain.txt?
> 

Yes, exactly that.

> Yeah that should do and the DOMAIN_PWR_DN and DOMAIN_RET can be SoC
> specific and then the board can select which ones to use depending on
> how things are wired for GPIOs, memory, PMIC and so on.
>

All the idle-states are platform specific. DOMAIN_RET and DOMAIN_PWR_DN
are just examples used in the bindings.

> Hmm I don't see any users for this binding though?
> 

It was added specifically to deal with such SoC idles states or
hierarchical CPU power domains states, no users in upstream yet. But IMO
it fits what $subject is trying to address.

-- 
Regards,
Sudeep
