From: Gururaja Hebbar <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: Re: [Patch V2 4/4] ARM: dts: AM33XX: update rtc node compatibility
Date: Fri, 2 Aug 2013 17:18:07 +0530
Message-ID: <51FB9C77.3090202@ti.com>
References: <1372841225-18813-1-git-send-email-gururaja.hebbar@ti.com>
	<1372841225-18813-5-git-send-email-gururaja.hebbar@ti.com>
	<51F749B0.7020802@ti.com>
	<20130730145501.GA29859@e106331-lin.cambridge.arm.com>
	<51F7E7FA.3080702@ti.com>
	<20130801170537.GF8095@e106331-lin.cambridge.arm.com>
	<51FB92F8.9020801@ti.com>
	<20130802112018.GI2884@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20130802112018.GI2884-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "benoit.cousson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <benoit.cousson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "vaibhav.bedia-l0cyMroinI0@public.gmane.org" <vaibhav.bedia-l0cyMroinI0@public.gmane.org>, "benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 8/2/2013 4:50 PM, Mark Rutland wrote:
> On Fri, Aug 02, 2013 at 12:07:36PM +0100, Gururaja Hebbar wrote:
>> On 8/1/2013 10:35 PM, Mark Rutland wrote:
>>> On Tue, Jul 30, 2013 at 05:21:14PM +0100, Sekhar Nori wrote:
>>>> On 7/30/2013 8:25 PM, Mark Rutland wrote:
>>>>> On Tue, Jul 30, 2013 at 06:05:52AM +0100, Gururaja Hebbar wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 7/3/2013 2:17 PM, Hebbar Gururaja wrote:
>>>>>>> Since AM33xx  RTC IP has RTC_IRQWAKEEN to support Alarm Wake-up.
>>>>>>>
>>>>>>> Update the rtc compatible property to "ti,am3352-rtc" to enable handling
>>>>>>> of this feature inside rtc-omap driver.
>>>>>>
>>>>>> The other 2 rtc driver related patches have been pulled up. If you have
>>>>>> no comments, can you please pull this up.
>>>>>>
>>>>>> Regards
>>>>>> Gururaja
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
>>>>>>> ---
>>>>>>> :100644 100644 77aa1b0... dde180a... M	arch/arm/boot/dts/am33xx.dtsi
>>>>>>>     arch/arm/boot/dts/am33xx.dtsi |    2 +-
>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>>>>>>> index 77aa1b0..dde180a 100644
>>>>>>> --- a/arch/arm/boot/dts/am33xx.dtsi
>>>>>>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>>>>>>> @@ -297,7 +297,7 @@
>>>>>>>     		};
>>>>>>>
>>>>>>>     		rtc@44e3e000 {
>>>>>>> -			compatible = "ti,da830-rtc";
>>>>>>> +			compatible = "ti,am3352-rtc";
>>>>>
>>>>> Given that this is backwards compatible with the old binding, it would
>>>>> be nicer to have this as:
>>>>>
>>>>> 	compatible = "ti,am3352-rtc", "ti,da830-rtc";
>>>>>
>>>>> We must get into the habit of changing dts files in a
>>>>> backwards-compatible fashion.
>>>>
>>>> Right, I suggested this when v1 was posted. It turns out the current
>>>> kernel does not handle the compatilble list correctly and the string
>>>> selected actually depends on the order in which it appears in match
>>>> table in driver instead.
>>>>
>>>> I saw there were patches being discussed to fix this issue, but until
>>>> that is fixed, we cannot really use what you (and I before) suggested.
>>>
>>> A temporary solution would be to list the "ti,am3352-rtc" first in the
>>> of_match_table kernel-side.
>>
>> If above method is followed, then it would cause trouble on davinci
>> platform because this rtc-omap driver is also used by Davinci platform.
>> On davinci Plaform the driver would match with "ti,am3352-rtc" for
>> compatible.
>
> Sorry, I don't follow. Does the davinci dt have "ti,am3352-rtc" in it's
> compatible string list?

no no. Davinci .dts uses "ti,da830-rtc".

I was saying if we reverse the order of "of_device_id" structure in 
rtc-omap driver, then it would work nicely for am335x but will cause 
trouble on davinci platform.

>
> If so, and it's not compatible, the dts is wrong.
>
> If not, then we won't use the behaviour specific to "ti,am3352-rtc", and
> there's no problem.
>
> What trouble would this cause?
>
> Thanks,
> Mark.
>
>>
>> Regards
>> Gururaja
>>
>>> That way you can keep the old compatible
>>> string in the dts compatible list, and maintain backwards compatibilty
>>> with older kernels.
>>>
>>> Later if the way Linux matches compatible strings is changed, this
>>> shouldn't break the probe order, and the of_match_table order could be
>>> changed.
>>>
>>> Have I missed something?
>>>
>>> Thanks,
>>> Mark.
>>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
