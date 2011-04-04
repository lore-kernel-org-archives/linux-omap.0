From: Peter Barada <peter.barada@logicpd.com>
Subject: Re: Question regarding suspend/resume
Date: Mon, 04 Apr 2011 10:31:26 -0400
Message-ID: <4D99D63E.5020009@logicpd.com>
References: <4D7FBD31.6050806@gmail.com> <87wrk0gn41.fsf@ti.com>	<4D94E148.8060905@gmail.com> <8739m3auex.fsf@ti.com> <19F8576C6E063C45BE387C64729E739404E2338367@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 174-46-170-154.static.twtelecom.net ([174.46.170.154]:55272
	"EHLO edprlnx06.logicpd.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754506Ab1DDOiY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 10:38:24 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739404E2338367@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Peter Barada <peter.barada@gmail.com>, Linux OMAP list <linux-omap@vger.kernel.org>

On 04/01/2011 01:05 AM, Hiremath, Vaibhav wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Hilman, Kevin
>> Sent: Friday, April 01, 2011 2:18 AM
>> To: Peter Barada
>> Cc: Linux OMAP list
>> Subject: Re: Question regarding suspend/resume
>>
>> Hi Peter,
>>
>> Peter Barada <peter.barada@gmail.com> writes:
>>
>> [...]
>>
>>> Thanks for helping me to understand things.
>>>
>>> The kernel I'm using is TI's OMAPPSP_03.00.01.06 2.6.32 kernel [1]
>>> with their u-boot [2] and x-loader[3], modified to run on Logic's
>>> DM3730 board(s) (as we use the Micron mt29c4g48mazapakq-5 POP).
>> I'm afraid somone who supports that older TI kernel will have to help
>> you out.
>>
> [Hiremath, Vaibhav] Peter,
>
> I have validated the release kernel (along with x-loader/uboot) on OMAP3EVM, and it does work without any issues.
>
> I have personally validated this with latest Arago repos, probably you may want to share the changes you have made in x-loader/uboot/kernel to port PSP2.6.32 to LogicPD hardware.
[Barada, Peter] Viabhav, I've also validated that the x-loader/u-boot/kernel built from the OMAPPSP_03.00.01.06 tags suspends on the DM3730EVM hardware.  I'llp ut together a set of patches to those and send you a pointer where to find them.  What I'm trying now is to cut board-omap3evm.c down to just the serial/mmc to see if the DM3730EVM shows the same effect; it could be that u-boot has put some of the hardware into a state that the kernel handles in the suspend path but my minimal kernel doesn't.  At least that would tell me I'm on the right path.
> Thanks,
> Vaibhav
>
>> If you can reproduce on a current kernel, I'd be glad to help but I'm
>> currently not able (well, not willing is more accurate) to try and
>> figure out what's going on based on an older kernel with who knows how
>> many out-of-tree patches/hacks piled on.
>>
>> What I can say based on the register dump you shared is that there is no
>> obvious driver issue going on where a clock was left on by a driver.
>>
>> More than likely what is going on is that the booloader is using a
>> device (e.g. USB, MMC) but is leaving it in a state such that that IP
>> block cannot idle, so the CORE powerdomain then does not fully idle.
>> In older kernels like this one, the linux drivers did not fully reset
>> the hardware so bootloaders could cause problems like this (the u-boot
>> on beagle has had several problems like this.)
>>
>> As a first whack at things, I would focus on USB OTG and MMC, as I've
>> seen problem with both on other platforms, like Beagle.  You need to
>> ensure that both the these modules are fully reset either by the
>> bootloader when it's done using them, or by the kernel in the early boot
>> process.  Current kernels now do the latter.
>>
>> Sorry I can't be of more help,
>>
>> Kevin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Peter Barada
peter.barada@logicpd.com

