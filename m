From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv3 2/9] ARM: OMAP2+: AM33XX: control: Add some control
 module registers and APIs
Date: Tue, 13 Aug 2013 11:08:23 -0400
Message-ID: <520A4BE7.7090603@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <1375811376-49985-3-git-send-email-d-gerlach@ti.com> <5203A0BC.8060205@ti.com> <5203C457.80301@ti.com> <20130809051146.GB7656@atomide.com> <52055733.70808@ti.com> <87y586pvkq.fsf@kernel.org> <5209565C.7090508@ti.com> <87d2phpsu1.fsf@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49269 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757523Ab3HMPIv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Aug 2013 11:08:51 -0400
In-Reply-To: <87d2phpsu1.fsf@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Suman Anna <s-anna@ti.com>

On Tuesday 13 August 2013 10:29 AM, Kevin Hilman wrote:
> Dave Gerlach <d-gerlach@ti.com> writes:
> 
>> On 08/12/2013 02:17 PM, Kevin Hilman wrote:
>>> Dave Gerlach <d-gerlach@ti.com> writes:
>>>
>>>> On 08/09/2013 12:11 AM, Tony Lindgren wrote:
>>>>> * Dave Gerlach <d-gerlach@ti.com> [130808 09:23]:
>>>>>> On 08/08/2013 08:44 AM, Santosh Shilimkar wrote:
>>>>>>> Lets address the above better. I don't see a need of 8 functions
>>>>>>> exported doing one or 2 register writes.
>>>>>>>
>>>>>>> Look M3 based handling is going to be there on future SOCs
>>>>>>> as well and this kind of handling of IPC is very short cited.
>>>>>>>
>>>>>>
>>>>>> The idea here was to move all control module register accesses into
>>>>>> one file in planning of implementing a driver for the control module
>>>>>> itself in the future.
>>>>>>
>>>>>>> Probably we should have a separate driver for M3 in linux which
>>>>>>> can have all this local code instead of all these exports.
>>>>>>
>>>>>> The wkup_m3 code has been moved to a small driver found in patch 8
>>>>>> of this series, would it better to move this code there rather than
>>>>>> with the rest of the control module code?
>>>>>
>>>>> Please make everything you can into regular device drivers.
>>>>>
>>>>> We still have some dependencies to mach-omap2 code for PRCM
>>>>> for example, but we're trying to get all that to live in
>>>>> drivers.
>>>>>
>>>>> So for new pieces, let's not add further dependencies to
>>>>> complicate moving things to drivers.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Tony
>>>>>
>>>>
>>>> Ok I will go ahead and pull the control module code that handles IPC
>>>> into the wkup_m3 driver.
>>>
>>> Any control module register access still needs to stay in control.c.
>>>
>>>> The wkup_m3.c file is still present in mach-omap2 as the right
>>>> location for it wasn't decided in the last RFC. Any thoughts on a good
>>>> location for it?
>>>
>>> I raised this also in earlier reviews, but don't remember the if it was
>>> answered...
>>>
>>> Why can't we handle the wkup_m3 using remoteproc/rpmsg instead of
>>> creating another little driver that duplicates communication with the
>>> M3.  Note also that the firmware load part would also be provided by
>>> remoteproc/rpmsg.
>>
>> Looping Suman Anna who handled the IPC patches this patch set is based
>> on top of...
>>
>> For the wkup_m3, the mailbox isn't used in a traditional manner. It's
>> only used with a dummy write to trigger an interrupt from the A8 to
>> the M3 and then communication happens in IPC registers within the
>> control module. No messages are actually sent through the mailbox in
>> either direction so that's why it was done this way rather than bring
>> in full support for the mailbox.
> 
> I don't believe remoteproc/rpmsg forces you to use the mailbox for
> communication, and can use other IPC mechanisms.  This still sounds
> cleaner than reinventing remoteproc/rpmsg because of slight variations.
> 
> The linux way is to use and extend what is already there, and if it's
> extended to the breaking point, then make a case for why something new
> is needed.
> 
While I agree to re-use frameworks, am strongly against use of IPC for
the power management which is time sensitive. Imagine a scenario where
ACPI is asked to go through remoteproc/ipc for talking to firmware.
If it takes 10 to 15 uS just to send a command to firmware to change
some control, that just tells something is not right and thats what
IPC will do.

ARM world is also moving towards that by standardizing some of these
through (read PSCI) and thats the way to go in general. Specifically
for this series, I am also against having tons of exports and all
of that should be extracted properly but remoteproc is not going
to be the way. Firmware download has to happen much earlier(ROM
path) so thats not the requirement where we could have used the
remoteproc firmware download feature.

Regards,
Santosh

