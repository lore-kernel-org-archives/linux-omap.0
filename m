From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: musb_hdrc: usb_disconnect is not called when the USB device is
	disconnected.
Date: Mon, 12 Jul 2010 18:20:35 +0200
Message-ID: <AANLkTik34PBAF9TRK1KRy0D6xb_vdR4hCPRXGUDt1f9v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:33386 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab0GLQUg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jul 2010 12:20:36 -0400
Received: by pxi14 with SMTP id 14so1883231pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 12 Jul 2010 09:20:35 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, felipe.balbi@nokia.com

Hello,

When I disconnect an USB pendrive using twl4030 otg as host (step 2)
the usb_disconnect function is not called. OTOH if I reconnect the
device (step 3), then the usb_disconnect function is called.

Does anyone have any ideas why usb_disconnect is not called when the
device is removed?

Steps to see the feature:

Step 1 : Plug a USB pendrive:
[ 2116.491546] usb 1-1: new high speed USB device using musb_hdrc and address 6
[ 2116.751861] usb 1-1: New USB device found, idVendor=058f, idProduct=6387
[ 2116.758697] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 2116.765899] usb 1-1: Product: Mass Storage
[ 2116.770019] usb 1-1: Manufacturer: 2.0
[ 2116.773834] usb 1-1: SerialNumber: A15B7B60
[ 2116.786468] scsi4 : usb-storage 1-1:1.0
[ 2117.797332] scsi 4:0:0:0: Direct-Access     2.0      Flash Disk
  8.07 PQ: 0 ANSI: 2
[ 2117.813293] sd 4:0:0:0: [sda] 1968128 512-byte logical blocks:
(1.00 GB/961 MiB)
[ 2117.829040] sd 4:0:0:0: [sda] Write Protect is off
[ 2117.834014] sd 4:0:0:0: [sda] Mode Sense: 03 00 00 00
[ 2117.834014] sd 4:0:0:0: [sda] Assuming drive cache: write through
[ 2117.849212] sd 4:0:0:0: [sda] Assuming drive cache: write through
[ 2117.856597]  sda: sda1
[ 2117.965698] sd 4:0:0:0: [sda] Assuming drive cache: write through
[ 2117.971954] sd 4:0:0:0: [sda] Attached SCSI removable disk
[ 2118.738769] FAT: bogus number of reserved sectors
[ 2118.743621] VFS: Can't find a valid FAT filesystem on dev sda.

Step 2: Unplug the USB pendrive

[ nothing here ]

Step 3: Plug the USB pendrive:
[ 2218.820556] usb 1-1: USB disconnect, address 6
[ 2219.139831] usb 1-1: new high speed USB device using musb_hdrc and address 7
[ 2219.400146] usb 1-1: New USB device found, idVendor=058f, idProduct=6387
[ 2219.406951] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 2219.414184] usb 1-1: Product: Mass Storage
[ 2219.418304] usb 1-1: Manufacturer: 2.0
[ 2219.422119] usb 1-1: SerialNumber: A15B7B60
[ 2219.434875] scsi5 : usb-storage 1-1:1.0
[ 2220.445770] scsi 5:0:0:0: Direct-Access     2.0      Flash Disk
  8.07 PQ: 0 ANSI: 2
[ 2220.461547] sd 5:0:0:0: [sda] 1968128 512-byte logical blocks:
(1.00 GB/961 MiB)
[ 2220.476379] sd 5:0:0:0: [sda] Write Protect is off
[ 2220.481323] sd 5:0:0:0: [sda] Mode Sense: 03 00 00 00
[ 2220.481323] sd 5:0:0:0: [sda] Assuming drive cache: write through
[ 2220.497314] sd 5:0:0:0: [sda] Assuming drive cache: write through
[ 2220.504516]  sda: sda1
[ 2220.603790] sd 5:0:0:0: [sda] Assuming drive cache: write through
[ 2220.610015] sd 5:0:0:0: [sda] Attached SCSI removable disk
[ 2221.378570] FAT: bogus number of reserved sectors
[ 2221.383453] VFS: Can't find a valid FAT filesystem on dev sda.

Thanks in advance,

Enric
