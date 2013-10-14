From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Mon, 14 Oct 2013 21:34:34 +0300
Message-ID: <525C393A.9020501@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <524EE00F.7010208@ti.com> <20131007021556.GV8949@atomide.com>
 <52525642.8010307@ti.com> <20131007154103.GW8949@atomide.com>
 <20131007190322.GY8949@atomide.com>
 <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
 <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com>
 <525654AE.7060009@ti.com>
 <alpine.DEB.2.02.1310111749180.27397@utopia.booyaka.com>
 <52584785.2020504@ti.com>
 <alpine.DEB.2.02.1310112226130.27397@utopia.booyaka.com>
 <525923AB.4030807@ti.com>
 <alpine.DEB.2.02.1310132023240.27397@utopia.booyaka.com>
 <525C063C.9080908@ti.com>
 <alpine.DEB.2.02.1310141824380.22465@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1310141824380.22465@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: nm@ti.com, devicetree@vger.kernel.org, khilman@linaro.org, mturquette@linaro.org, Tony Lindgren <tony@atomide.com>, pdeschrijver@nvidia.com, rnayak@ti.com, bcousson@baylibre.com, swarren@nvidia.com, mark.rutland@arm.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/14/2013 09:27 PM, Paul Walmsley wrote:
> On Mon, 14 Oct 2013, Tero Kristo wrote:
>
>> On 10/14/2013 02:45 AM, Paul Walmsley wrote:
>>
>>> 8. A few random comments about the individual clock binding data formats
>>> themselves, based on a quick look:
>>>
>>> A. It seems pretty odd and unnecessarily obscure to do something like
>>> this:
>>>
>>> dpll_usb_ck: dpll_usb_ck@... {
>>>          ...
>>>          reg = <0x4a008180 0x4>, <0x4a008184 0x4>, <0x4a008188 0x4>,
>>> <0x4a00818c 0x4>;
>>>          ...
>>> };
>>>
>>> It's at least self-documenting to do something like this:
>>>
>>> dpll_usb_ck: dpll_usb_ck@... {
>>>          ...
>>>          control-reg = < ... >;
>>>          idlest-reg = < ... >;
>>>          .. etc. ..
>>> };
>>
>> Some earlier version had something along these lines, but it was turned down.
>> I had also reg-names as documentation purposes along, but this was unnecessary
>> and was dropped also.
>>
>>> Which itself might not even be needed, depending on how the DPLL control
>>> code is implemented.  For example, if the relative offsets are always the
>>> same for all OMAP4-family devices, maybe there's not even a need to
>>> explicitly encode that into the DT data.
>>
>> If I want to get rid of these, I need to add extra compatible strings for the
>> dpll types. There are several weird register offsets for omap3/am3 devices.
>> omap4/5/dra7/am4 behave more sanely.
>>
>>> B. Seems like you can remove the "ti," prefix on the properties, since
>>> they have no pretentions at genericity: they are specific to the
>>> PRCM/CM/PRM IP block data, and registered by those drivers.
>>
>> Can or should? It seems existing bindings use "ti," prefix even on non-generic
>> bindings, meaning if I look at any other data in DT.
>
> My comments in #8 are just regarding minor issues that don't seem
> right.  I don't have a significant objection to staying with the
> existing property names here if you think that they are important.

Ok thanks, I'll be reworking most of the other items and will hopefully 
have something ready soonish. Taking care of the register mappings is 
rather nasty thing to do.

-Tero

>>> C. Looks like the patches use the property "autoidle-low" to indicate that
>>> the autoidle bit should be inverted.  "Low" seems like the wrong
>>> expression here - it invokes the actual voltage logic level of a hardware
>>> signal, and we have no idea whether the hardware signal is using a low
>>> voltage or a high voltage to express this condition.  Would suggest
>>> something like 'invert-autoidle-bit' instead.
>>>
>>> D. Regarding "ti,index-starts-at-one", it seems best to explicitly state
>>> which index starts at one.  The code mentions a "mux index" so please
>>> consider renaming this something like "mux-index-starts-at-one" or
>>> "one-based-mux-index"
>>
>> The index is explicitly defined by the clock node where this is present. If it
>> is a mux-clock, then it is for mux-index. If for divider clock, it is index
>> for the divider.
>
>
>
> - Paul
>
