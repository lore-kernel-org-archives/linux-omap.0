From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
Date: Wed, 23 Feb 2011 21:54:26 +0200
Message-ID: <AANLkTi=+rzHDB_hGzGtZKNZB02z4v65GAD-87zVpOdni@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<AANLkTikZu+pqwpPXExFirPouN+1i3Yp0QHfomHN4decx@mail.gmail.com>
	<AANLkTi=C01Yf9rQN1uxMptFyOrwqxJWt+quJ8ipiM+k6@mail.gmail.com>
	<AANLkTi=s-p3OQfzor27sf-qqqNxipSrOAEQtPQEGaO=L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47283 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932525Ab1BWTy2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 14:54:28 -0500
Received: by wyg36 with SMTP id 36so1217976wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 11:54:27 -0800 (PST)
In-Reply-To: <AANLkTi=s-p3OQfzor27sf-qqqNxipSrOAEQtPQEGaO=L@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, hiroshi.doyu@nokia.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Wed, Feb 23, 2011 at 3:39 PM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
> On Wed, Feb 23, 2011 at 3:45 AM, David Cohen <dacohen@gmail.com> wrot=
e:
>> On Wed, Feb 23, 2011 at 3:17 AM, Guzman Lugo, Fernando
>> <fernando.lugo@ti.com> wrote:
>>> On Wed, Feb 16, 2011 at 1:35 PM, David Cohen <dacohen@gmail.com> wr=
ote:
>>>> Add support to register an isr for IOMMU fault situations and adap=
t it
>>>> to allow such (*isr)() to be used as fault callback. Drivers using=
 IOMMU
>>>> module might want to be informed when errors happen in order to de=
bug it
>>>> or react.
>>>>
>>>> Signed-off-by: David Cohen <dacohen@gmail.com>
>>>> ---
>>>> =C2=A0arch/arm/mach-omap2/iommu2.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 17 +++++++++-
>>>> =C2=A0arch/arm/plat-omap/include/plat/iommu.h | =C2=A0 14 ++++++++=
-
>>>> =C2=A0arch/arm/plat-omap/iommu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 52 ++++++++++++++++++++++---------
>>>> =C2=A03 files changed, 65 insertions(+), 18 deletions(-)
>>>>
>>> ....
>>>
>>>> @@ -917,6 +912,33 @@ void iommu_put(struct iommu *obj)
>>>> =C2=A0}
>>>> =C2=A0EXPORT_SYMBOL_GPL(iommu_put);
>>>>
>>>> +int iommu_set_isr(const char *name,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*is=
r)(struct iommu *obj, u32 da, u32 iommu_errs,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *priv),
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *is=
r_priv)
>>>> +{
>>>> + =C2=A0 =C2=A0 =C2=A0 struct device *dev;
>>>> + =C2=A0 =C2=A0 =C2=A0 struct iommu *obj;
>>>> +
>>>
>>> if the driver support multiple user for the same iommu why can only
>>> one callback be registered? should it support register multiple
>>> callback function (one per user)?
>>
>> Can you define a scenario for that?
>> On OMAP3 ISP the multiple users are the multiple ISP submodule, but =
I
>> don't think it's necessary all submodule to have a specific callback=
=2E
>> ISP core layer should handle.
>
> Hi,
>
> In OMAP4 the cortex M3 is a double core processor and as each core is
> running they own version of the RTOS we threat them independently. So
> our driver which controls the remote processor sees two processor but
> both use the same iommu hw. When a iommu fault happens, at this
> moment, it is consider as a faltal error and it is no managed to
> recover and continue, instead a restart of the processor is needed, i=
f
> the fault happens in core0 we need to reset core1 too and vice versa.
> if the iommu would support several user callbacks, we can register th=
e
> callback which resets core0 and also the callback which resets core1
> and treat them as totally independent processors. Also we have an
> error event notifier driver, which is only in charge of notifying
> error events to userspace, so we would have multiple callbacks we
> could do this

I understood your point. In this case, I may not disagree about having
more than one callback per obj, although it doesn't seem a nice
scenario.
We can have a list of callbacks and call the entire list when a fault
happens. But it's necessary to pay attention it will happen in atomic
context and users should not abuse and register many callbacks. The
callback should *NOT* print useless messages and must verify the error
code to not execute useless steps.
In this context, callback and ISR cannot share a same pointer anymore.

>
> iommu <---- register fault callback for error notify driver
>
> instead of
>
> iommu <--- register fault callback for remote processor driver
> <----register fault event for error notify driver.
>
> with that, we remove one dependency of the errornotify driver.

I don't know very well the errornotify driver, but to bypass it seems
be a good approach for me.

>
> Moreover, the iommu code support serveral users of the same hw iommu,
> and it does not make sense for me, that you can register only one
> callback, or if other user register its callback the previous one wil=
l
> be overwritten.

It's quite complex and dangerous this situation, as one driver can
crash another one. But I don't think drivers have much choice.

Hiroshi, do you have any different opinion for this subject? I can
send a v4 version for this patch giving support for multiple callbacks
per obj.

Br,

David

>
> Regards,
> Fernando.
>
>>
>> Br,
>>
>> David
>>
>>>
>>> Regards,
>>> Fernando.
>>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
