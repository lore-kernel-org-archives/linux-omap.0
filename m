From: Suman Anna <s-anna@ti.com>
Subject: Re: Booting recent mainline on omap5-uevm
Date: Wed, 25 Sep 2013 13:37:07 -0500
Message-ID: <52432D53.8090801@ti.com>
References: <A2CA0424C0A6F04399FB9E1CD98E030458E05AC1@US01WEMBX2.internal.synopsys.com> <52421139.1090005@ti.com> <524224CC.5010707@ti.com> <A2CA0424C0A6F04399FB9E1CD98E030458E05BDB@US01WEMBX2.internal.synopsys.com> <5242FB0F.7090704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38908 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab3IYShp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Sep 2013 14:37:45 -0400
In-Reply-To: <5242FB0F.7090704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Zimmerman <Paul.Zimmerman@synopsys.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "lokeshvutla@ti.com" <lokeshvutla@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul,

On 09/25/2013 10:02 AM, Santosh Shilimkar wrote:
> On Tuesday 24 September 2013 07:59 PM, Paul Zimmerman wrote:
>>> From: Suman Anna [mailto:s-anna@ti.com]
>>> Sent: Tuesday, September 24, 2013 4:48 PM
>>>
>>> On 09/24/2013 05:24 PM, Santosh Shilimkar wrote:
>>>> On Tuesday 24 September 2013 04:30 PM, Paul Zimmerman wrote:
>>>>>> From: Paul Zimmerman
>>>>>> Sent: Tuesday, September 24, 2013 1:21 PM
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I have an OMAP5432 uEVM which I cannot get to boot with recent mainline
>>>>>> (tried 3.11 and 3.12-rc1). I have the TI GLSDK for this board (v6.0.0.7),
>>>>>> which comes with 3.8.4 which works fine.
>>>>>>
>>>>>> I found this thread: http://marc.info/?l=fedora-arm&m=137717811815777 and
>>>>>
>>>>> Wrong link, should have been http://marc.info/?l=linux-omap&m=137515583214350.
>>>>>
>>>> Its because of commit 03ab349ec{ARM: OMAP5: hwmod data: Add mailbox data} which
>>>> added hwmod data but DT data for mailbox is missing. Reverting that makes
>>>> things work. Looks like mailbox dt patches missed the last merge window.
>>>
>>> Yeah, the boot sequence tries to enable and idle all the hwmods, and
>>> this results in an error while initializing the mailbox hwmod during the
>>> sysc configuration. This is because the OMAP5 hwmod data file no longer
>>> has the omap_hwmod_addr_space defined in the hwmod_ocp_if data. Two ways
>>> for now to get past is either revert the mailbox hwmod commit as above
>>> or add the DT node [2].
>>>
>>> I will be respinning the mailbox DT series very soon targeting 3.13, so
>>> should not be an issue when OMAP5 boot is supported directly on mainline.
>>
>> That's good info, but unfortunately it didn't work for me. I must have a
>> different problem, maybe I need a newer version of u-boot.
>>
>> So there is no README or wiki that explains how to get Linux to boot on
>> this board? Is there perhaps a prebuilt SD card image somewhere with a
>> recent kernel that I can grab?
>>
> You don't need anything special as such. Just pull the latest mainline
> denx u-boot build it for 'omap5_uevm' and update your boot-loaders.

FYI, I was able to boot using the branch posted by Santosh just fine. I
used v2013.07 u-boot. The boot traces show up about 30~45 seconds after
you see the trace "Starting kernel...".

For using a rootfs from MMC, enable the following in menuconfig:
  Device Drivers -> Multifunction device drivers -> TI Palmas series chips
  Device Drivers -> Voltage and Current Regulator Support -> TI Palmas
PMIC regulators.

Depending on your u-boot settings, make sure the mmcroot is also set to
/dev/mmcblk1p2.

regards
Suman

