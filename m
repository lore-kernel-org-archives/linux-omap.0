From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Query about zoom2 board
Date: Wed, 5 Aug 2009 00:41:00 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F58F7167@dbde02.ent.ti.com>
References: <B4F8E3A39D48914A917D366C2F96E7CB01C58F2B@esealmw107.eemea.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43864 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933343AbZHDTLW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 15:11:22 -0400
In-Reply-To: <B4F8E3A39D48914A917D366C2F96E7CB01C58F2B@esealmw107.eemea.ericsson.se>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raj Kumar E <raj.e.kumar@stericsson.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Raj
>Kumar E
>Sent: Tuesday, August 04, 2009 5:47 AM
>To: linux-omap@vger.kernel.org
>Subject: Query about zoom2 board
>
>Hi all,
>
>I am working on OMAP zoom2 board for USB. I am making the ethernet
>gadget running on the zoom2 board. As all know, There
>
>Are 2 boards one is main board and other is debug board.
>
>I did the following configuration:
>
>Battery connected to main board
>AC supply to debug board
>

All this hack was needed only on Pre production zoom2 boards.
If you have ES3.1 silicon rev of OMAP, then it's a production zoom2 board.
Only if you don't have ES3.1, then you need to worry about power supply etc.

The new zoom2 boards you can continue to connect the power to dbg board and OTG port will work.

>Now I am able to see the output on hyper terminal. I have MCCI host side
>USB drivers for Ethernet.
>So I started the ethernet gadget and did some network configuration on
>zoom2 board. Now How will my host detect this ethernet gadget as when

Gadget mode, the PC host will be able to auto detect the device. 

I have a temporary git tree with additional zoom2 support patches at [1] 
with that I have the MUSB device mode working fine. 

[1] 
http://dev.omapzoom.org/?p=vikram/omap3.git;a=summary Head: zoom2

can send you my .config file in a separate email.

>
>I am making off the debug board power and insert usb cable(mini-B) on
>OTG port and connecting to my PC host, it is not detecting this gadget.
>
>The other thing is if my board is battery powered and connected to debug
>board( with debug power supply off) and if i insert usb cable mini-B usb
>connector on
>
>Main board and connect this to host, i am getting "Found new hardware
>OMAP 3430" but i did not get USB drivers for that.
>
>I saw the www.omapzoom.org site but i did not find some information.
>
>Can somebody explain what should i do in order to get this working on
>OMAP zoom2 board.
>
>Thanks,
>Raj.
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

