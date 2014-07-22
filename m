From: Michael Welling <mwelling@emacinc.com>
Subject: Re: AM3517 fails to boot 3.16-rc5 device tree kernel
Date: Mon, 21 Jul 2014 19:15:04 -0500
Message-ID: <CAO5Z=i2GcLXG1o6_xmgRgep3V+eoVE_+NgsNmPomYY8dmwf=cQ@mail.gmail.com>
References: <20140717234037.GA9660@sysresccd>
	<20140718063806.GK18374@atomide.com>
	<CAO5Z=i1WdcrwWP2F6XZimUD5ts66AsV3RrvA31g71aUJewbNJA@mail.gmail.com>
	<20140721070913.GN18374@atomide.com>
	<20140721163838.GB14362@sysresccd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:38527 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbaGVAPH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2014 20:15:07 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so8630254pdi.34
        for <linux-omap@vger.kernel.org>; Mon, 21 Jul 2014 17:15:05 -0700 (PDT)
In-Reply-To: <20140721163838.GB14362@sysresccd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, paul@pwsan.com

On Mon, Jul 21, 2014 at 11:38 AM, Michael Welling <mwelling@emacinc.com> wrote:
> On Mon, Jul 21, 2014 at 12:09:13AM -0700, Tony Lindgren wrote:
>> * Michael Welling <mwelling@emacinc.com> [140718 07:42]:
>> > On Fri, Jul 18, 2014 at 1:38 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > >
>> > > Hmm maybe double check your're booting device tree based kernel
>> > > instead of legacy machine ID based kernel? The legacy booting should
>> > > still work just fine and no changes has been made to it, but it will
>> > > get removed shortly.
>> >
>> > I downloaded the version from the test results and it did boot.
>>
>> OK that's good to hear.
>>
>> > These are combining the uImage and dtb. How do you accomplish this?
>>
>> You need to make sure you have the appended DTB support enabled like
>> we do in omap2plus_defconfig:
>>
>> CONFIG_ARM_APPENDED_DTB=y
>> CONFIG_ARM_ATAG_DTB_COMPAT=y
>> CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
>>
>> Then just cat zImage board.dtb > /tmp/zImage-dtba and run
>> mkimage to convert it to a uImage:
>>
>> $ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 \
>>       -n "Linux" -d /tmp/zImage-dtba /tmp/uImage
>>
>
> I actually discovered this and got LCD video working. Now USB host is
> not working. The only thing that registers is the OHCI/EHCI hosts.
>
> root@som3517:~# lsusb
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>
> Not sure what the problem is. The USB devices that are plugged in are
> powered but never detected.
>
> Any hints?

So I got the USB host to work on boot with additional entries in the devicetree.
Documentation/devicetree/bindings/omap-usb-host.txt

Though the devices work if plugged in at boot, any time a device is
hotplugged then
the device is not detected. It is powered very briefly and then off
without any kernel messages.

So hints from this point would be good.

>
>> Regards,
>>
>> Tony
