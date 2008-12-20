From: "pramod gurav" <pramodforum@gmail.com>
Subject: I2C1 controller timed out issue
Date: Sat, 20 Dec 2008 15:34:00 +0530
Message-ID: <f502236f0812200204h1ef1df01sf79243e6e276074d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:62510 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbYLTKEC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Dec 2008 05:04:02 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

Hi,
I am working on OMAP3430 board. The kernel is linux-omap-2.6.
The twl5030 module is sitting on i2c1.
I often come across a error saying

i2c_omap i2c_omap.1: controller timed out
i2c_omap i2c_omap.1: controller timed out

This is all what appears in logs when i2c1 times out and all the
other slave devices on i2c1 stop responding. Other i2c busses(2)
work properly. if try to reboot the I2C fails to respnd in u-boot also
saying

timed out in wait_for_pin: I2C_STAT=0
I2C read failed
timed out in wait_for_pin: I2C_STAT=0
I2C read failed
timed out in wait_for_pin: I2C_STAT=0
I2C read failed

I have to to do hard reset to progress with the boot.

I gone through the changes happened to i2-omap driver in between
and tried applying the patches manually.
The problem still persists.
May be I am missing some more changes.

The i2-omap.c source is attached herewith this mail.
Somebody please suggest me on this issue if this has been seen as
a issue and if fixed.

Thanks
Pramod
