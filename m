From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions
Date: Fri, 23 Nov 2018 12:21:39 +0200
Message-ID: <0b796f85-5002-8eca-3e51-de239f7b3b41@ti.com>
References: <20181113060111.16374-1-vigneshr@ti.com>
 <20181113060111.16374-2-vigneshr@ti.com>
 <20181117160502.dhlqbx5qnmdp5iog@kahuna>
 <b8c1d975-2b4f-5530-2089-dc04c04f8d86@ti.com>
 <12c1d6e2-aba4-be0d-bfc5-1fb5d3ab45f8@ti.com>
 <9f87eb33-45b4-905a-2afd-5bbb450fc6c6@ti.com>
 <a411e291-d02d-064e-d08c-9ab7a1b1409e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <a411e291-d02d-064e-d08c-9ab7a1b1409e@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vignesh R <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 20/11/2018 12:44, Vignesh R wrote:
> On 20/11/18 4:07 PM, Tero Kristo wrote:
>> On 20/11/2018 12:09, Vignesh R wrote:
>>> On 19/11/18 12:49 PM, Tero Kristo wrote:
>>>> On 17/11/2018 18:05, Nishanth Menon wrote:
>>>>> On 11:31-20181113, Vignesh R wrote:
>>>>>> The dt-bindings header for TI K3 AM6 SoCs define a set of macros for
>>>>>
>>> [...]
>>>>>
>>>>> Thanks for reducing the combinations down to the minimum needed. We can
>>>>> worry about the DS and isolation bits when we have a real user for
>>>>> them.
>>>>>
>>>>> Acked-by: Nishanth Menon <nm@ti.com>
>>>>>
>>>>> Tero: v4.21-rc1 perhaps ?
>>>>>
>>>>
>>>> Yeah, looks fine, queueing up for 4.21.
>>>>
>>>
>>> Thank you all for the review!
>>>
>>> Tero,
>>>
>>> Is there a branch with these patches that I can use as base for my next
>>> set of DT patches?
>>
>> Don't have a branch for these atm, but I can create one if you need it.
> 
> Yes, that would be great. Thanks!
> 

Pushed 4.20-rc1-am65x-queue into my public tree.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
