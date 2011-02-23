From: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault
 handling
Date: Wed, 23 Feb 2011 22:56:48 +0200
Message-ID: <4D657490.20504@maxwell.research.nokia.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>	<1297884951-3019-3-git-send-email-dacohen@gmail.com>	<AANLkTikZu+pqwpPXExFirPouN+1i3Yp0QHfomHN4decx@mail.gmail.com>	<AANLkTi=C01Yf9rQN1uxMptFyOrwqxJWt+quJ8ipiM+k6@mail.gmail.com>	<AANLkTi=s-p3OQfzor27sf-qqqNxipSrOAEQtPQEGaO=L@mail.gmail.com> <AANLkTi=+rzHDB_hGzGtZKNZB02z4v65GAD-87zVpOdni@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:22473 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755801Ab1BWUzu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 15:55:50 -0500
In-Reply-To: <AANLkTi=+rzHDB_hGzGtZKNZB02z4v65GAD-87zVpOdni@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, hiroshi.doyu@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

David Cohen wrote:
> On Wed, Feb 23, 2011 at 3:39 PM, Guzman Lugo, Fernando
> <fernando.lugo@ti.com> wrote:
>> On Wed, Feb 23, 2011 at 3:45 AM, David Cohen <dacohen@gmail.com> wrote:
>>> On Wed, Feb 23, 2011 at 3:17 AM, Guzman Lugo, Fernando
>>> <fernando.lugo@ti.com> wrote:
>>>> On Wed, Feb 16, 2011 at 1:35 PM, David Cohen <dacohen@gmail.com> wrote:
>>>>> Add support to register an isr for IOMMU fault situations and adapt it
>>>>> to allow such (*isr)() to be used as fault callback. Drivers using IOMMU
>>>>> module might want to be informed when errors happen in order to debug it
>>>>> or react.
>>>>>
>>>>> Signed-off-by: David Cohen <dacohen@gmail.com>
>>>>> ---
>>>>>  arch/arm/mach-omap2/iommu2.c            |   17 +++++++++-
>>>>>  arch/arm/plat-omap/include/plat/iommu.h |   14 ++++++++-
>>>>>  arch/arm/plat-omap/iommu.c              |   52 ++++++++++++++++++++++---------
>>>>>  3 files changed, 65 insertions(+), 18 deletions(-)
>>>>>
>>>> ....
>>>>
>>>>> @@ -917,6 +912,33 @@ void iommu_put(struct iommu *obj)
>>>>>  }
>>>>>  EXPORT_SYMBOL_GPL(iommu_put);
>>>>>
>>>>> +int iommu_set_isr(const char *name,
>>>>> +                 int (*isr)(struct iommu *obj, u32 da, u32 iommu_errs,
>>>>> +                            void *priv),
>>>>> +                 void *isr_priv)
>>>>> +{
>>>>> +       struct device *dev;
>>>>> +       struct iommu *obj;
>>>>> +
>>>>
>>>> if the driver support multiple user for the same iommu why can only
>>>> one callback be registered? should it support register multiple
>>>> callback function (one per user)?
>>>
>>> Can you define a scenario for that?
>>> On OMAP3 ISP the multiple users are the multiple ISP submodule, but I
>>> don't think it's necessary all submodule to have a specific callback.
>>> ISP core layer should handle.
>>
>> Hi,
>>
>> In OMAP4 the cortex M3 is a double core processor and as each core is
>> running they own version of the RTOS we threat them independently. So
>> our driver which controls the remote processor sees two processor but
>> both use the same iommu hw. When a iommu fault happens, at this
>> moment, it is consider as a faltal error and it is no managed to
>> recover and continue, instead a restart of the processor is needed, if
>> the fault happens in core0 we need to reset core1 too and vice versa.
>> if the iommu would support several user callbacks, we can register the
>> callback which resets core0 and also the callback which resets core1
>> and treat them as totally independent processors. Also we have an
>> error event notifier driver, which is only in charge of notifying
>> error events to userspace, so we would have multiple callbacks we
>> could do this
> 
> I understood your point. In this case, I may not disagree about having
> more than one callback per obj, although it doesn't seem a nice
> scenario.
> We can have a list of callbacks and call the entire list when a fault
> happens. But it's necessary to pay attention it will happen in atomic
> context and users should not abuse and register many callbacks. The
> callback should *NOT* print useless messages and must verify the error
> code to not execute useless steps.
> In this context, callback and ISR cannot share a same pointer anymore.

I think this is outside of the scope of the patch but...

To efficiently debug iommu faults (with a driver using iommu page
walking), besides the actual fault address the list of existing mappings
and the information which driver created them and for which purpose is
useful.

The list of mappings is already available in the iommu structure. It'd
be nice if there was a function a driver could call to print them.

I can only think of ugly ways to implement the other.

Just my 5 cents (as we have no 2 cent coins here).

Regards,

-- 
Sakari Ailus
sakari.ailus@maxwell.research.nokia.com
