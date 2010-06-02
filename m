From: Koen Kooi <koen@dominion.thruhere.net>
Subject: beagleboard expansion boards, was Trying to understand how to use new OMAP mux code
Date: Wed, 2 Jun 2010 14:56:30 +0200
Message-ID: <3BC7A992-11AB-4EBF-B7A5-4C4B1498CC58@student.utwente.nl>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com> <20100311224812.GU2900@atomide.com> <4C062DD4.2050701@cioinfoindus.fr> <20100602112130.GG5980@atomide.com> <20100602144606.4287c438.jhnikula@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f223.google.com ([209.85.219.223]:63459 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756927Ab0FBNCV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 09:02:21 -0400
Received: by ewy23 with SMTP id 23so622092ewy.1
        for <linux-omap@vger.kernel.org>; Wed, 02 Jun 2010 06:02:19 -0700 (PDT)
In-Reply-To: <20100602144606.4287c438.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Laurent Epinat <laurent.epinat@cioinfoindus.fr>, linux-omap@vger.kernel.org


Op 2 jun 2010, om 13:46 heeft Jarkko Nikula het volgende geschreven:

> On Wed, 2 Jun 2010 14:21:30 +0300
> Tony Lindgren <tony@atomide.com> wrote:
> 
>>> How can I call  omap_mux_init_signal()
>>> from external driver compiled as module ?
>>> 
>>> cause the function is not in the standard path include files
>>> and is not exported
>> 
>> You can't that's the whole idea :)
>> 
>> Instead, please do the muxing in the board-*.c file for all the
>> pins, or for the device when you initialize the platform data.
>> 
>> The muxing of pins is board specific, and doing it in the board-*.c
>> files allows us to free the memory for the unused pin data. Note
>> that you can also mux using the kernel cmdline if you have something
>> non-standard connected to your board pins.
>> 
> Side note.
> 
> How about add-on cards for e.g. BeagleBoard? It would be nice feature
> if a kernel module for that particular add-on card can do the muxing
> without needing to specify them on cmdline. I.e. if you are switching
> between cards there is no need to figure out new cmdline for each of
> them. For me even "rootwait" is sometimes too difficult to remember :-)

What we (as in beagleboard.org) are currently doing is this:

u-boot:

http://gitorious.org/beagleboard-validation/u-boot/commit/70ed67cacbb1b7158e059b9b5d10308cce2d917a
http://gitorious.org/beagleboard-validation/u-boot/commit/74f700341c656e1636221a53347caccbfc07c224

kernel:

http://gitorious.org/beagleboard-validation/linux/commit/32fb278553a4cd6126c1791d70aa33df12f73d90

It's very ugly and needs a rethink before it can get posted to here, but it works great! The plan is to do this as part of the patchset to add support for the 37xx based beagleboardXM.

regards,

Koen