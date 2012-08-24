From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v3 4/4] arm/dts: Add tps65217 regulator DT data to am335x-bone.dts
Date: Fri, 24 Aug 2012 10:02:17 +0200
Message-ID: <45D5714B-BB2C-49BB-8C5D-F69749EC324A@dominion.thruhere.net>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com> <1345547850-29761-5-git-send-email-anilkumar@ti.com> <A823657F-0D26-429F-8E1C-DF1AE5AB78F4@dominion.thruhere.net> <331ABD5ECB02734CA317220B2BBEABC13EA1F1D7@DBDE01.ent.ti.com> <583C0877-1C4C-46B6-A5D0-BDD34D6BB7C8@dominion.thruhere.net> <331ABD5ECB02734CA317220B2BBEABC13EA1F3B0@DBDE01.ent.ti.com> <6C2AC14D-1CAC-4B93-910C-B7E52D3355FD@dominion.thruhere.net>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1486\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41535 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308Ab2HXICU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Aug 2012 04:02:20 -0400
Received: by wicr5 with SMTP id r5so604264wic.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Aug 2012 01:02:19 -0700 (PDT)
In-Reply-To: <6C2AC14D-1CAC-4B93-910C-B7E52D3355FD@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>


Op 24 aug. 2012, om 09:56 heeft Koen Kooi <koen@dominion.thruhere.net> het volgende geschreven:

> 
> Op 24 aug. 2012, om 09:26 heeft "AnilKumar, Chimata" <anilkumar@ti.com> het volgende geschreven:
> 
>> Hi Koen,
>> 
>> On Fri, Aug 24, 2012 at 11:58:34, Koen Kooi wrote:
>>> 
>>> Op 24 aug. 2012, om 07:50 heeft "AnilKumar, Chimata" <anilkumar@ti.com> het volgende geschreven:
>>> 
>>>> Hi Koen,
>>>> 
>>>> On Thu, Aug 23, 2012 at 19:43:48, Koen Kooi wrote:
>>>>> 
>>>>> Op 21 aug. 2012, om 13:17 heeft AnilKumar Ch <anilkumar@ti.com> het volgende geschreven:
>>>>> 
>>>>>> Add tps65217 regulator device tree data to AM335x-Bone by adding
>>>>>> regulator consumers with tightened constraints and regulator-name.
>>>>>> TPS65217 regulator handle can be obtained by using this regulator
>>>>>> name.
>>>>>> 
>>>>>> This patch also add I2C node with I2C frequency and tps65217 PMIC
>>>>>> I2C slave address.
>>>>>> 
>>>>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>>>> 
>>>>> I tried this and the kernel immediately crashes on my beaglebone. Could you upload the complete git tree and .config you used to test this to somewhere public please?
>>>> 
>>>> Use this repo to test on beaglebone
>>>> https://github.com/hvaibhav/am335x-linux/commits/am335x-upstream-staging-pinctrl
>>>> 
>>>> This wiki talks about how to build and use?
>>>> https://github.com/hvaibhav/am335x-linux/wiki/How-To-Use-Upstream-Tree
>>>> 
>>>> Note: Enable tps65217 regulator in kernel config.
>>> 
>>> I used that repo and as a seperate test I rebased that to latest mainline, same thing: as soon as I turn on the TPS in the .config it crashes on boot. Is the pinctrl repo the *exact* repo you used to test the patches on beaglebone?
>> 
>> I tested on latest mainline after merging to
>> am335x-upstream-staging-pinctrl (voltage also changing)
>> 
>> Can you share your .config and uImage?
> 
> Config: https://github.com/beagleboard/kernel/blob/beaglebone-3.6/patches/configs/beaglebone
> 
>> My config details:- (After merge)
>> 1. omap2plus_defconfig
>> 2. Enable tps65217 MFD driver
>> 3. Enable tps65217 regulator driver
> 
> 
> I rebased onto latest mainline and refreshed the base patches from Vaibhav and I now get: 
> 
> [    0.246796] tps65217 0-0024: TPS65217 ID 0xf version 1.1
> 
> So it boots! I don't know what made it break before, but it's working now :)

*sigh* I'm an idiot:

root@beaglebone:~# uname -a
Linux beaglebone 3.6.0-rc3-00103-gfd02083 #86 SMP Fri Aug 24 09:45:54 CEST 2012 armv7l GNU/Linux
root@beaglebone:~# zcat /proc/config.gz | grep 217
CONFIG_MFD_TPS65217=y
# CONFIG_REGULATOR_TPS65217 is not set

Will retry with regulator driver actually turned on in a bit.