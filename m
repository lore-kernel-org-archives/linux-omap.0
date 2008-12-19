From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: USB slightly broken
Date: Fri, 19 Dec 2008 12:25:16 +0200
Message-ID: <1229682316.18039.12.camel@tubuntu>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45935 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbYLSKZY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Dec 2008 05:25:24 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBJAPCOH005546
	for <linux-omap@vger.kernel.org>; Fri, 19 Dec 2008 04:25:22 -0600
Received: from [172.21.116.224] (v21b-dhcp-116224.ntc.nokia.com [172.21.116.224])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mBJAPGR2005619
	for <linux-omap@vger.kernel.org>; Fri, 19 Dec 2008 12:25:17 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi,

Yesterday's "Merge branch 'musb'" broke the USB slightly on our board. I
use NFS root via USB gadget ethernet and if I have the usb cable
connected when the device boots up, the network does not go up
correctly. If I disconnect and connect the cable the USB starts working.

I can't currently test this on other boards, but I will test it on
beagle later. 

g_ether gadget: high speed config #1: CDC Ethernet (ECM)
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
     device=usb0, addr=192.168.2.15, mask=255.255.255.0, gw=255.255.255.255,
     host=192.168.2.15, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=192.168.2.14, rootpath=
Looking up port of RPC 100003/2 on 192.168.2.14

(at this point the interface is up on PC side, but pings don't go through)

 Tomi


