From: "mohammed shareef" <mdshareef@gmail.com>
Subject: omap 0sk and mistral touchscreen..
Date: Mon, 26 May 2008 12:19:11 +0530
Message-ID: <a1d91fa0805252349w266c2f8x11377f2dce066b93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:48985 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbYEZGtN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 May 2008 02:49:13 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1047847tic.23
        for <linux-omap@vger.kernel.org>; Sun, 25 May 2008 23:49:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>, linux-omap-open-source@linux.omap.com

Dear All,

i cross-compiled the tslib for my filesystem as mentioned in:
http://linux.omap.com/pipermail/linux-omap-open-source/2005-March/003174.html

and i have put the executables in the filesystem.
when i do
/usr/X11/bin/ts_calibrate

i dont get any "calibration request" on the LCD.
But when i do:

cat /dev/input/event1

i could see that i get stuff on my host computer when i touch the
screen. which means that my toucscreen is associated with event1. i
have even set up the proper environment variables.

doing:
cat /proc/interrupts
also shows that spi interrupts incrementing on touching the screen.

cat /proc/bus/input/devices
I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="ADS784x Touchscreen"
P: Phys=spi2.0/input0
S: Sysfs=/class/input/input1
H: Handlers=mouse0 event1 ts0
B: EV=b
B: KEY=400 0 0 0 0 0 0 0 0 0 0
B: ABS=1000003

but running
ts_calibrate doesnt show any cross-hairs on the LCD.

could you tell me if am missing something?

thank you,
warm regards,
Shareef
