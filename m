From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod_core: enable optional clocks before
 main clock
Date: Tue, 20 Feb 2018 14:20:41 +0200
Message-ID: <f3425037-659b-238a-c77b-357c7363074d@ti.com>
References: <1513934763-23966-1-git-send-email-t-kristo@ti.com>
 <f9fea9e3-7ebb-9a78-92fc-85b7afe3a525@ti.com>
 <20171222185118.GA3875@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171222185118.GA3875@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 22/12/17 20:51, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [171222 09:43]:
>>
>>
>> On Friday 22 December 2017 02:56 PM, Tero Kristo wrote:
>>> The optional clocks must be enabled before the main clock after the
>>> transition to clkctrl controlled clocks is done. Otherwise the module
>>> we attempt to enable might be stuck in transition.
>>>
>>> Reported-by: Keerthy <j-keerthy@ti.com>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>
>> Tested the patch on both DRA7-EVM and DRA72-EVM. I no longer see the issue:
>>
>> Tested-by: Keerthy <j-keerthy@ti.com>
>>
>>> ---
>>> Hi Tony,
>>>
>>> This patch fixes a regression seen in linux-next, where certain peripherals
>>> fail to enable after the clkctrl changes are in. The case seen has been
>>> with mcasp3, where it fails to transition to enabled during the audio
>>> driver probe. Not sure where you want to pick this up, maybe as early
>>> rc fixes if its too late to push this to linux-next?
> 
> Thanks applying into omap-for-v4.16/soc, yeah we should
> get it merged during the merge window as a fix.

Tony,

I think this missed the merge for some reason? Can you queue this up as 
a fix as its still needed?

-Tero

> 
> Regards,
> 
> Tony
> 
> 
> 
>>>   arch/arm/mach-omap2/omap_hwmod.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>>> index 7324048..340d05c 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>> @@ -976,6 +976,9 @@ static int _enable_clocks(struct omap_hwmod *oh)
>>>   
>>>   	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
>>>   
>>> +	if (oh->flags & HWMOD_OPT_CLKS_NEEDED)
>>> +		_enable_optional_clocks(oh);
>>> +
>>>   	if (oh->_clk)
>>>   		clk_enable(oh->_clk);
>>>   
>>> @@ -984,9 +987,6 @@ static int _enable_clocks(struct omap_hwmod *oh)
>>>   			clk_enable(os->_clk);
>>>   	}
>>>   
>>> -	if (oh->flags & HWMOD_OPT_CLKS_NEEDED)
>>> -		_enable_optional_clocks(oh);
>>> -
>>>   	/* The opt clocks are controlled by the device driver. */
>>>   
>>>   	return 0;
>>>

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
