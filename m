From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v9] ARM: omap: edma: add suspend resume hook
Date: Thu, 6 Nov 2014 14:03:31 +0530
Message-ID: <545B325B.4050109@ti.com>
References: <1409043173-24357-1-git-send-email-zonque@gmail.com> <545A48F1.8060607@ti.com> <545A4A99.70407@ti.com> <545A682F.4060306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51033 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbaKFId7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 03:33:59 -0500
In-Reply-To: <545A682F.4060306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>, Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com

On Wednesday 05 November 2014 11:40 PM, Dave Gerlach wrote:
> Sekhar,
> On 11/05/2014 10:04 AM, Sekhar Nori wrote:
>> On Wednesday 05 November 2014 09:27 PM, Dave Gerlach wrote:
>>> On 08/26/2014 03:52 AM, Daniel Mack wrote:
>>>> This patch makes the edma driver resume correctly after suspend. Tested
>>>> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
>>>>
>>>> All information can be reconstructed by already known runtime
>>>> information.
>>>>
>>>> As we now use some functions that were previously only used from __init
>>>> context, annotations had to be dropped.
>>>>
>>>> [nm@ti.com: added error handling for runtime + suspend_late/early_resume]
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>>> Tested-by: Joel Fernandes <joelf@ti.com>
>>>> Acked-by: Joel Fernandes <joelf@ti.com>
>>>> ---
>>>> Changes from v8:
>>>>
>>>> 	* Drop the edma_suspend hook altogether. Even though back then
>>>> 	  when I wrote the code I was sure disabling the interrupts
>>>> 	  during suspend is necessary, tests now show it in fact isn't.
>>>> 	  My test setup still works if that code is omitted.
>>>> 	* Use SET_LATE_SYSTEM_SLEEP_PM_OPS in the dev_pm_ops
>>>> 	  declaration.
>>>>
>>>> 	Thanks to Sekhar for pointing out the above.
>>>>
>>>>  arch/arm/common/edma.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++--
>>>>  1 file changed, 58 insertions(+), 2 deletions(-)
>>>
>>> Doesn't seem to be any comments here, any chance this can be picked up? This
>>> patch always seems to get missed but will be needed for suspend/resume on both
>>> AM335x and AM437x.
>>
>> Dave, do you have a branch against mainline with suspend working on any
>> of these SoCs using which I can test this patch?
> 
> Yes, here is WIP of next version with all required patches + this one.
> https://github.com/dgerlach/linux-pm/tree/pm-ds0-v3.18-rc3-WIP
> 
> For suspend to work you need to select:
> 
> CONFIG_WKUP_M3_IPC=y
> CONFIG_WKUP_M3_RPROC=y

I get this:

arch/arm/mach-omap2/pm33xx.c:28:31: fatal error: linux/wkup_m3_ipc.h: No such file or directory
 #include <linux/wkup_m3_ipc.h>
                               ^
compilation terminated.
make[1]: *** [arch/arm/mach-omap2/pm33xx.o] Error 1

Forgot to commit wkup_m3_ipc.h?

Thanks,
Sekhar
 

