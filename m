From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: AM33XX: fix gpio node numbering to match
 hardware
Date: Mon, 10 Sep 2012 18:59:21 +0200
Message-ID: <504E1C69.30602@ti.com>
References: <1347294020-22661-1-git-send-email-mporter@ti.com>
 <504E168C.6060603@ti.com> <20120910165210.GJ27758@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120910165210.GJ27758@beef>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 09/10/2012 06:52 PM, Matt Porter wrote:
> On Mon, Sep 10, 2012 at 06:34:20PM +0200, Benoit Cousson wrote:
>> + Tony
>>
>> Hi Matt,
>>
>> 30 minutes too late for my pull request :-(
>>
>> There are a couple of am33xx patches under discussion, so I'll take them
>> and send a for_3.7/dts-part2 pull request if this is not too late for Tony.
> 
> Yeah, believe me, I did a faceplant when I saw your pull request come by
> at the same time I discovered this issue. ;) In particular, AnilKumar's
> user leds patch would need to be adjusted for this change. I can
> resubmit with the user leds dts changes adjusted as well if that
> discussion comes to a conclusion and his patches accepted.

Yeah, I was wondering if the gpios label were already used somewhere.
I've just added this patch on top of my current series.
So you or Anil should just post the missing patches whenever they'll be
available and accepted.

>> On 09/10/2012 06:20 PM, Matt Porter wrote:
>>> On AM33xx, the datasheet and TRM refer to four GPIO instances that
>>> are 0-based, GPIO0-3.
>>
>> Or maybe you should just update the spec to use a 1-based GPIO number
>> like OMAP :-)
> 
> I am powerless here. :)

That's too bad :-(

Benoit

> 
> -Matt
> 
>>> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
>>> ---
>>>  arch/arm/boot/dts/am33xx.dtsi |    8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>>> index bb31bff..1369bfc 100644
>>> --- a/arch/arm/boot/dts/am33xx.dtsi
>>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>>> @@ -62,7 +62,7 @@
>>>  			reg = <0x48200000 0x1000>;
>>>  		};
>>>  
>>> -		gpio1: gpio@44e07000 {
>>> +		gpio0: gpio@44e07000 {
>>>  			compatible = "ti,omap4-gpio";
>>>  			ti,hwmods = "gpio1";
>>>  			gpio-controller;
>>> @@ -74,7 +74,7 @@
>>>  			interrupts = <96>;
>>>  		};
>>>  
>>> -		gpio2: gpio@4804c000 {
>>> +		gpio1: gpio@4804c000 {
>>>  			compatible = "ti,omap4-gpio";
>>>  			ti,hwmods = "gpio2";
>>>  			gpio-controller;
>>> @@ -86,7 +86,7 @@
>>>  			interrupts = <98>;
>>>  		};
>>>  
>>> -		gpio3: gpio@481ac000 {
>>> +		gpio2: gpio@481ac000 {
>>>  			compatible = "ti,omap4-gpio";
>>>  			ti,hwmods = "gpio3";
>>>  			gpio-controller;
>>> @@ -98,7 +98,7 @@
>>>  			interrupts = <32>;
>>>  		};
>>>  
>>> -		gpio4: gpio@481ae000 {
>>> +		gpio3: gpio@481ae000 {
>>>  			compatible = "ti,omap4-gpio";
>>>  			ti,hwmods = "gpio4";
>>>  			gpio-controller;
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
