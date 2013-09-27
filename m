From: Suman Anna <s-anna@ti.com>
Subject: Re: Solved: Booting recent mainline on omap5-uevm
Date: Thu, 26 Sep 2013 21:24:33 -0500
Message-ID: <5244EC61.9030408@ti.com>
References: <A2CA0424C0A6F04399FB9E1CD98E030458E065EA@US01WEMBX2.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59566 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab3I0CZO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Sep 2013 22:25:14 -0400
In-Reply-To: <A2CA0424C0A6F04399FB9E1CD98E030458E065EA@US01WEMBX2.internal.synopsys.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Zimmerman <Paul.Zimmerman@synopsys.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "lokeshvutla@ti.com" <lokeshvutla@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 09/26/2013 06:44 PM, Paul Zimmerman wrote:
>> From: Suman Anna [mailto:s-anna@ti.com]
>> Sent: Thursday, September 26, 2013 1:36 PM
> 
>>>>>>>>>> I have an OMAP5432 uEVM which I cannot get to boot with recent mainline
>>>>>>>>>> (tried 3.11 and 3.12-rc1). I have the TI GLSDK for this board (v6.0.0.7),
>>>>>>>>>> which comes with 3.8.4 which works fine.
>>>>>>>>>>
>>>>>>>>>> I found this thread: http://marc.info/?l=fedora-arm&m=137717811815777 and
>>>>>>>>>
>>>>>>>>> Wrong link, should have been http://marc.info/?l=linux-omap&m=137515583214350.
>>>>>>>>>
>>>>>>>> Its because of commit 03ab349ec{ARM: OMAP5: hwmod data: Add mailbox data} which
>>>>>>>> added hwmod data but DT data for mailbox is missing. Reverting that makes
>>>>>>>> things work. Looks like mailbox dt patches missed the last merge window.
>>>>>>>
>>>>>>> I will be respinning the mailbox DT series very soon targeting 3.13, so
>>>>>>> should not be an issue when OMAP5 boot is supported directly on mainline.
>>>>>>
>>>>>> That's good info, but unfortunately it didn't work for me. I must have a
>>>>>> different problem, maybe I need a newer version of u-boot.
>>>>>>
>>>>>> So there is no README or wiki that explains how to get Linux to boot on
>>>>>> this board? Is there perhaps a prebuilt SD card image somewhere with a
>>>>>> recent kernel that I can grab?
>>>>>>
>>>>> You don't need anything special as such. Just pull the latest mainline
>>>>> denx u-boot build it for 'omap5_uevm' and update your boot-loaders.
>>>>
>>>> FYI, I was able to boot using the branch posted by Santosh just fine. I
>>>> used v2013.07 u-boot. The boot traces show up about 30~45 seconds after
>>>> you see the trace "Starting kernel...".
>>>>
>>>> For using a rootfs from MMC, enable the following in menuconfig:
>>>>   Device Drivers -> Multifunction device drivers -> TI Palmas series chips
>>>>   Device Drivers -> Voltage and Current Regulator Support -> TI Palmas
>>>> PMIC regulators.
>>>>
>>>> Depending on your u-boot settings, make sure the mmcroot is also set to
>>>> /dev/mmcblk1p2.
>>>
>>> Hi Suman,
>>>
>>> Thanks for trying to help. Unfortunately, updating to v2013.07 u-boot, and
>>> enabling the kernel config items you mentioned, didn't make a difference.
>>>
>>> Could you share your boot.scr? I'm still using the one from the TI GLSDK,
>>> but maybe something has changed since the 3.8 kernel? Also, how do you
>>> build your kernel? I'm doing "make LOADADDR=0x80008000 uImage" because
>>> newer kernels won't build without the LOADADDR= bit.
>>
>> I build the kernel same way as you, and copy the zImage to boot
>> partition. I am not using any boot.scr, a simple uEnv.txt to override
>> the boot partition variables, and the default environment otherwise.
>>
>> My boot log is here, including my uEnv.txt at the end.
>> http://hastebin.com/yinuxirexu.xml
>>
>> Hopefully, this should clear out any setup differences..
> 
> Thanks Suman!
> 
> Using your info I was able to get the board to boot. 

Glad I could help..

> I added a third line to your uEnv.txt, so I don't have to break into
> u-boot and type "setenv mmcroot /dev/mmcblk1p2 rw":
> 
> 	bootdir=
> 	bootpart=0:1
> 	mmcroot="/dev/mmcblk1p2 rw"
> 
> Or I suppose you could add that to the kernel command line in the kernel
> config.

The uEnv.txt approach is good, since you can use the same image on other
boards without resorting to other changes in environment for them.

> 
> I'm seeing several stack dumps during the boot, with messages like
> "division by 0 in the kernel", but I suppose that has nothing to do with
> my boot problems. And it does boot to the login: prompt on the serial
> console.

Yeah, those I believe are related to the ABE and USB DPLL locking (or
lack of) issues.

regards
Suman
