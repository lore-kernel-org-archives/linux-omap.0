From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: USB EHCI issue on OMAP3 Beagle
Date: Wed, 30 Apr 2008 04:03:55 -0500
Message-ID: <41d9eae496265da849f18d841a20a66f@felipebalbi.com>
References: <0680EC522D0CC943BC586913CF3768C02E703DED@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60416 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbYD3JD6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 05:03:58 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C02E703DED@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: linux-omap@vger.kernel.org, discussion@beagleboard.org



On Wed, 30 Apr 2008 14:12:49 +0530, "Syed Mohammed, Khasim" <khasim@ti.com>
wrote:
> Hi all,
> 
> We have USB ECHI port 1 integrated with SMSC PHY (USB 3326) on Beagle
> Board. I have connected a high speed Mass Storage (USB harddisk) to the
> port, the enumeration happens fine and I am also able to do a data
> transfer, but after some time, it fails with below message:
> 
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> # ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> hub 2-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> hub 2-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> hub 2-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> ehci-omap ehci-omap.0: port 1 reset error -110
> hub 2-0:1.0: hub_port_status failed (err = -32)
> hub 2-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
> usb 2-1: USB disconnect, address 2
> sd 0:0:0:0: [sda] Result: hostbyte=0x01 driverbyte=0x00
> end_request: I/O error, dev sda, sector 226436535
> Buffer I/O error on device sda1, logical block 47837202
> lost page write due to I/O error on sda1
> Buffer I/O error on device sda1, logical block 69593106
> 
> <so on>
> 
> I have also tried connecting a self powered HUB, this fails as well.
Other
> USB devices like Ethernet, Mouse, Keyboard, etc fail after similarly.

is this mass storage really High Speed? If mouse and keyboard fail
similarly
it could be that you're using a full speed storage device.

>From Beagle Manual:

"NOTE: Beagle USB Host only supports HS USB (480Mbp/S). Low Speed
  and Full Speed devices are not supported unless they are connected
 through a USB Hub prior to connection to the Beagle. The OTG port
                   does support LS and FS devices."

also try applying this patch to wait a bit more for reset bit to be
cleared:

diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index 4e065e5..3b2a228 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -734,7 +734,7 @@ static int ehci_hub_control (
                         * this bit; seems too long to spin routinely...
                         */
                        retval = handshake(ehci, status_reg,
-                                       PORT_RESET, 0, 750);
+                                       PORT_RESET, 0, 1250);
                        if (retval != 0) {
                                ehci_err (ehci, "port %d reset error %d\n",
                                        wIndex + 1, retval);



-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

