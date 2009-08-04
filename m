From: "Raj Kumar E" <raj.e.kumar@stericsson.com>
Subject: Query about zoom2 board
Date: Tue, 4 Aug 2009 12:47:16 +0200
Message-ID: <B4F8E3A39D48914A917D366C2F96E7CB01C58F2B@esealmw107.eemea.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailgw3.ericsson.se ([193.180.251.60]:59273 "EHLO
	mailgw3.ericsson.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932433AbZHDKra convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 06:47:30 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all, 

I am working on OMAP zoom2 board for USB. I am making the ethernet
gadget running on the zoom2 board. As all know, There

Are 2 boards one is main board and other is debug board. 

I did the following configuration: 

Battery connected to main board 
AC supply to debug board 

Now I am able to see the output on hyper terminal. I have MCCI host side
USB drivers for Ethernet. 
So I started the ethernet gadget and did some network configuration on
zoom2 board. Now How will my host detect this ethernet gadget as when

I am making off the debug board power and insert usb cable(mini-B) on
OTG port and connecting to my PC host, it is not detecting this gadget.

The other thing is if my board is battery powered and connected to debug
board( with debug power supply off) and if i insert usb cable mini-B usb
connector on

Main board and connect this to host, i am getting "Found new hardware
OMAP 3430" but i did not get USB drivers for that.

I saw the www.omapzoom.org site but i did not find some information. 

Can somebody explain what should i do in order to get this working on
OMAP zoom2 board. 

Thanks, 
Raj. 
