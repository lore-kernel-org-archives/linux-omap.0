From: Nishanth Menon <nm@ti.com>
Subject: Re: pm-core broken
Date: Thu, 16 Dec 2010 11:57:04 -0600
Message-ID: <4D0A52F0.8060603@ti.com>
References: <4D09719E.7080700@ti.com> <4D0978F3.3090704@ti.com> <87wrn9hdxy.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:59031 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752284Ab0LPR5I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 12:57:08 -0500
Received: by mail-vw0-f51.google.com with SMTP id 20so1451536vws.38
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 09:57:07 -0800 (PST)
In-Reply-To: <87wrn9hdxy.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman had written, on 12/16/2010 10:36 AM, the following:
> Nishanth Menon <nm@ti.com> writes:
> 
>> Hi Kevin,
>>
>> Just fyi, I tested pm-core(no patches of mine) against SDP3430(ES3.1)
>> and Beagle Rev C1(ES3.0) (that is the only board I could dig up): both
>> fail - I think basically <3630 is broken atm!.
>>
>> Beagleboard:
>> with omap2plus_defconfig + MLO, u-boot.bin from
>> http://www.angstrom-distribution.org/demo/beagleboard/
>> filesystem is a minimal busybox that I had built and init=/bin/sh to
>> prevent any other apps running in the background - I use the same on
>> SDP3630 and 3430 platforms.
>>
>> branch: pm-core (from your tree).
>> defconfig: omap2plus_defconfig - no changes other than disable RM680
>> board - currently causes a build failure.
> 
> At least for Beagle (and I assume it's same for SDP, but don't have one
> to test with) the problem is that u-boot leaves the USB OTG block in a
> state that does not idle, and thus prevents CORE from hitting RET.
> 
> The solution: ensure the USB OTG block is reset.
> 
> Also in my tree, threre is an usb-otg-reset branch which you can merge
> with pm-core to test if this helps.
> 
> Until we have the USB OTG hwmod conversion merged, this temporary hack
> is needed.  After conversion to hwmod, all hwmod will be reset during
> boot so we are not affected by bootloader (mis)behavior.

Arrgh.. we have some sort of regression for .37 formal release (off will 
probably broken as a result without these patches no for mainline 
bootloaders/custom bootloaders that dont understand the dependency 
clearly?).

Anyways, with the 5 patches in usb-otg-reset - test results:
SDP3630 (ES1.0):
SUSPEND:OFF test | PASS | OFF: 0->1| RET:0 ->0 (8 sec)
SUSPEND:RET test | PASS | OFF: 1->1| RET:0 ->1 (6 sec)
IDLE:OFF test | PASS | OFF: 1->22| RET:1 ->1 (21 sec)
IDLE:RET test | PASS | OFF: 22->22| RET:1 ->24 (21 sec)

SDP3430 (ES3.1):
SUSPEND:OFF test | PASS | OFF: 0->1| RET:0 ->0 (7 sec) 

SUSPEND:RET test | PASS | OFF: 1->1| RET:0 ->1 (6 sec) 

IDLE:OFF test | PASS | OFF: 1->21| RET:1 ->1 (22 sec) 

IDLE:RET test | PASS | OFF: 21->21| RET:1 ->23 (21 sec)

Beagle C1 (ES3.0):
SUSPEND:OFF test | FAIL | OFF: 0->0| RET:0 ->0 (6 sec) 

SUSPEND:RET test | FAIL | OFF: 0->0| RET:0 ->0 (6 sec) 

IDLE:OFF test | FAIL | OFF: 0->0| RET:0 ->0 (21 sec) 

IDLE:RET test | FAIL | OFF: 0->0| RET:0 ->0 (21 sec)


-- 
Regards,
Nishanth Menon
