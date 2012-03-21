From: Thomas Klute <thomas2.klute@uni-dortmund.de>
Subject: Re: smsc911x on Gumstix Overo/Tobi doesn't work
Date: Wed, 21 Mar 2012 17:29:48 +0100
Message-ID: <4F6A01FC.3080804@uni-dortmund.de>
References: <4F6324D5.9010106@uni-dortmund.de> <20120316193337.GE7276@atomide.com> <4F675D9D.2040102@uni-dortmund.de> <20120319225131.GE9859@atomide.com> <4F6893C6.60701@uni-dortmund.de> <CAAwP0s3Qo7vtt=BY7Pvejg4Gc9X0O0n=yWg0JVGZHrmUJScMXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.HRZ.Uni-Dortmund.DE ([129.217.128.51]:36520 "EHLO
	unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab2CUQ3w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 12:29:52 -0400
In-Reply-To: <CAAwP0s3Qo7vtt=BY7Pvejg4Gc9X0O0n=yWg0JVGZHrmUJScMXw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org



Am 20.03.2012 20:47, schrieb Javier Martinez Canillas:
> On Tue, Mar 20, 2012 at 3:27 PM, Thomas Klute
> <thomas2.klute@uni-dortmund.de> wrote:
>> Am 19.03.2012 23:51, schrieb Tony Lindgren:
>>> * Thomas Klute <thomas2.klute@uni-dortmund.de> [120319 09:26]:
>>>> Am 16.03.2012 20:33, schrieb Tony Lindgren:
>>>>> Hi,
>>>>>
>>>>> * Thomas Klute <thomas2.klute@uni-dortmund.de> [120316 05:08]:
>>>>>> Hi,
>>>>>>
>>>>>> I have trouble getting the Ethernet port on a Gumstix Overo with Tobi
>>>>>> expansion board to work with current kernel versions. With the latest
>>>>>> commit from linux-omap git (b8fe1781ec8bed5e086691a827a6ee11facec2aa),
>>>>>> the output from loading the smsc911x driver is as follows:
>>>>>>
>>>>>> du14:~# modprobe smsc911x
>>>>>> [  254.843811] smsc911x: Driver version 2008-10-21
>>>>>> [  254.854553] smsc911x: Driver version 2008-10-21
>>>>>> [  254.859588] _regulator_get: smsc911x.1 supply vdd33a not found, using
>>>>>> dummy regulator
>>>>>> [  254.868377] _regulator_get: smsc911x.1 supply vddvario not found,
>>>>>> using dummy regulator
>>>>>>
>>>>>> "ip link show" does not show any available Ethernet port.
>>>>>
>>>>> The first instance one should work the same way as earlier using
>>>>> fixed regulator in gpmc-smsc911x.c. Is it not working for you
>>>>> somehow? At least it works for me on zoom3.
>>>>
>>>> The Tobi board has only one Ethernet port.
>>>>
>>>>>> I know there has been some trouble with changes around smsc911x
>>>>>> regulator support and Gumstix Overo in particular. Am I just missing the
>>>>>> right regulator in my kernel config or is this a bug? I can test patches
>>>>>> in the latter case.
>>>>>
>>>>> The second smsc911x now needs a regulator. For multiple smsc911x instances,
>>>>> we should change things around so no regulator is created if one
>>>>> is passed.
>>>>>
>>>>> Care to test the following patch by passing a fixed regulator
>>>>> from board-overo.c?
>>>>
>>>> After applying the patch the Ethernet port works consistently once I had
>>>> done a cold boot (reboot from the unpatched kernel did not work).
>>>> Thank you!
>>>
>>> Hmm but this patch should not change the behaviour for the first smsc911x
>>> instance unless you specify a custom regulator.. Did you patch in a
>>> custom regulator, or do we have a bug somewhere? Or do you just need to
>>> do a cold reset without the patch I posted?
>>
>> You're right, during further tests I found that the problem lies
>> elsewhere: If the Ethernet cable is attached on modprobe, the device
>> works as expected, if not, it's not found (with or without the patch).
>> This means if I boot with the cable disconnected, the device won't show
>> up, but after
>>
>> # modprobe -r smsc911x
>> [attach cable]
>> # modprobe smsc911x
>>
>> it will work. I'd still consider this a bug, but it doesn't seem to be a
>> regulator problem.
>>
> 
> Hi Thomas,
> 
> I had the same behavior with the smsc911x chip but on an IGEPv2 board.
> The problem was when CONFIG_SMSC_PHY=y since the driver for the chip
> internal PHY enables an energy detect power-down mode.
> 
> The smsc911x driver probe function tries to software reset the chip
> but if the cable is unplugged the energy detect puts the chip in a low
> power mode. Since the chip is not in an operational state the reset
> fails and hence the driver probe function. If the cable is plugged
> then then energy is detected, the chip is in an operational state and
> the reset is successful.
> 
> I sent a patch a few months ago to fix this issue. The patch disables
> the energy detect power-down mode before reseting the chip and then it
> enables again after reset.
> 
> The commit is:
> 
> commit 6386994e03ebbe60338ded3d586308a41e81c0dc
> Author: Javier Martinez Canillas <javier@dowhile0.org>
> Date:   Tue Jan 3 13:36:19 2012 +0000
> 
>     net/smsc911x: Check if PHY is in operational mode before software reset
> 
> When I fix the issue I only guarded against generation 4 chips (i.e:
> pdata->generation == 4), but maybe this problem also exists in other
> SMSC chips (I didn't know since I only had access to specific
> data-sheets).
> 
> Also you can try enabling debug in the driver by setting USE_DEBUG to
> 1 in drivers/net/ethernet/smsc/smsc911x.h and also trying disabling
> CONFIG_SMSC_PHY, this will use a generic PHY driver that doesn't put
> the chip in auto power mode.

Hi Javier,

thanks for the hint. Deactivating CONFIG_SMSC_PHY didn't help, but I'll
look into activating USE_DEBUG later.

Regards,
Thomas
