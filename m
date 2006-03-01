From: Yuh-Jye Chang <yjchang@lucent.com>
Subject: OMAP 1710 H3 USB g_ether Problem
Date: Wed, 01 Mar 2006 14:34:03 -0500
Message-ID: <4405F72B.2020804@lucent.com>
References: <4405DEBC.4090902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4405DEBC.4090902@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

  I have a OMAP 1710 H3 board. I loaded it with Linux 2.6.15 + latest 
omap patch. Loading the kernel shows no problem.
My g_ether options is following:
-------------------------------------------------------------
# USB Gadget Support
#
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_SELECTED=y
# CONFIG_USB_GADGET_NET2280 is not set
# CONFIG_USB_GADGET_PXA2XX is not set
# CONFIG_USB_GADGET_GOKU is not set
# CONFIG_USB_GADGET_LH7A40X is not set
CONFIG_USB_GADGET_OMAP=y
CONFIG_USB_OMAP=y
# CONFIG_USB_GADGET_DUMMY_HCD is not set
# CONFIG_USB_GADGET_DUALSPEED is not set
# CONFIG_USB_ZERO is not set
CONFIG_USB_ETH=m
CONFIG_USB_ETH_RNDIS=y
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FILE_STORAGE is not set
# CONFIG_USB_G_SERIAL is not set
---------------------------------------------------------------
When I modprobe the g_ether it shows
------------------------------------------------------------
Using /lib/modules/2.6.15-omap1/kernel/drivers/usb/gadget/g_ether.ko
usb0: Ethernet Gadget, version: May Day 2005
usb0: using omap_udc, OUT ep2out-bulk IN ep1in-bulk STATUS ep3in-int
usb0: MAC d2:4d:8a:2d:38:ce
usb0: HOST MAC 00:dc:c8:f7:75:05
usb0: RNDIS ready
otg: b_idle, SWITCH to gadget, ctrl 098021
isp1301_omap 0-002d: ready for dual-role USB ...
-------------------------------------------------------------
Everything seems fine. Then I use USB cable to connect the board to 
another Linux box. The linux box recognize it as
a ethernet device. After simple network configration, I ping the board 
from linux box and the board hang.

Anyone have the same problem? I have try this feature with other latest 
Linux kernel + omap patch and they all have the same problem.

Regards,
Yuh-Jye
