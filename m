From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
Date: Wed, 23 Feb 2011 15:12:46 -0600
Message-ID: <AANLkTik=2oZ29fcXoeu4zSnTzKeLwRtnKPhQnM946c6E@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<AANLkTikZu+pqwpPXExFirPouN+1i3Yp0QHfomHN4decx@mail.gmail.com>
	<AANLkTi=C01Yf9rQN1uxMptFyOrwqxJWt+quJ8ipiM+k6@mail.gmail.com>
	<AANLkTi=s-p3OQfzor27sf-qqqNxipSrOAEQtPQEGaO=L@mail.gmail.com>
	<AANLkTi=+rzHDB_hGzGtZKNZB02z4v65GAD-87zVpOdni@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41485 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751336Ab1BWVMs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 16:12:48 -0500
Received: by mail-vw0-f45.google.com with SMTP id 19so4210619vws.4
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 13:12:47 -0800 (PST)
In-Reply-To: <AANLkTi=+rzHDB_hGzGtZKNZB02z4v65GAD-87zVpOdni@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: hiroshi.doyu@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Wed, Feb 23, 2011 at 1:54 PM, David Cohen <dacohen@gmail.com> wrote:
> On Wed, Feb 23, 2011 at 3:39 PM, Guzman Lugo, Fernando
> <fernando.lugo@ti.com> wrote:
>> On Wed, Feb 23, 2011 at 3:45 AM, David Cohen <dacohen@gmail.com> wro=
te:
>>> On Wed, Feb 23, 2011 at 3:17 AM, Guzman Lugo, Fernando
>>> <fernando.lugo@ti.com> wrote:
>>>> On Wed, Feb 16, 2011 at 1:35 PM, David Cohen <dacohen@gmail.com> w=
rote:
>>>>> Add support to register an isr for IOMMU fault situations and ada=
pt it
>>>>> to allow such (*isr)() to be used as fault callback. Drivers usin=
g IOMMU
>>>>> module might want to be informed when errors happen in order to d=
ebug it
>>>>> or react.
>>>>>
>>>>> Signed-off-by: David Cohen <dacohen@gmail.com>
>>>>> ---
>>>>> =A0arch/arm/mach-omap2/iommu2.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 17 +=
++++++++-
>>>>> =A0arch/arm/plat-omap/include/plat/iommu.h | =A0 14 ++++++++-
>>>>> =A0arch/arm/plat-omap/iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 52=
 ++++++++++++++++++++++---------
>>>>> =A03 files changed, 65 insertions(+), 18 deletions(-)
>>>>>
>>>> ....
>>>>
>>>>> @@ -917,6 +912,33 @@ void iommu_put(struct iommu *obj)
>>>>> =A0}
>>>>> =A0EXPORT_SYMBOL_GPL(iommu_put);
>>>>>
>>>>> +int iommu_set_isr(const char *name,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int (*isr)(struct iommu *obj, u=
32 da, u32 iommu_errs,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *pr=
iv),
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *isr_priv)
>>>>> +{
>>>>> + =A0 =A0 =A0 struct device *dev;
>>>>> + =A0 =A0 =A0 struct iommu *obj;
>>>>> +
>>>>
>>>> if the driver support multiple user for the same iommu why can onl=
y
>>>> one callback be registered? should it support register multiple
>>>> callback function (one per user)?
>>>
>>> Can you define a scenario for that?
>>> On OMAP3 ISP the multiple users are the multiple ISP submodule, but=
 I
>>> don't think it's necessary all submodule to have a specific callbac=
k.
>>> ISP core layer should handle.
>>
>> Hi,
>>
>> In OMAP4 the cortex M3 is a double core processor and as each core i=
s
>> running they own version of the RTOS we threat them independently. S=
o
>> our driver which controls the remote processor sees two processor bu=
t
>> both use the same iommu hw. When a iommu fault happens, at this
>> moment, it is consider as a faltal error and it is no managed to
>> recover and continue, instead a restart of the processor is needed, =
if
>> the fault happens in core0 we need to reset core1 too and vice versa=
=2E
>> if the iommu would support several user callbacks, we can register t=
he
>> callback which resets core0 and also the callback which resets core1
>> and treat them as totally independent processors. Also we have an
>> error event notifier driver, which is only in charge of notifying
>> error events to userspace, so we would have multiple callbacks we
>> could do this
>
> I understood your point. In this case, I may not disagree about havin=
g
> more than one callback per obj, although it doesn't seem a nice
> scenario.
> We can have a list of callbacks and call the entire list when a fault

check kernel/notifier.c module and how it is manage in mailbox, so you
can implement something similar.

> happens. But it's necessary to pay attention it will happen in atomic
> context and users should not abuse and register many callbacks. The
> callback should *NOT* print useless messages and must verify the erro=
r
> code to not execute useless steps.

Sure, users needs to consider the callback as a ISR and if they need
to do something heavy then schedule a task to do that.

> In this context, callback and ISR cannot share a same pointer anymore=
=2E
>
>>
>> iommu <---- register fault callback for error notify driver
>>
>> instead of
>>
>> iommu <--- register fault callback for remote processor driver
>> <----register fault event for error notify driver.
>>
>> with that, we remove one dependency of the errornotify driver.
>
> I don't know very well the errornotify driver, but to bypass it seems
> be a good approach for me.

that driver is not upstream yet, the intention is to have a driver
which can handle many errors, at this moments it is not handle the
errors, but notifying them to userspace. it is thought to be a generic
error handler with the posibility of notify many errors, among them
the iommu fault, so if the error handler driver will notify iommy
fault errors it makes more sense to register with iommu module instead
of doing with other driver which uses iommu module, and that can be
done having multiple callbacks.

>
>>
>> Moreover, the iommu code support serveral users of the same hw iommu=
,
>> and it does not make sense for me, that you can register only one
>> callback, or if other user register its callback the previous one wi=
ll
>> be overwritten.
>
> It's quite complex and dangerous this situation, as one driver can
> crash another one.

Yes that can happen, and if you don't have multiple callbacks the
other driver wont even notice it crashed and will try to work
normally. That is not good.

> But I don't think drivers have much choice.
>
> Hiroshi, do you have any different opinion for this subject? I can
> send a v4 version for this patch giving support for multiple callback=
s
> per obj.
>
> Br,
>
> David
>
>>
>> Regards,
>> Fernando.
>>
>>>
>>> Br,
>>>
>>> David
>>>
>>>>
>>>> Regards,
>>>> Fernando.
>>>>
>>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
