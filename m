From: "Gunasekera, Nipuna" <gunasekera@ti.com>
Subject: RE: Query about zoom2 board
Date: Tue, 4 Aug 2009 18:30:44 -0500
Message-ID: <0554BEF07D437848AF01B9C9B5F0BC5D7C381E8D@dlee01.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E3A006917@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57625 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933609AbZHDXav convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 19:30:51 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n74NUl3Y015201
	for <linux-omap@vger.kernel.org>; Tue, 4 Aug 2009 18:30:52 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n74NUkU6010219
	for <linux-omap@vger.kernel.org>; Tue, 4 Aug 2009 18:30:46 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n74NUkKW005923
	for <linux-omap@vger.kernel.org>; Tue, 4 Aug 2009 18:30:46 -0500 (CDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E3A006917@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Depending on the revision of your Zoom2 board, the configuration of powering the debug board may not work as it will not enable the USB-OTG port.  You may have to power the Zoom2 device directly with a battery connected to enable USB OTG port.

An explanation on this is available at this page here:
https://omapzoom.org/gf/project/omapzoom/wiki/?pagename=FAQ-6%3A_ZOOM_II_GettingUSBOTG_PortToWork

There is also a "power connection scenarios" page for Zoom2 here:
https://omapzoom.org/gf/project/omapzoom/wiki/?pagename=FAQ-5%3A+Zoom-II+power+connection+scenarios

Best Regards -Nipuna

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Raj Kumar E
Sent: Tuesday, August 04, 2009 5:47 AM
To: linux-omap@vger.kernel.org
Subject: Query about zoom2 board

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
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

