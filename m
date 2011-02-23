From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
Date: Wed, 23 Feb 2011 22:21:06 +0200
Message-ID: <AANLkTikJykSYxv2zKS=vYsdKh0WQaKFOv0a7fSEQ_7JR@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<AANLkTikZu+pqwpPXExFirPouN+1i3Yp0QHfomHN4decx@mail.gmail.com>
	<AANLkTi=C01Yf9rQN1uxMptFyOrwqxJWt+quJ8ipiM+k6@mail.gmail.com>
	<AANLkTi=s-p3OQfzor27sf-qqqNxipSrOAEQtPQEGaO=L@mail.gmail.com>
	<4D656961.7080105@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:54914 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351Ab1BWUVI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 15:21:08 -0500
Received: by wwi17 with SMTP id 17so5848869wwi.1
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 12:21:06 -0800 (PST)
In-Reply-To: <4D656961.7080105@maxwell.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Cc: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, hiroshi.doyu@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Wed, Feb 23, 2011 at 10:09 PM, Sakari Ailus
<sakari.ailus@maxwell.research.nokia.com> wrote:
> Guzman Lugo, Fernando wrote:
>> Hi,
>
> Hi Fernando,
>
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
> The original purpose of the patch, as far as I understand, is to allo=
w
> getting useful information for debugging purposes should an iommu fau=
lt
> happen.
>
> Also, I'm not sure it's necessarily a good idea to just go and reset
> the M3 cores in case an iommu fault happens --- this is very probably=
 a
> grave bug in the software running on those M3s. It should be fixed
> instead of just hiding it. There will be consequences to host side as
> well, won't there?

That's really a good point. callbacks in this situation are mostly to
debug purpose. Drivers shouldn't rely on that to work properly.

David

>
>> iommu <---- register fault callback for error notify driver
>>
>> instead of
>>
>> iommu <--- register fault callback for remote processor driver
>> <----register fault event for error notify driver.
>>
>> with that, we remove one dependency of the errornotify driver.
>
> I suppose this is not in mainline?
>
> Regards,
>
> --
> Sakari Ailus
> sakari.ailus@maxwell.research.nokia.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
