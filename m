From: Roger Quadros <rogerq@ti.com>
Subject: Re: Help wanted with USB and OMAP3 off_mode
Date: Wed, 16 Jan 2013 12:00:48 +0200
Message-ID: <50F67A50.5020203@ti.com>
References: <20130109092915.1c2077b5@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46146 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757534Ab3APKBd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jan 2013 05:01:33 -0500
In-Reply-To: <20130109092915.1c2077b5@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-omap@vger.kernel.org

On 01/09/2013 12:29 AM, NeilBrown wrote:
> 
> Hi,
>  I'm trying to get off_mode working reliably on my gta04 mobile phone.
> 
> My current stumbling block is USB.  The "Option" GSM module is attached via
> USB (there is a separate transceiver chip attached to port 1 which is placed
> in OMAP_EHCI_PORT_MODE_PHY).
> 
> After a suspend/resume cycle with off_mode enabled the GSM module disappears.
> i.e. 'lsusb' doesn't see it any more and the various ttyHSxx devices don't
> exist.
> Without off mode, the modem always appears after resume.
> 
> I discovered that the registers set by:
> 
>    drivers/mfd/omap-usb-host.c
> 
> are not maintained across as suspend/resume so I added the following patch
> (which I can make a formal submission of if it looks right to others), but
> that didn't help (or didn't help enough).
> 
> If I
> 
>   echo 1 > /sys/kernel/debug/pm_debug/usbhost_pwrdm/suspend
> 
> thus keeping just the USBHOST power domain out of off_mode, the GSM module
> doesn't disappear.  So it seems that some context in the usbhost domain is
> not being save and restored.
> 
> This is as far as I can get.  Can someone suggest where I should look to find
> out what is not being saved/restored properly, and how to go about saving and
> restoring?

You need to ensure that USBHOST/TLL context is saved as per the Save and
Restore sequence see section "USBHOST/USBTLL Save-and-Restore
Management" in the OMAP Technical Reference Manual.

The basic idea there is that software does the context saving into SAR
RAM before entering OFF mode and hardware automatically restores the
context after coming out of OFF mode.

But that alone is not enough for USB host to work. We need to make sure
we have covered all the erratas. There are a number of them which are
not covered yet in mainline.

USB remote wakeup is another challenge with OMAP USB host (while in OFF
mode). The usual workaround here is to use a GPIO as a wakeup line from
the modem.

regards,
-roger

