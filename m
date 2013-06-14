From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
Date: Fri, 14 Jun 2013 21:31:45 +0800
Message-ID: <CACVXFVN3=hzWJEwHN5TXRoJ4mvVRVR+3=Tasw+gvLH3vsNHwUg@mail.gmail.com>
References: <20130517191304.468.73487.stgit@localhost>
	<20130517191753.468.1734.stgit@localhost>
	<CACVXFVOp6n3RhZnWD_hRxqE8a8amPA5SRWfkVhz+yCGZTtGjvQ@mail.gmail.com>
	<20130612163124.GD8164@atomide.com>
	<20130612171407.GM8164@atomide.com>
	<51B98F1E.1000006@ti.com>
	<51B99B07.1050806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:56272 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab3FNNbq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jun 2013 09:31:46 -0400
Received: by mail-ve0-f174.google.com with SMTP id oz10so459555veb.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jun 2013 06:31:45 -0700 (PDT)
In-Reply-To: <51B99B07.1050806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, Jun 13, 2013 at 6:12 PM, Sricharan R <r.sricharan@ti.com> wrote:
> On Thursday 13 June 2013 02:51 PM, Sricharan R wrote:
>> Hi Tony,
>> On Wednesday 12 June 2013 10:44 PM, Tony Lindgren wrote:
>>> * Tony Lindgren <tony@atomide.com> [130612 09:37]:
>>>> * Ming Lei <tom.leiming@gmail.com> [130603 08:34]:
>>>>> Hi,
>>>>>
>>>>> On Sat, May 18, 2013 at 3:17 AM, Tony Lindgren <tony@atomide.com> wrote:
>>>>>> We can now boot with device tree. If you don't want to update u-boot,
>>>>>> you can boot with appended DTB with the following instructions:
>>>>>>
>>>>>> 1. Make sure you have the appended DTB support in .config
>>>>>>
>>>>>>    CONFIG_ARM_APPENDED_DTB=y
>>>>>>    CONFIG_ARM_ATAG_DTB_COMPAT=y
>>>>>>    CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=y
>>>>>>
>>>>>> 2. Build the zImage
>>>>>>
>>>>>>    $ ARCH=arm CROSS_COMPILE=... make zImage
>>>>>>
>>>>>> 3. Build the device tree blobs
>>>>>>
>>>>>>    $ ARCH=arm CROSS_COMPILE=... make dtbs
>>>>>>
>>>>>> 4. Append the correct panda dtb to zImage
>>>>>>
>>>>>>    Depending on your hardware it's omap4-panda.dtb, omap4-panda-a4.dtb
>>>>>>    or omap4-panda-es.dtb.
>>>>>>
>>>>>>    $ cat arch/arm/boot/zImage arch/arm/boot/dts/omap4-panda-es.dtb > /tmp/appended
>>>>>>
>>>>>> 5. Use mkimage to produce the appended device tree uImage
>>>>>>
>>>>>>    $ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 \
>>>>>>      -n "Linux" -d /tmp/appended /tmp/uImage
>>>>> I followed the above steps and tried devicetree on Pandaboard against
>>>>> 3.10.0-rc3-next-20130528, and the board will hang during boot, but works
>>>>> well with legacy mode.
>>>>>
>>>>>          Hardware: Pandaboard A1
>>>>>          dtb: omap4-panda.dtb
>>>>>
>>>>> See 'dmesg' on below link:
>>>>>
>>>>>          http://kernel.ubuntu.com/~ming/up/panda-dts.dmesg
>>>>>
>>>> Hmm looks like it boots to init. Maybe add initcall_debug to the cmdline in
>>>> case there's some late_initcall that causes the issue. It's probably some
>>>> trivial issue causing it.
>>> Sricharan, maybe give this a quick try if you have the original pandaboard?
>>> I only have pandaboard es.
>>>
>>> Regards,
>>>
>>> Tony
>>
>> I tried your cleanup branch omap-for-v3.11/cleanup on panda board and it booted
>>  to prompt fine.
>>             Hardware: Pandaboard A1   dtb: omap4-panda.dtb
>>
>>   git pull on linux-next branch was not working though.
>>
>     Ok, tested in linux-next as well and it booted fine with DTB.
>      HW: OMAP4430ES2.1 PANDA A1 version DTB: OMAP4-PANDA.DTB
>
>     Booted with ramdisk and mmc FS
>
> commit c04efed734409f5a44715b54a6ca1b54b0ccf215
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Fri Jun 7 16:40:02 2013 +1000
>
>     Add linux-next specific files for 20130607

Looks linux-next-20130607 is broken, see below:

  LD [M]  drivers/usb/gadget/g_ncm.o
drivers/usb/musb/omap2430.c: In function 'omap2430_probe':
drivers/usb/musb/omap2430.c:571:2: error: 'musb_resources' undeclared
(first use in this function)
drivers/usb/musb/omap2430.c:571:2: note: each undeclared identifier is
reported only once for each function it appears in
drivers/usb/musb/omap2430.c:571:2: error: bit-field '<anonymous>'
width not an integer constant
drivers/usb/musb/omap2430.c:585:4: error: bit-field '<anonymous>'
width not an integer constant
make[3]: *** [drivers/usb/musb/omap2430.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [drivers/usb/musb] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2
install kernel and modules

DEPMOD  3.10.0-rc4-next-20130607+



Thanks,
-- 
Ming Lei
