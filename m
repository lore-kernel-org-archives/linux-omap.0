From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] arm: omap5: dts: split SMPS10 dt node
Date: Fri, 16 Aug 2013 15:51:33 +0530
Message-ID: <520DFD2D.9020408@ti.com>
References: <1376300221-15172-1-git-send-email-kishon@ti.com> <520A32CF.1010701@baylibre.com> <520A4685.7050503@ti.com> <520A474F.9080500@baylibre.com> <520DB559.80305@ti.com> <520DE8C1.2080406@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <520DE8C1.2080406@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: "J, KEERTHY" <j-keerthy@ti.com>, tony@atomide.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On Friday 16 August 2013 02:24 PM, Benoit Cousson wrote:
> On 16/08/2013 07:15, Kishon Vijay Abraham I wrote:
>> Hi Benoit,
>>
>> On Tuesday 13 August 2013 08:18 PM, Benoit Cousson wrote:
>>> On 13/08/2013 16:45, Kishon Vijay Abraham I wrote:
>>>> Hi,
>>>>
>>>> On Tuesday 13 August 2013 06:51 PM, Benoit Cousson wrote:
>>>>> Hi Kishon,
>>>>>
>>>>> On 12/08/2013 11:37, Kishon Vijay Abraham I wrote:
>>>>>> SMPS10 has two outputs OUT1 and OUT2. Hence SMPS10 is modeled as
>>>>>> two regulators. The dt node is split to reflect it.
>>>>>
>>>>> Mmm, I'm curious. How is it supposed to work?
>>>>>
>>>>> Do you have dedicated control on each output?
>>>>
>>>> Yes. It can be controlled by setting different values to the same bit fields.
>>>> You can refer [1] where we actually implement SMPS10 as two different
>>>> regulators.
>>>>
>>>> [1] -> http://permalink.gmane.org/gmane.linux.kernel/1542521
>>>
>>> Great, thanks.
>>>
>>> Can we merge that one safely if the driver changed are not done yet?
>>
>> I think it shouldn't cause any issues. However Mark has already merged the
>> driver changes.
> 
> Cool. I've just applied your patch in for_3.12/dts

Thanks :-)

Regards
Kishon
