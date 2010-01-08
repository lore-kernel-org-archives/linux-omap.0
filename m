From: Philip Balister <philip@balister.org>
Subject: New pinmux
Date: Fri, 08 Jan 2010 10:30:35 -0500
Message-ID: <4B474F9B.9020409@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:16540 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751675Ab0AHPhT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 10:37:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I am trying to work out how to use the new pinmux code on my 
Overo+Summit system. I have a recent git running with the new pinmux 
code built. I am trying to configure the mcspi1_clk pin on the expansion 
connector as gpio_171 with the following:

root@overo:~# dmesg |grep mux

Kernel command line: console=ttyS2,115200n8 vram=12M 
omapfb.mode=dvi:1024x768MR-16@60 omapfb.debug=y omapdss.def_display=dvi 
root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait 
omap_mux=mcspi1_clk.gpio_171=0x0

And this is what happens :(

mux: Could not set signal mcspi1_clk 

mux: Setting signal i2c3_scl.i2c3_scl 0x0118 -> 0x0100

Any suggestions?

Philip
