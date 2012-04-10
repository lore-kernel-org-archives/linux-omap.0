From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Tue, 10 Apr 2012 16:03:17 -0500
Message-ID: <4F84A015.4060509@ti.com>
References: <79CD15C6BA57404B839C016229A409A83184846A@DBDE01.ent.ti.com> <20120405095221.GC25053@n2100.arm.linux.org.uk> <79CD15C6BA57404B839C016229A409A831848621@DBDE01.ent.ti.com> <87hawxkgoi.fsf@ti.com> <79CD15C6BA57404B839C016229A409A831849432@DBDE01.ent.ti.com> <20120406180452.GB15734@atomide.com> <79CD15C6BA57404B839C016229A409A83184ABEF@DBDE01.ent.ti.com> <4F83440E.70502@ti.com> <20120410084413.GD25053@n2100.arm.linux.org.uk> <4F83F600.4000002@ti.com> <20120410092904.GE25053@n2100.arm.linux.org.uk> <CAMQu2gwSAPtXOYWP1VmVCuxru_CrbLC-gLaaD7n4+utu3rOwxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56767 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381Ab2DJVDe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 17:03:34 -0400
In-Reply-To: <CAMQu2gwSAPtXOYWP1VmVCuxru_CrbLC-gLaaD7n4+utu3rOwxQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, Ming Lei <tom.leiming@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 04/10/2012 04:51 AM, Shilimkar, Santosh wrote:
> On Tue, Apr 10, 2012 at 2:59 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk>  wrote:
>> On Tue, Apr 10, 2012 at 02:27:36PM +0530, Santosh Shilimkar wrote:
>>> On Tuesday 10 April 2012 02:14 PM, Russell King - ARM Linux wrote:
>>>> On Mon, Apr 09, 2012 at 03:18:22PM -0500, Jon Hunter wrote:
>>>>> True, but we would always want to use the 32k timer if CONFIG_PM is
>>>>> specified. So what I am saying is that if a device has a 32ksync timer
>>>>> and CONFIG_PM is defined, we always want to use the 32ksync timer and a
>>>>> gptimer should never be used.
>>>>
>>>> Why?  What if you want to have PM enabled, and you also want to use the
>>>> kernels high resolution timers, or you want more accurate timing than
>>>> the 30.5us tick interval of the 32k timer?
>>>
>>> You might have missed the earlier comments on the thread. High
>>> resolution GP timer(sysclk) will stop in deeper power states and
>>> hence it can't be used with PM enabled usecases.
>>
>> Which means folk should be given the choice at boot time between running
>> with the deeper power states and having a higher resolution timing source,
>> rather than denying them the higher resolution timing source when PM is
>> enabled.
>
> Good point. My point is such facilities is already part of the kernel and
> there is no need to add a new one. The last proposal was allowing user to
> choose gptimer as a clocksource and then you already have facility to
> disable C-state now so, all should work in general

Actually, thinking about this some more, you do not even need to disable 
c-states. By using a gptimer1 and configuring it to use the SYSCLK as it 
source, as long as the gptimer1 is not disabled, it will prevent SYSCLK 
from ever turning off.

Probably for good measure in this case we should also disable auto clock 
gating of SYSCLK via the PRM_CLKSRC_CTRL (OMAP2/3) or PRM_CLKREQCTRL 
(OMAP4).

Sounds like a good approach.

Jon
