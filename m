From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: USB OTG doesn't work in HOST mode on OMAP3 processor on 3.18-rc5
Date: Mon, 17 Nov 2014 16:13:59 +0100
Message-ID: <CAFqH_53hyYO9DHfhzDhYkTnimKR0FOQuUw4OGCM4myKoOJSQRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:61264 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbaKQPOB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2014 10:14:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, balbi@ti.com

 Hi all,

I'm trying to use the USB OTG driver of OMAP3 processor in HOST mode
when it's configured in dual role mode (CONFIG_USB_MUSB_DUAL_ROLE=y)

The test case that I'm trying to solve is as follows.

1) Boot the board.
2) Put the USB ID pin to ground
3) Connect a pendrive.

In such case doesn't work as expected and pendrive is never detected.

Enabling debug information, I see that the phyter (twl4030) is
constantly polling the STS_HW_CONDITIONS register, who reports:

  twl4030_usb 48070000.i2c:twl@48:twl4030-usb: HW_CONDITIONS 0x54/84; link 1

The STS_HW_CONDITIONS register reports:

Bit 2: STS_USB : 1: USB is plugged in.
Bit 4: STS_WAKEUP1: Level status of WAKEUP1 pad (active high) = nSLEEP1
Bit 6: STS_WAKEUP3: Level status of WAKEUP3 pad (active high) = CLKREQ

I guess that in this case the state machine is waiting for VBUS, and
looks for bit 7 STS_VBUS (Level status of VBUS port), but this never
occurs. Using an oscilloscope I checked VBUS level and I can confirm
that it's a 0 level.

My understand is that in this case the driver should enable VBUS but I
didn't find where is the best place to do this and why is not doing
this already. Any clue on this?

Thanks in advance,
   Enric
