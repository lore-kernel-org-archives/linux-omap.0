From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: pm-core broken
Date: Thu, 16 Dec 2010 10:40:08 -0800
Message-ID: <87fwtxef3r.fsf@deeprootsystems.com>
References: <4D09719E.7080700@ti.com> <4D0978F3.3090704@ti.com>
	<87wrn9hdxy.fsf@deeprootsystems.com> <4D0A52F0.8060603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41996 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab0LPSkO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 13:40:14 -0500
Received: by pva4 with SMTP id 4so544593pva.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 10:40:14 -0800 (PST)
In-Reply-To: <4D0A52F0.8060603@ti.com> (Nishanth Menon's message of "Thu, 16
	Dec 2010 11:57:04 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman had written, on 12/16/2010 10:36 AM, the following:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>> Hi Kevin,
>>>
>>> Just fyi, I tested pm-core(no patches of mine) against SDP3430(ES3.1)
>>> and Beagle Rev C1(ES3.0) (that is the only board I could dig up): both
>>> fail - I think basically <3630 is broken atm!.
>>>
>>> Beagleboard:
>>> with omap2plus_defconfig + MLO, u-boot.bin from
>>> http://www.angstrom-distribution.org/demo/beagleboard/
>>> filesystem is a minimal busybox that I had built and init=/bin/sh to
>>> prevent any other apps running in the background - I use the same on
>>> SDP3630 and 3430 platforms.
>>>
>>> branch: pm-core (from your tree).
>>> defconfig: omap2plus_defconfig - no changes other than disable RM680
>>> board - currently causes a build failure.
>>
>> At least for Beagle (and I assume it's same for SDP, but don't have one
>> to test with) the problem is that u-boot leaves the USB OTG block in a
>> state that does not idle, and thus prevents CORE from hitting RET.
>>
>> The solution: ensure the USB OTG block is reset.
>>
>> Also in my tree, threre is an usb-otg-reset branch which you can merge
>> with pm-core to test if this helps.
>>
>> Until we have the USB OTG hwmod conversion merged, this temporary hack
>> is needed.  After conversion to hwmod, all hwmod will be reset during
>> boot so we are not affected by bootloader (mis)behavior.
>
> Arrgh.. we have some sort of regression for .37 formal release (off
> will probably broken as a result without these patches no for mainline
> bootloaders/custom bootloaders that dont understand the dependency
> clearly?).

Just to be clear, this is technically not a regression.  This has always
been true of mainline kernels since most IP blocks are not reset by the
kernel.

Bootloaders for various boards have always done strange (a.k.a broken)
things and left the HW in a state that cannot properly idle.  The only
solution is to ensure all IPs are fully reset on boot.

> Anyways, with the 5 patches in usb-otg-reset - test results:
> SDP3630 (ES1.0):
> SUSPEND:OFF test | PASS | OFF: 0->1| RET:0 ->0 (8 sec)
> SUSPEND:RET test | PASS | OFF: 1->1| RET:0 ->1 (6 sec)
> IDLE:OFF test | PASS | OFF: 1->22| RET:1 ->1 (21 sec)
> IDLE:RET test | PASS | OFF: 22->22| RET:1 ->24 (21 sec)
>
> SDP3430 (ES3.1):
> SUSPEND:OFF test | PASS | OFF: 0->1| RET:0 ->0 (7 sec) 
> SUSPEND:RET test | PASS | OFF: 1->1| RET:0 ->1 (6 sec) 
> IDLE:OFF test | PASS | OFF: 1->21| RET:1 ->1 (22 sec) 
> IDLE:RET test | PASS | OFF: 21->21| RET:1 ->23 (21 sec)
>
> Beagle C1 (ES3.0):
> SUSPEND:OFF test | FAIL | OFF: 0->0| RET:0 ->0 (6 sec) 
> SUSPEND:RET test | FAIL | OFF: 0->0| RET:0 ->0 (6 sec) 
> IDLE:OFF test | FAIL | OFF: 0->0| RET:0 ->0 (21 sec) 
> IDLE:RET test | FAIL | OFF: 0->0| RET:0 ->0 (21 sec)

Your Beagle u-boot must be leaving something else on besides OTG.  I'm
using a relatively recent u-boot 

    U-Boot 2010.12-rc1 (Nov 16 2010 - 08:31:35)                                     

that I built from source for my Beagle C3 (ES3.0), and suspend/idle test
works for me:

SUSPEND:OFF test | PASS | OFF: 0->1| RET:0 ->0 (6 sec)                          
SUSPEND:RET test | PASS | OFF: 1->1| RET:0 ->1 (6 sec)                          
IDLE:OFF test | PASS | OFF: 1->4| RET:1 ->4 (21 sec)                            
IDLE:RET test | PASS | OFF: 4->4| RET:4 ->11 (21 sec)                           

Is it still CORE that's not hitting RET for you?

Thanks,

Kevin
