From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: beagleboard expansion boards, was Trying to understand how to use new OMAP mux code
Date: Wed, 2 Jun 2010 16:06:22 +0200
Message-ID: <2305B135-F746-4734-9A68-5AE748334678@dominion.thruhere.net>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com> <20100311224812.GU2900@atomide.com> <4C062DD4.2050701@cioinfoindus.fr> <20100602112130.GG5980@atomide.com> <20100602144606.4287c438.jhnikula@gmail.com> <3BC7A992-11AB-4EBF-B7A5-4C4B1498CC58@student.utwente.nl> <20100602161418.c6af218b.jhnikula@gmail.com> <20100602135709.GK5980@atomide.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f223.google.com ([209.85.219.223]:48348 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756795Ab0FBOG0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 10:06:26 -0400
Received: by ewy23 with SMTP id 23so641269ewy.1
        for <linux-omap@vger.kernel.org>; Wed, 02 Jun 2010 07:06:25 -0700 (PDT)
In-Reply-To: <20100602135709.GK5980@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Laurent Epinat <laurent.epinat@cioinfoindus.fr>, linux-omap@vger.kernel.org


Op 2 jun 2010, om 15:57 heeft Tony Lindgren het volgende geschreven:

> * Jarkko Nikula <jhnikula@gmail.com> [100602 16:06]:
>> On Wed, 2 Jun 2010 14:56:30 +0200
>> Koen Kooi <koen@dominion.thruhere.net> wrote:
>> 
>>>> How about add-on cards for e.g. BeagleBoard? It would be nice feature
>>>> if a kernel module for that particular add-on card can do the muxing
>>>> without needing to specify them on cmdline. I.e. if you are switching
>>>> between cards there is no need to figure out new cmdline for each of
>>>> them. For me even "rootwait" is sometimes too difficult to remember :-)
>>> 
>>> What we (as in beagleboard.org) are currently doing is this:
>>> 
>>> u-boot:
>>> 
>>> http://gitorious.org/beagleboard-validation/u-boot/commit/70ed67cacbb1b7158e059b9b5d10308cce2d917a
>>> http://gitorious.org/beagleboard-validation/u-boot/commit/74f700341c656e1636221a53347caccbfc07c224
>>> 
>>> kernel:
>>> 
>>> http://gitorious.org/beagleboard-validation/linux/commit/32fb278553a4cd6126c1791d70aa33df12f73d90
>>> 
>>> It's very ugly and needs a rethink before it can get posted to here, but it works great! The plan is to do this as part of the patchset to add support for the 37xx based beagleboardXM.
>>> 
>> Problem is that amount of expansion boards is practically unlimited so
>> patching bootloader and board file could come quite maintenance effort.
>> 
>> Of course there are some lets say generic boards but bunch of in-house,
>> DIY, etc. boards and there is no point to patch common bootloader and
>> kernel board files because of them.
> 
> Just saveenv the kernel cmdline options in u-boot?

People typing 'saveenv' without checking account for like half of the RMAs for beagleboards.... 
Also, the beagleboard xM has no NAND, so I'm using a boot.scr uboot script on SD to set params. But the problem we are trying to solve is this:

"Support all beagle expansion boards mentioned in http://elinux.org/BeagleBoardPinMux#Vendor_and_Device_IDs out of the box"

That means that a user can plug in an expansion board, apply power and it will "just work". That's the case now for the zippy, zippy2, trainer and beaglefpga boards with the current u-boot and kernel setup. I agree it doesn't scale, but I haven't seen any actual effort by the beagleboard/omap3 community to make the muxing and initializing the board (i2c, spi, gpio, rtc) work completely in the kernel :(

regards,

Koen