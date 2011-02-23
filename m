From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
Date: Wed, 23 Feb 2011 15:30:14 -0600
Message-ID: <AANLkTim2HsAtYbN1ZRATv-5TT0CZGaL+fOxB-ht7mAtv@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<AANLkTikZu+pqwpPXExFirPouN+1i3Yp0QHfomHN4decx@mail.gmail.com>
	<AANLkTi=C01Yf9rQN1uxMptFyOrwqxJWt+quJ8ipiM+k6@mail.gmail.com>
	<AANLkTi=s-p3OQfzor27sf-qqqNxipSrOAEQtPQEGaO=L@mail.gmail.com>
	<4D656961.7080105@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59994 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755969Ab1BWVaQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 16:30:16 -0500
Received: by vxb41 with SMTP id 41so3160686vxb.4
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 13:30:14 -0800 (PST)
In-Reply-To: <4D656961.7080105@maxwell.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Cc: David Cohen <dacohen@gmail.com>, hiroshi.doyu@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Wed, Feb 23, 2011 at 2:09 PM, Sakari Ailus
<sakari.ailus@maxwell.research.nokia.com> wrote:
> Guzman Lugo, Fernando wrote:
>> Hi,
>
> Hi Fernando,
>
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
> The original purpose of the patch, as far as I understand, is to allow
> getting useful information for debugging purposes should an iommu fault
> happen.
>
> Also, I'm not sure it's necessarily a good idea to just go and reset
> the M3 cores in case an iommu fault happens --- this is very probably a
> grave bug in the software running on those M3s. It should be fixed
> instead of just hiding it. There will be consequences to host side as
> well, won't there?

the code running in the M3 side is a RTOS, and it does not have
something like kernel and userspace as linux, so if some app crashes
it crash the whole system (like a crash in a driver) it can be
improved later. And the issues in the host side are taking into
account, host apps are notified about the issue and they release and
start the communication with the remote cores.

But event if we were able to fixed the issue, think is this example

you have two independent OS running on each core of  the cortex M3
(core0 and core1). You make your own mapping in core0 and your own
mapping in core1 and each core has a callback for mmu fault:

case 1: mmufault in core1:

1.- iommu fault isr in iommu module is triggered and it calls to all callbacks.

2.- it calls callback for core0 (cb_c0)

3.- cb_c0 tries to fix the problem but, as it does not have
information about that fault address (core1 does)it can not fixed the
issue and return an error to say it could not manage the issue.

4.- iommu fault isr check the value returned by cb_c0 and it sees
cb_c0 did not fix the issue, so it call to the next callback (cb_c1)

5.- cb_c1 is executed and fixes the issue and they continue working.


case 2: mmufault in core0:

1.- iommu fault isr in iommu module is triggered and it calls to all callbacks.

2.- it calls callback for core0 (cb_c0)

3.- cb_c0 fixes the problem and returns a success value.

4.- iommu fault isr check the value returned by cb_c0 and it sees
cb_c0 it fixed the issue, so it does not call any other callback
(cb_c1)


So, multiple callbacks looks really nice for me.

Regards,
Fernando.

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
>
