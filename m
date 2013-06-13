From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
Date: Thu, 13 Jun 2013 14:51:34 +0530
Message-ID: <51B98F1E.1000006@ti.com>
References: <20130517191304.468.73487.stgit@localhost> <20130517191753.468.1734.stgit@localhost> <CACVXFVOp6n3RhZnWD_hRxqE8a8amPA5SRWfkVhz+yCGZTtGjvQ@mail.gmail.com> <20130612163124.GD8164@atomide.com> <20130612171407.GM8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56693 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756164Ab3FMJWF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jun 2013 05:22:05 -0400
In-Reply-To: <20130612171407.GM8164@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ming Lei <tom.leiming@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Tony,
On Wednesday 12 June 2013 10:44 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [130612 09:37]:
>> * Ming Lei <tom.leiming@gmail.com> [130603 08:34]:
>>> Hi,
>>>
>>> On Sat, May 18, 2013 at 3:17 AM, Tony Lindgren <tony@atomide.com> wrote:
>>>> We can now boot with device tree. If you don't want to update u-boot,
>>>> you can boot with appended DTB with the following instructions:
>>>>
>>>> 1. Make sure you have the appended DTB support in .config
>>>>
>>>>    CONFIG_ARM_APPENDED_DTB=y
>>>>    CONFIG_ARM_ATAG_DTB_COMPAT=y
>>>>    CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=y
>>>>
>>>> 2. Build the zImage
>>>>
>>>>    $ ARCH=arm CROSS_COMPILE=... make zImage
>>>>
>>>> 3. Build the device tree blobs
>>>>
>>>>    $ ARCH=arm CROSS_COMPILE=... make dtbs
>>>>
>>>> 4. Append the correct panda dtb to zImage
>>>>
>>>>    Depending on your hardware it's omap4-panda.dtb, omap4-panda-a4.dtb
>>>>    or omap4-panda-es.dtb.
>>>>
>>>>    $ cat arch/arm/boot/zImage arch/arm/boot/dts/omap4-panda-es.dtb > /tmp/appended
>>>>
>>>> 5. Use mkimage to produce the appended device tree uImage
>>>>
>>>>    $ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 \
>>>>      -n "Linux" -d /tmp/appended /tmp/uImage
>>> I followed the above steps and tried devicetree on Pandaboard against
>>> 3.10.0-rc3-next-20130528, and the board will hang during boot, but works
>>> well with legacy mode.
>>>
>>>          Hardware: Pandaboard A1
>>>          dtb: omap4-panda.dtb
>>>
>>> See 'dmesg' on below link:
>>>
>>>          http://kernel.ubuntu.com/~ming/up/panda-dts.dmesg
>>>
>> Hmm looks like it boots to init. Maybe add initcall_debug to the cmdline in
>> case there's some late_initcall that causes the issue. It's probably some
>> trivial issue causing it.
> Sricharan, maybe give this a quick try if you have the original pandaboard?
> I only have pandaboard es.
>
> Regards,
>
> Tony 
 
I tried your cleanup branch omap-for-v3.11/cleanup on panda board and it booted
 to prompt fine.
            Hardware: Pandaboard A1   dtb: omap4-panda.dtb

  git pull on linux-next branch was not working though.


Regards,
 Sricharan

