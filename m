From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v9] ARM: omap: edma: add suspend resume hook
Date: Wed, 5 Nov 2014 12:10:55 -0600
Message-ID: <545A682F.4060306@ti.com>
References: <1409043173-24357-1-git-send-email-zonque@gmail.com> <545A48F1.8060607@ti.com> <545A4A99.70407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42389 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbaKESLe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2014 13:11:34 -0500
In-Reply-To: <545A4A99.70407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com

Sekhar,
On 11/05/2014 10:04 AM, Sekhar Nori wrote:
> On Wednesday 05 November 2014 09:27 PM, Dave Gerlach wrote:
>> On 08/26/2014 03:52 AM, Daniel Mack wrote:
>>> This patch makes the edma driver resume correctly after suspend. Tested
>>> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
>>>
>>> All information can be reconstructed by already known runtime
>>> information.
>>>
>>> As we now use some functions that were previously only used from __init
>>> context, annotations had to be dropped.
>>>
>>> [nm@ti.com: added error handling for runtime + suspend_late/early_resume]
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>> Tested-by: Joel Fernandes <joelf@ti.com>
>>> Acked-by: Joel Fernandes <joelf@ti.com>
>>> ---
>>> Changes from v8:
>>>
>>> 	* Drop the edma_suspend hook altogether. Even though back then
>>> 	  when I wrote the code I was sure disabling the interrupts
>>> 	  during suspend is necessary, tests now show it in fact isn't.
>>> 	  My test setup still works if that code is omitted.
>>> 	* Use SET_LATE_SYSTEM_SLEEP_PM_OPS in the dev_pm_ops
>>> 	  declaration.
>>>
>>> 	Thanks to Sekhar for pointing out the above.
>>>
>>>  arch/arm/common/edma.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 58 insertions(+), 2 deletions(-)
>>
>> Doesn't seem to be any comments here, any chance this can be picked up? This
>> patch always seems to get missed but will be needed for suspend/resume on both
>> AM335x and AM437x.
> 
> Dave, do you have a branch against mainline with suspend working on any
> of these SoCs using which I can test this patch?

Yes, here is WIP of next version with all required patches + this one.
https://github.com/dgerlach/linux-pm/tree/pm-ds0-v3.18-rc3-WIP

For suspend to work you need to select:

CONFIG_WKUP_M3_IPC=y
CONFIG_WKUP_M3_RPROC=y

And you need to enable USB for multiple suspends to work.

You can get am335x-pm-firmware.elf FW here from HEAD:
https://git.ti.com/ti-cm3-pm-firmware/amx3-cm3/commits/next

You can place in /lib/firmware and select CONFIG_FW_LOADER_USER_HELPER_FALLBACK
or build into kernel.

Also for what it's worth you can have my tested by:

Tested-by: Dave Gerlach <d-gerlach@ti.com>

I have tested on am335x-boneblack, am335x-evm, and am335x-evmsk, multiple
suspend cycles work with no issue.

Regards,
Dave

> 
> Thanks,
> Sekhar
> 

