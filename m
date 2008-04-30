From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: USB EHCI issue on OMAP3 Beagle
Date: Wed, 30 Apr 2008 14:12:49 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C02E703DED@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38174 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756476AbYD3IqS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 04:46:18 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "discussion@beagleboard.org" <discussion@beagleboard.org>

Hi all,

We have USB ECHI port 1 integrated with SMSC PHY (USB 3326) on Beagle Board. I have connected a high speed Mass Storage (USB harddisk) to the port, the enumeration happens fine and I am also able to do a data transfer, but after some time, it fails with below message:

ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
# ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
hub 2-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
hub 2-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
hub 2-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
ehci-omap ehci-omap.0: port 1 reset error -110
hub 2-0:1.0: hub_port_status failed (err = -32)
hub 2-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
usb 2-1: USB disconnect, address 2
sd 0:0:0:0: [sda] Result: hostbyte=0x01 driverbyte=0x00
end_request: I/O error, dev sda, sector 226436535
Buffer I/O error on device sda1, logical block 47837202
lost page write due to I/O error on sda1
Buffer I/O error on device sda1, logical block 69593106

<so on>

I have also tried connecting a self powered HUB, this fails as well. Other USB devices like Ethernet, Mouse, Keyboard, etc fail after similarly.

We have done USB eye diagram tests and found no issues with hardware as such.

Any pointers on these should be helpful, let me know if you need any further info.

FYI, I am using drivers/usb/host/ehci-omap.c on latest OMAP GIT.

Hardware reference manual for Beagle can be found here,

http://www.beagleboard.org/uploads/Beagle_HW_Reference_Manual_A_5.pdf

Regards,
Khasim

