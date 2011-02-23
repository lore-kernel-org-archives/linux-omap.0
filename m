From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
Date: Wed, 23 Feb 2011 07:39:20 -0600
Message-ID: <AANLkTi=s-p3OQfzor27sf-qqqNxipSrOAEQtPQEGaO=L@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<AANLkTikZu+pqwpPXExFirPouN+1i3Yp0QHfomHN4decx@mail.gmail.com>
	<AANLkTi=C01Yf9rQN1uxMptFyOrwqxJWt+quJ8ipiM+k6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:39223 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754644Ab1BWNjZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 08:39:25 -0500
Received: by mail-vx0-f175.google.com with SMTP id 7so3404432vxd.34
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 05:39:20 -0800 (PST)
In-Reply-To: <AANLkTi=C01Yf9rQN1uxMptFyOrwqxJWt+quJ8ipiM+k6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: hiroshi.doyu@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Wed, Feb 23, 2011 at 3:45 AM, David Cohen <dacohen@gmail.com> wrote:
> On Wed, Feb 23, 2011 at 3:17 AM, Guzman Lugo, Fernando
> <fernando.lugo@ti.com> wrote:
>> On Wed, Feb 16, 2011 at 1:35 PM, David Cohen <dacohen@gmail.com> wro=
te:
>>> Add support to register an isr for IOMMU fault situations and adapt=
 it
>>> to allow such (*isr)() to be used as fault callback. Drivers using =
IOMMU
>>> module might want to be informed when errors happen in order to deb=
ug it
>>> or react.
>>>
>>> Signed-off-by: David Cohen <dacohen@gmail.com>
>>> ---
>>> =A0arch/arm/mach-omap2/iommu2.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 17 +++=
++++++-
>>> =A0arch/arm/plat-omap/include/plat/iommu.h | =A0 14 ++++++++-
>>> =A0arch/arm/plat-omap/iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 52 +=
+++++++++++++++++++++---------
>>> =A03 files changed, 65 insertions(+), 18 deletions(-)
>>>
>> ....
>>
>>> @@ -917,6 +912,33 @@ void iommu_put(struct iommu *obj)
>>> =A0}
>>> =A0EXPORT_SYMBOL_GPL(iommu_put);
>>>
>>> +int iommu_set_isr(const char *name,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int (*isr)(struct iommu *obj, u32=
 da, u32 iommu_errs,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *priv=
),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *isr_priv)
>>> +{
>>> + =A0 =A0 =A0 struct device *dev;
>>> + =A0 =A0 =A0 struct iommu *obj;
>>> +
>>
>> if the driver support multiple user for the same iommu why can only
>> one callback be registered? should it support register multiple
>> callback function (one per user)?
>
> Can you define a scenario for that?
> On OMAP3 ISP the multiple users are the multiple ISP submodule, but I
> don't think it's necessary all submodule to have a specific callback.
> ISP core layer should handle.

Hi,

In OMAP4 the cortex M3 is a double core processor and as each core is
running they own version of the RTOS we threat them independently. So
our driver which controls the remote processor sees two processor but
both use the same iommu hw. When a iommu fault happens, at this
moment, it is consider as a faltal error and it is no managed to
recover and continue, instead a restart of the processor is needed, if
the fault happens in core0 we need to reset core1 too and vice versa.
if the iommu would support several user callbacks, we can register the
callback which resets core0 and also the callback which resets core1
and treat them as totally independent processors. Also we have an
error event notifier driver, which is only in charge of notifying
error events to userspace, so we would have multiple callbacks we
could do this

iommu <---- register fault callback for error notify driver

instead of

iommu <--- register fault callback for remote processor driver
<----register fault event for error notify driver.

with that, we remove one dependency of the errornotify driver.

Moreover, the iommu code support serveral users of the same hw iommu,
and it does not make sense for me, that you can register only one
callback, or if other user register its callback the previous one will
be overwritten.

Regards,
=46ernando.

>
> Br,
>
> David
>
>>
>> Regards,
>> Fernando.
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
