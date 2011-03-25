From: Andy Green <andy@warmcat.com>
Subject: Re: [RFC PATCH 2/2] OMAP2+: PANDA: Fix up random or missing MAC addresses
 for eth0 and wlan0
Date: Fri, 25 Mar 2011 20:30:52 +0000
Message-ID: <4D8CFB7C.3080306@linaro.org>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com>	<20110324212737.14936.21228.stgit@otae.warmcat.com>	<78b7faad4cdc37c6b507c008fde18ef3@mail.gmail.com> <AANLkTineUsH=Qz83YKJy8YZ1KSE1si-RddQ9eBsPjMdk@mail.gmail.com>
Reply-To: andy.green@linaro.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50063 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab1CYUbA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 16:31:00 -0400
Received: by wwa36 with SMTP id 36so1801321wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 13:30:59 -0700 (PDT)
In-Reply-To: <AANLkTineUsH=Qz83YKJy8YZ1KSE1si-RddQ9eBsPjMdk@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Kridner <jkridner@beagleboard.org>
Cc: Hema Kalliguddi <hemahk@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, nicolas.pitre@linaro.org, arnd@arndb.de, David Anders <x0132446@ti.com>, Sebastien Jan <s-jan@ti.com>, tony@atomide.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

On 03/25/2011 08:13 PM, Somebody in the thread at some point said:

Hi -

> I very much like this approach.  I believed the ability to use the die
> ID to get a unique code was reasonable approach and that is why I
> didn't get an EEPROM put onto the BeagleBoard, though Gerald is
> looking at adding one on a future revision because the lack of one
> wasn't well received.  Minor questions below.

Great.  FWIW I think it'd be a lost opportunity to wire the EEPROM 
direct to the network device.  It's more flexible and powerful to regard 
the EEPROM as general "board identity storage", a way to bind 
information to the physical board.  Then you can stick any kind of 
information that you need to bind to the board in the same 25c device 
and in-kernel code can take care of discovering that data when needed on 
any subsystem that takes an interest.

> The use of the OMAP die id below makes this OMAP specific and the list
> referenced below of the devices to be referenced makes it Panda
> specific.  Is there a way to make the list board specific, but to make
> these functions that will be used across many OMAP platforms reusable?
>   I believe that this current code will result in a lot of
> cut-and-paste.  My preference is that this is accepted and that we
> make this more general when we add this to other OMAP platforms, but
> it'd be great to capture your suggestions on how to do so before those
> cut-and-paste patch sets start coming in.

Sure, I would be happy to put this stuff at OMAP platform layer for 
example if it makes sense to OMAP guys more generally.

> I just want to make sure I understand how this works.  When a new
> network device is added, if the device name matches one of the above
> listed device paths, then the die id based MAC id is applied.  This
> must be done via a device registration notifier as the registration is
> triggered when the device is detected.

That's right.  Arguably it would be better if there was a core API to 
register your board-specific uniqueness / entropy, and the drivers were 
able to use that instead of "random" ethernet address all in network 
layer.   But after wasting two weeks getting pointlessly beaten up on 
lkml largely on the question of how generic this issue is, I would 
rather restart somewhere specific where everyone can see the obvious 
benefit and if it's seen as more useful migrate it.

-Andy
