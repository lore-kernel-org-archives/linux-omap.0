From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: ttyO2 broken on IGEPv2 on 3.3, 3.4-rc5 or arm-soc/for-next,
 working on 3.2
Date: Sat, 6 Oct 2012 11:04:51 +0200
Message-ID: <CAFqH_52RP=E9QgGgmEQ3vuQEx32V2KsRSMn62rrto0bxAW_OEw@mail.gmail.com>
References: <20120504155255.140b4e3f@skate>
	<87397fewso.fsf@ti.com>
	<20120504175124.GI5613@atomide.com>
	<878vh78q7b.fsf@ti.com>
	<20121004180747.3b342904@skate>
	<87vcequpf7.fsf@deeprootsystems.com>
	<20121004221118.4316181d@skate>
	<CAKQ2WVp71=ULs_yK7Tkuo=8F4hATq0YCQ6RtV0ziJQQmnrib_g@mail.gmail.com>
	<20121004225704.0c08c862@skate>
	<87wqz5u97g.fsf@deeprootsystems.com>
	<CAAwP0s1+_GT=TtVKg8ARtfqDYm_AZ-D34KG_j3SLWz0yzZKJtQ@mail.gmail.com>
	<20121005101009.7ed1fe85@skate>
	<CAAwP0s2HTZNYP2qNkqnus9veh1qXH-V3gDU_qBBxRR6o2W+=OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35156 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab2JFJEw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 05:04:52 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2594617pad.19
        for <linux-omap@vger.kernel.org>; Sat, 06 Oct 2012 02:04:51 -0700 (PDT)
In-Reply-To: <CAAwP0s2HTZNYP2qNkqnus9veh1qXH-V3gDU_qBBxRR6o2W+=OA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Gregory_Cl=C3=A9ment?= <gregory.clement@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>

2012/10/5 Javier Martinez Canillas <martinez.javier@gmail.com>:
> On Fri, Oct 5, 2012 at 10:10 AM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
>>
>> On Fri, 5 Oct 2012 09:32:07 +0200, Javier Martinez Canillas wrote:
>>
>>> As Enric said, u-boot has SPL and NAND support for IGEP since
>>> v2012.10-rc1. I just tried kernel a 3.6 with u-boot v2012.10-rc2 and
>>> it works for me.
>>
>> Ok, I'll try this out.
>>
>>> But I agree that the kernel shouldn't do any assumptions about the
>>> bootloader setting correctly the omap mux. Could you please share your
>>> bootloader that makes the kernel to fail (or your IGEP NAND patches on
>>> top of u-boot U-boot 2011.12) so I can reproduce the issue and try to
>>> fix it?
>>
>> Ok, I'm using the X-Loader from git://git.igep.es/pub/scm/x-loader.git,
>> tag v1.4.4-3, on top of which I apply
>> http://git.free-electrons.com/training-materials/plain/lab-data/sysdev/u-boot/x-loader-1.4.4-3-igep-nand-support.patch
>> to add support for the NAND-based IGEPv2 rev6.
>>
>> In terms of U-Boot, I use U-Boot 2011.12, on top of which I apply
>> http://git.free-electrons.com/training-materials/plain/lab-data/sysdev/u-boot/u-boot-2011.12-igep-nand-support.patch
>> to add support for the NAND-based IGEPv2 rev6.
>>
>> To make things easier if you don't need to rebuild those, I've put
>> online pre-built binaries of X-Loader and U-Boot I'm using:
>> http://free-electrons.com/~thomas/pub/igep-serial-problem/.
>>
>> Thanks,
>>
>> Thomas
>
> Perfect, I'll try it and let you know if I find a fix for the issue.
>

Sorry if someone receives this email twice, I had some problems to
send this email and Mail Delivery Subsystem tells me
that the Delivery to the following recipient has been delayed.

Also I tried and works for me which make me think that could be a
hardware issue. Please make sure that pins 6, 8 and 9 of the J990
header are not connected. I'm noticed that some US-to-RS232 converters
had problems with this. If you use the IDC10 to DB9 cable take a look
at this article:

   http://labs.isee.biz/index.php/How_to_setup_the_IDC10_cable

If it's a hardware issue, then , why it worked before 3.2 ? Well, I'm
not sure, but maybe the mux is different for pins of uart1 that are
connected to J990 and causes the problem. If you see at the schematic
you'll see that J990

          x -  10  9 - uart1_rx
uart1_tx -   8   7 - x
gnd       -   6   5 - gnd
          x -   4   3 - uart3_tx
uart3_rx -   2   1 -x

If you use directly a IDC10-to-DB9 without cutting hires from 6 to 10
note that :

   - pin 6 of IDC10 is forced to gnd which corresponds to pin 6 of DB9
which is suposed to be used as DSR (Data Set Ready)
   - pin 8 of IDC10 is connected to uart1_tx which corresponds to pin
8 of DB9 which is suposed to be used as CTS (Clear to Send)
   - pin 9 of IDC10 is connected to uart1_rx which corresponds to pin
9 of DB9 which is suposed to be used as RI (Ring Indicator)

Regards,
    Enric
