From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
Date: Thu, 24 Feb 2011 08:39:43 +0200
Message-ID: <AANLkTi=RGTDGrQtvH7CDi=C2eu4T3nGZK-ixd8=NnYPp@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<AANLkTikZu+pqwpPXExFirPouN+1i3Yp0QHfomHN4decx@mail.gmail.com>
	<AANLkTi=C01Yf9rQN1uxMptFyOrwqxJWt+quJ8ipiM+k6@mail.gmail.com>
	<AANLkTi=s-p3OQfzor27sf-qqqNxipSrOAEQtPQEGaO=L@mail.gmail.com>
	<AANLkTi=+rzHDB_hGzGtZKNZB02z4v65GAD-87zVpOdni@mail.gmail.com>
	<4D657490.20504@maxwell.research.nokia.com>
	<AANLkTim+kcVxH=5pW51F0LFX=3igfWTgmthHN2F7tBB4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56727 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab1BXGjp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 01:39:45 -0500
Received: by wwb39 with SMTP id 39so336881wwb.1
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 22:39:44 -0800 (PST)
In-Reply-To: <AANLkTim+kcVxH=5pW51F0LFX=3igfWTgmthHN2F7tBB4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hiroshi.doyu@nokia.com, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Wed, Feb 23, 2011 at 11:48 PM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
> On Wed, Feb 23, 2011 at 2:56 PM, Sakari Ailus
> <sakari.ailus@maxwell.research.nokia.com> wrote:
>> David Cohen wrote:
>>> On Wed, Feb 23, 2011 at 3:39 PM, Guzman Lugo, Fernando
>>> <fernando.lugo@ti.com> wrote:
>>>> On Wed, Feb 23, 2011 at 3:45 AM, David Cohen <dacohen@gmail.com> w=
rote:
>>>>> On Wed, Feb 23, 2011 at 3:17 AM, Guzman Lugo, Fernando
>>>>> <fernando.lugo@ti.com> wrote:
>>>>>> On Wed, Feb 16, 2011 at 1:35 PM, David Cohen <dacohen@gmail.com>=
 wrote:
>>>>>>> Add support to register an isr for IOMMU fault situations and a=
dapt it
>>>>>>> to allow such (*isr)() to be used as fault callback. Drivers us=
ing IOMMU
>>>>>>> module might want to be informed when errors happen in order to=
 debug it
>>>>>>> or react.
>>>>>>>
>>>>>>> Signed-off-by: David Cohen <dacohen@gmail.com>
>>>>>>> ---
>>>>>>> =C2=A0arch/arm/mach-omap2/iommu2.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 17 +++++++++-
>>>>>>> =C2=A0arch/arm/plat-omap/include/plat/iommu.h | =C2=A0 14 +++++=
+++-
>>>>>>> =C2=A0arch/arm/plat-omap/iommu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 52 ++++++++++++++++++++++---------
>>>>>>> =C2=A03 files changed, 65 insertions(+), 18 deletions(-)
>>>>>>>
>>>>>> ....
>>>>>>
>>>>>>> @@ -917,6 +912,33 @@ void iommu_put(struct iommu *obj)
>>>>>>> =C2=A0}
>>>>>>> =C2=A0EXPORT_SYMBOL_GPL(iommu_put);
>>>>>>>
>>>>>>> +int iommu_set_isr(const char *name,
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int (=
*isr)(struct iommu *obj, u32 da, u32 iommu_errs,
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *priv),
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void =
*isr_priv)
>>>>>>> +{
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 struct device *dev;
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 struct iommu *obj;
>>>>>>> +
>>>>>>
>>>>>> if the driver support multiple user for the same iommu why can o=
nly
>>>>>> one callback be registered? should it support register multiple
>>>>>> callback function (one per user)?
>>>>>
>>>>> Can you define a scenario for that?
>>>>> On OMAP3 ISP the multiple users are the multiple ISP submodule, b=
ut I
>>>>> don't think it's necessary all submodule to have a specific callb=
ack.
>>>>> ISP core layer should handle.
>>>>
>>>> Hi,
>>>>
>>>> In OMAP4 the cortex M3 is a double core processor and as each core=
 is
>>>> running they own version of the RTOS we threat them independently.=
 So
>>>> our driver which controls the remote processor sees two processor =
but
>>>> both use the same iommu hw. When a iommu fault happens, at this
>>>> moment, it is consider as a faltal error and it is no managed to
>>>> recover and continue, instead a restart of the processor is needed=
, if
>>>> the fault happens in core0 we need to reset core1 too and vice ver=
sa.
>>>> if the iommu would support several user callbacks, we can register=
 the
>>>> callback which resets core0 and also the callback which resets cor=
e1
>>>> and treat them as totally independent processors. Also we have an
>>>> error event notifier driver, which is only in charge of notifying
>>>> error events to userspace, so we would have multiple callbacks we
>>>> could do this
>>>
>>> I understood your point. In this case, I may not disagree about hav=
ing
>>> more than one callback per obj, although it doesn't seem a nice
>>> scenario.
>>> We can have a list of callbacks and call the entire list when a fau=
lt
>>> happens. But it's necessary to pay attention it will happen in atom=
ic
>>> context and users should not abuse and register many callbacks. The
>>> callback should *NOT* print useless messages and must verify the er=
ror
>>> code to not execute useless steps.
>>> In this context, callback and ISR cannot share a same pointer anymo=
re.
>>
>> I think this is outside of the scope of the patch but...
>
> yes, the same behaviour was before the patches, but as the patches ar=
e
> changing the isr, I think it is a good time to modify, not in patch 2=
,
> but in a new patch to be added to the serie between patch 1 and 2, so
> that we dont need to change ISR part again after this set of patches.

Let's wait for Hiroshi's opinion and decide if I change or not the patc=
hes.

Br,

David

>
>>
>> To efficiently debug iommu faults (with a driver using iommu page
>> walking), besides the actual fault address the list of existing mapp=
ings
>> and the information which driver created them and for which purpose =
is
>> useful.
>>
>> The list of mappings is already available in the iommu structure. It=
'd
>> be nice if there was a function a driver could call to print them.
>
>>
>> I can only think of ugly ways to implement the other.
>>
>> Just my 5 cents (as we have no 2 cent coins here).
>>
>> Regards,
>>
>> --
>> Sakari Ailus
>> sakari.ailus@maxwell.research.nokia.com
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
