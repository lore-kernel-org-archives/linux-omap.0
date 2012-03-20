From: Thomas Klute <thomas2.klute@uni-dortmund.de>
Subject: Re: smsc911x on Gumstix Overo/Tobi doesn't work
Date: Tue, 20 Mar 2012 15:27:18 +0100
Message-ID: <4F6893C6.60701@uni-dortmund.de>
References: <4F6324D5.9010106@uni-dortmund.de> <20120316193337.GE7276@atomide.com> <4F675D9D.2040102@uni-dortmund.de> <20120319225131.GE9859@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000802050607050707000709"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.HRZ.Uni-Dortmund.DE ([129.217.128.51]:53264 "EHLO
	unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344Ab2CTO1q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Mar 2012 10:27:46 -0400
In-Reply-To: <20120319225131.GE9859@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000802050607050707000709
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 19.03.2012 23:51, schrieb Tony Lindgren:
> * Thomas Klute <thomas2.klute@uni-dortmund.de> [120319 09:26]:
>> Am 16.03.2012 20:33, schrieb Tony Lindgren:
>>> Hi,
>>>
>>> * Thomas Klute <thomas2.klute@uni-dortmund.de> [120316 05:08]:
>>>> Hi,
>>>>
>>>> I have trouble getting the Ethernet port on a Gumstix Overo with Tobi
>>>> expansion board to work with current kernel versions. With the latest
>>>> commit from linux-omap git (b8fe1781ec8bed5e086691a827a6ee11facec2aa),
>>>> the output from loading the smsc911x driver is as follows:
>>>>
>>>> du14:~# modprobe smsc911x
>>>> [  254.843811] smsc911x: Driver version 2008-10-21
>>>> [  254.854553] smsc911x: Driver version 2008-10-21
>>>> [  254.859588] _regulator_get: smsc911x.1 supply vdd33a not found, using
>>>> dummy regulator
>>>> [  254.868377] _regulator_get: smsc911x.1 supply vddvario not found,
>>>> using dummy regulator
>>>>
>>>> "ip link show" does not show any available Ethernet port.
>>>
>>> The first instance one should work the same way as earlier using
>>> fixed regulator in gpmc-smsc911x.c. Is it not working for you
>>> somehow? At least it works for me on zoom3.
>>
>> The Tobi board has only one Ethernet port.
>>
>>>> I know there has been some trouble with changes around smsc911x
>>>> regulator support and Gumstix Overo in particular. Am I just missing the
>>>> right regulator in my kernel config or is this a bug? I can test patches
>>>> in the latter case.
>>>
>>> The second smsc911x now needs a regulator. For multiple smsc911x instances,
>>> we should change things around so no regulator is created if one
>>> is passed.
>>>
>>> Care to test the following patch by passing a fixed regulator
>>> from board-overo.c?
>>
>> After applying the patch the Ethernet port works consistently once I had
>> done a cold boot (reboot from the unpatched kernel did not work).
>> Thank you!
> 
> Hmm but this patch should not change the behaviour for the first smsc911x
> instance unless you specify a custom regulator.. Did you patch in a
> custom regulator, or do we have a bug somewhere? Or do you just need to
> do a cold reset without the patch I posted?

You're right, during further tests I found that the problem lies
elsewhere: If the Ethernet cable is attached on modprobe, the device
works as expected, if not, it's not found (with or without the patch).
This means if I boot with the cable disconnected, the device won't show
up, but after

# modprobe -r smsc911x
[attach cable]
# modprobe smsc911x

it will work. I'd still consider this a bug, but it doesn't seem to be a
regulator problem.

>> However, I noticed another problem while testing the patch (not sure if
>> it occurs with the previous version, I can check if that helps): A NULL
>> pointer dereference occurs when unloading the module, see attached log.
> 
> Yes please do check, that needs to be fixed.

The NULL pointer dereference occurs with the unpatched kernel as well.
I've attached the log, although I don't see a major difference to the
one from the patched kernel. Note that this only happens when the driver
works properly (that is, eth0 is usable). I can unload the driver
without problems if it is not working as described above.

Regards,
Thomas

--------------000802050607050707000709
Content-Type: text/x-log;
 name="smsc911x-unload-error-unpatched.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="smsc911x-unload-error-unpatched.log"

[  286.276245] Unable to handle kernel NULL pointer dereference at virtual address 0000073c
[  286.285308] pgd = ce744000
[  286.288818] [0000073c] *pgd=00000000
[  286.293151] Internal error: Oops: 5 [#1]
[  286.297271] Modules linked in: ipt_MASQUERADE xt_tcpudp iptable_nat nf_nat nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4 ip_tables x_tables snd_soc_twl4030 ath9k_htc ath9k_common ath9k_hw carl9170 ath ohci_hcd smsc libertas_sdio libertas snd_soc_core regmap_spi regmap_i2c snd_pcm snd_timer smsc911x(-) ehci_hcd snd soundcore snd_page_alloc twl4030_usb
[  286.330047] CPU: 0    Tainted: G        W     (3.3.0-rc7-11899-gb8fe178 #102)
[  286.337554] PC is at regulator_bulk_disable+0x18/0x90
[  286.342895] LR is at smsc911x_drv_remove+0xd4/0xf4 [smsc911x]
[  286.348907] pc : [<c02395fc>]    lr : [<bf03c9cc>]    psr: 80000013
[  286.348907] sp : ce6c7ed8  ip : 00000002  fp : becdfdb4
[  286.360961] r10: 00000738  r9 : ce6c6000  r8 : 00000002
[  286.366424] r7 : cec85408  r6 : 00000738  r5 : cec85400  r4 : 00000000
[  286.373260] r3 : ce628bc0  r2 : 00000000  r1 : 00000738  r0 : 00000002
[  286.380096] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  286.387603] Control: 10c5387d  Table: 8e744019  DAC: 00000015
[  286.393615] Process modprobe (pid: 2393, stack limit = 0xce6c62f0)
[  286.400085] Stack: (0xce6c7ed8 to 0xce6c8000)
[  286.404663] 7ec0:                                                       ce628bc0 ce615800
[  286.413238] 7ee0: cec85400 00000000 cec85408 c000d484 00000000 bf03c9cc bf03c8f8 cec85408
[  286.421813] 7f00: bf03e6dc cec8543c 00000081 c02618d0 c02618bc c026041c cec85408 bf03e6dc
[  286.430389] 7f20: cec8543c c02609f0 bf03e6dc 00000000 c0664b08 c02602f8 bf03e718 00000000
[  286.438995] 7f40: b6f581b0 c0064db0 ce484488 63736d73 78313139 c00a3b00 ce628bc0 00000001
[  286.447570] 7f60: 00000000 ce628bc0 00000001 c000d3d4 00000081 60000010 b6f58208 becdfdc0
[  286.456146] 7f80: becdfdb4 0005e8c8 b6f58180 b6f58180 b6f581b0 00000000 b6f58180 b6f58180
[  286.464721] 7fa0: b6f581b0 c000d2c0 b6f58180 b6f58180 b6f581b0 00000000 b6f57000 00000000
[  286.473297] 7fc0: b6f58180 b6f58180 b6f581b0 00000081 00000000 b6f58208 becdfdc0 becdfdb4
[  286.481872] 7fe0: 00000000 becde990 b6f40988 b6e6eb5c 60000010 b6f581b0 8f2fe821 8f2fec21
[  286.490478] [<c02395fc>] (regulator_bulk_disable+0x18/0x90) from [<bf03c9cc>] (smsc911x_drv_remove+0xd4/0xf4 [smsc911x])
[  286.501922] [<bf03c9cc>] (smsc911x_drv_remove+0xd4/0xf4 [smsc911x]) from [<c02618d0>] (platform_drv_remove+0x14/0x18)
[  286.513061] [<c02618d0>] (platform_drv_remove+0x14/0x18) from [<c026041c>] (__device_release_driver+0x7c/0xbc)
[  286.523590] [<c026041c>] (__device_release_driver+0x7c/0xbc) from [<c02609f0>] (driver_detach+0x8c/0xb4)
[  286.533538] [<c02609f0>] (driver_detach+0x8c/0xb4) from [<c02602f8>] (bus_remove_driver+0x8c/0xb4)
[  286.542938] [<c02602f8>] (bus_remove_driver+0x8c/0xb4) from [<c0064db0>] (sys_delete_module+0x1ec/0x280)
[  286.552917] [<c0064db0>] (sys_delete_module+0x1ec/0x280) from [<c000d2c0>] (ret_fast_syscall+0x0/0x3c)
[  286.562683] Code: e1a06001 e1a0a001 e3a04000 ea000006 (e59a0004) 
[  286.571838] ---[ end trace f0a226828d962479 ]---
Speicherzugriffsfehler

--------------000802050607050707000709--
