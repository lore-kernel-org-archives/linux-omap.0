From: Kevin Hilman <khilman@mvista.com>
Subject: Re: OMAP3430: MUSB host and hot-plugging
Date: Thu, 20 Mar 2008 10:11:03 -0700
Message-ID: <8763vhpbh4.fsf@paris.hilman.org>
References: <5DF83221BE20114E9C331F665ACBC0800477C16D@dbde01.ent.ti.com>
	<8657b483f1b99c61a4d5d142a5af48ba@felipebalbi.com>
	<5DF83221BE20114E9C331F665ACBC0800477C178@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:38393 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755671AbYCTRLG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 13:11:06 -0400
In-Reply-To: <5DF83221BE20114E9C331F665ACBC0800477C178@dbde01.ent.ti.com> (Vikram Pandita's message of "Thu\, 20 Mar 2008 18\:17\:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Linux omap <linux-omap@vger.kernel.org>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

> Felipe
>
>>Sent: Thursday, March 20, 2008 6:09 PM
>>To: Pandita, Vikram
>>Cc: Kevin Hilman; Linux omap
>>Subject: RE: OMAP3430: MUSB host and hot-plugging
>>
>>
>>> If you can provide us the procedure to enable hot-plugging for MUSB on
>>> OMAP3430, we will look into this issue.
>>
>>As far as musb driver is concerned it should be just a mater of
>>building it with otg support. But as of now, I cannot get id
>>pin status to musb using twl4030.
>>
>>Maybe we still have some missing pieces on linux-omap, which I'm
>>researching on that.
>
>
>  I meant if you could pass on how you have written the hot plugging
> function/agent for MUSB.  I have not tried hot-plugging on omap.

There's no additional code.  You can reproduce this with current OMAP
git, and default omap_3430sdp_defconfig, which enables MUSB in OTG
mode.

Here's what I do:

- plug in cable (mini-A to A-female)
- boot
- after booting, plug in USB storage device.
  on my userland, hotplug does its thing, and the usb/scsi storage modules
  are loaded, and I can then access /dev/sda* 
- unplug USB key.
  kernel msgs show the disconnect happens etc.

- replug USB key --- nothing happens

- echo 'F' > /proc/driver/musb_hdrc

  USB key is detected and 'CONNECT' event happens, and I can then
  access /dev/sda* again.


Kevin
