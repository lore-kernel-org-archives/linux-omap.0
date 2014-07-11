From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v4 00/11] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Fri, 11 Jul 2014 12:31:06 -0500
Message-ID: <53C01F5A.6040409@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com> <20140711153019.GA75267@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40317 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbaGKRbc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jul 2014 13:31:32 -0400
In-Reply-To: <20140711153019.GA75267@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andre Heider <a.heider@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>

Andre,

On 07/11/2014 10:30 AM, Andre Heider wrote:
> Hi Dave,
>
> On Thu, Jul 10, 2014 at 09:55:38PM -0500, Dave Gerlach wrote:
>> Hello,
>>
>> This series adds suspend/resume support for am335x. Version 3 of this
>> series can be found at [1]. I apologize for the large delay between this
>> and the previous revision. This code has been heavily refined
>> since the last version based on the various comments received for v3. The
>> major change from previous version is moving all wkup_m3 code into a
>> remoteproc based driver. The new driver handles all IPC and fw loading
>> and exposes a small API to be used by PM code to achieve low power states.
>>
>> Firmware that can be used for testing this can be found at [2] on branch
>> pm-remote-proc-v3, using am335x-pm-firmware.elf found in bin directory.
>> Please note this has changed from all previous versions and is no longer
>> the .bin file. Firmware can be built into kernel or placed in /lib/firmware
>> in rootfs for automatic loading during boot.
>>
>> This series has several dependencies. The wkup_m3_rproc utilizes a mailbox
>> to communicate with the cm3 and depends on Suman's series for omap mbox
>> support [3], which has several dependencies of it's own, listed in the
>> cover letter. Also, a few changes to remoteproc itself were needed and
>> have been provided by Suman here [4]. The edma patch included in this
>> series was previously submitted by Daniel Mack and after discussion with
>> him we agreed to include an updated version with this series as resume
>> has a direct dependency on it due to hangs in mmc without it.
>>
>> Because of the high number of dependencies I have pushed a branch for
>> testing here [6] if anyone desires to try it out on branch pm-ds0-v3.16.
>>
>> As is this series will only suspend and resume one time and then
>> fail to resume afterwards due to the removal of direct PM code control
>> of hwmods that do not properly assert their MSTANDBY signal after a context
>> loss, discussed here [7]. In particular it is due to the usb_otg_hs hwmod
>> that currently has no driver controlling it in the kernel. The main
>> cause of the issue is that the SYSCONFIG register present within
>> the IP must be reprogrammed after every suspend cycle and this
>> only happens at boot if no driver is present. Work is in progress to
>> allow suspend to function with or without drivers for the troublesome
>> hwmods (cpgmac, usb_otg_hs, and tptc1-3) and will be provided in a separate
>> future patch. The previous suggestion of allowing omap_device to handle
>> it proved to be too invasive into both omap_device and omap_hwmod and
>> the approach of allowing the firmware to handle it is not possible due
>> to the inability of the CM3 to access the IPs causing the issue. I'd
>> be happy to discuss this at length if anybody is interested.
>
> I gave this a quick spin on boneblack, and it works for me, thanks!
>
> Tested with "echo mem > /sys/power/state" and uart0 input to resume.
>

Thanks for trying it out!

> Contradictionary to the limits you mention, multiple suspend/resume cycles
> do work for me. Maybe because of the enabled drivers in my .config, or
> maybe something was messed up, but at first glance it looked fine.

Yes, if you have USB enabled and the driver is present, the usb hwmod is 
properly handled and SYSCONFIG properly restored, it is only when there is no 
driver as is the case with the defconfig that we run in to issues. Looking back 
I was not clear about that, sorry.

>
> It fails to compile with CONFIG_THUMB2_KERNEL though:
> arch/arm/mach-omap2/sleep33xx.S:61: Error: cannot use register index
> with PC-relative addressing -- `str r1,emif_addr_virt'

Hmm, interestingly enough I can not reproduce this build error. Can you share 
your config and compiler version?

>
> Then I noticed "freeze" in /sys/power/state, when triggered then crashes
> with a null pointer dereference in suspend_devices_and_enter(). That might
> be expected or even stupid though ;)

This is present before my patches are applied, this series adds support for 
PM_SUSPEND_MEM, that's something else I probably should have been a bit more 
clear about in my cover letter.

Regards,
Dave

>
> Thanks,
> Andre
>

