From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: [RFC] About ARM expansion boards and others things
Date: Tue, 3 May 2011 19:25:15 +0200
Message-ID: <BANLkTimjWtqLsWA1Gthix6RZYMzNRdC7rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34951 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab1ECRZQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 13:25:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Hi guys,
I'm thinking probably in a crazy idea, I hope someone can help me or
kill definitely this idea from my mind.

I'll explain a little more, the real problem is I don't know how to
add support for an expansion board for IGEP v2 board. I see most of
boards adds the support inside the board-xxxxx.c file, for example if
the expansion board has a Touchscreen interface using ADS7846/TSC2046
they register ads7846 platform data in board-xxxx.c file. This is ok
beacause the ads7846 can be detected and if expansion board is not
present  the detection fails, but maybe other devices in expansion
board can't be detected (for example an I/O expansion). So which is
the best form to do this ?

I'm thinking in create a kernel module for the expansion board that
add all the new features, the expansion board should come with a I2C
E2PROM for board ID storage, so the idea is create an i2c driver that
reads the E2PROM and if found the Board ID inits all the expansion
board devices.

I have done a few experiments, I've created a kernel module (driver)
for a custom expansion board for IGEP v2,  the expansion board has :
   - I2C E2PROM
   - ADS7846 touch controller (spi)
   - Seiko 7.0inch LCD
   - General purpose I/O

The driver is capable to register correctly i2c and spi devices and
seems is working but I have problems with the Seiko 7.0inch LCD and
configuring the MUX from driver.

Basically I wonder if it's possible add another omap_dss_device from
kernel module to the omap DSS driver (something like
omap_dss_register_new_device). Is a good or bad idea ? Why ? Is any
reason to not export the MUX functionality to be used for other
drivers ?

All of this is a crazy idea ? What's the best form to solve the problem ?

I hope I have explained well, thanks and cheers,
   Enric
