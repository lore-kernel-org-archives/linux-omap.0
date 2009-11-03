From: Daniel Miller <danielrobertmiller@gmail.com>
Subject: zd1211 firmware on OMAP5912
Date: Tue, 3 Nov 2009 16:12:16 -0500
Message-ID: <a92b665b0911031312j3247031co8e8c8265908b925b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:61155 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbZKCVMM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 16:12:12 -0500
Received: by ewy3 with SMTP id 3so2426516ewy.37
        for <linux-omap@vger.kernel.org>; Tue, 03 Nov 2009 13:12:17 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I'm trying to get a Belkin F5D7050 USB wireless adapter to work with
the OMAP5912 starter kit.  I enabled the zd1211rw driver in the kernel
(2.6.32-rc2-05967-gd350540), and it appears to recognize the device
when I connect it.  It shows up as wlan0 when I do iwconfig.

The problem I'm having is that it doesn't seem to be able to find the
firmware.  I downloaded the firmware files from Sourceforge and
unpacked them in /lib/firmware/zd1211.  But when I try to bring the
interface up with ifconfig, I get the following:

/ # ifconfig wlan0 up
usb 1-1.2: firmware: requesting zd1211/zd1211b_ub
usb 1-1.2: Could not load firmware file zd1211/zd1211b_ub. Error number -2
zd1211rw 1-1.2:1.0: couldn't load firmware. Error number -2
SIOCSIFFLAGS: No such file or directory

This is the output from dmesg:

zd1211rw 1-1.2:1.0: zd_usb_init_hw()
usb 1-1.2: request_fw_file() fw name zd1211/zd1211b_ub
usb 1-1.2: firmware: requesting zd1211/zd1211b_ub
usb 1-1.2: Could not load firmware file zd1211/zd1211b_ub. Error number -2
zd1211rw 1-1.2:1.0: couldn't load firmware. Error number -2

I tried copying the zd1211 firmware folder to a couple of other
directories, like /etc/firmware/ and /usr/lib/hotplug/firmware/, but
that didn't seem to help.  I also tried loading the firmware manually,
with the following commands:

echo 1 > /sys/class/firmware/loading
cat /lib/firmware/zd1211/zd1211b_ub > /sys/class/firmware/data
echo 1 > /sys/class/firmware/loading

But after the first line, I get the following:
/bin/sh: cannot create /sys/class/firmware/loading: Directory nonexistent

Is there some other directory that I should be putting the firmware
files in?  Or have I missed some crucial step along the way?  Any help
would be greatly appreciated.

Thanks,
Daniel
