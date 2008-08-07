From: "Ashwin Bihari" <abihari@gmail.com>
Subject: HS USB errors on OMAP3530
Date: Thu, 7 Aug 2008 14:39:36 -0400
Message-ID: <1f11a5490808071139q4498df93id8571325d5d64dbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:38154 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbYHGSjh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 14:39:37 -0400
Received: by an-out-0708.google.com with SMTP id d40so101104and.103
        for <linux-omap@vger.kernel.org>; Thu, 07 Aug 2008 11:39:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Greetings,

I've got a OMAP3530 based board on which I'm having some trouble with
HS USB transfers. I plug in a HS USB Flash drive and it is properly
detected. I can mount the drive and write any amount of data to it
without any problems. However, when I start reading from the drive,
the action halts at some random point with the USB driver indicating
that it got less data than it requested in it's transaction.

Once this failure occurs, the port gets reset and the inserted Flash
drive is "detected" again but none of the descriptors can be retrieved
to actually configure/enumerate the device. After a few more reset
cycles the process just halts. The console messages are the
following..

--- Console Messages ---
<7>usb-storage: waiting for device to settle before scanning
scsi 0:0:0:0: Direct-Access              USB DISK 2.0     PMAP PQ: 0 ANSI: 0 CCS
sd 0:0:0:0: [sda] 964608 512-byte hardware sectors (494 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] 964608 512-byte hardware sectors (494 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Assuming drive cache: write through
sda: sda1
sd 0:0:0:0: [sda] Attached SCSI removable disk
usb 1-2: reset high speed USB device using ehci-omap and address 2
usb 1-2: device descriptor read/64, error -110
usb 1-2: device descriptor read/64, error -110
usb 1-2: reset high speed USB device using ehci-omap and address 2
usb 1-2: device descriptor read/64, error -110
usb 1-2: device descriptor read/64, error -110
usb 1-2: reset high speed USB device using ehci-omap and address 2
usb 1-2: device not accepting address 2, error -110
usb 1-2: reset high speed USB device using ehci-omap and address 2
usb 1-2: device not accepting address 2, error -110
usb 1-2: USB disconnect, address 2
sd 0:0:0:0: Device offlined - not ready after error recovery
Result: hostbyte=0x01 driverbyte=0x00
end_request: I/O error, dev sda, sector 775288
end_request: I/O error, dev sda, sector 775288
Result: hostbyte=0x01 driverbyte=0x00
end_request: I/O error, dev sda, sector 775528
end_request: I/O error, dev sda, sector 775528
usb 1-2: new high speed USB device using ehci-omap and address 3
usb 1-2: device descriptor read/64, error -110
usb 1-2: device descriptor read/64, error -110
usb 1-2: new high speed USB device using ehci-omap and address 4
usb 1-2: device descriptor read/64, error -110
usb 1-2: device descriptor read/64, error -110
usb 1-2: new high speed USB device using ehci-omap and address 5
usb 1-2: device not accepting address 5, error -110
usb 1-2: new high speed USB device using ehci-omap and address 6
usb 1-2: device not accepting address 6, error -110
hub 1-0:1.0: unable to enumerate USB device on port 2
--- End Messages --

Why the writes succeed without any issues while the reads fail has me
completely stumped. I'm currently using The Linux Kernel version
2.6.24.7 from omapzoom.org with the /drivers/usb code from the latest
2.6.26 back-ported. Attempting to jump to the newest Kernel would
require some work to get my board-specific code all happy and I'm in
the process of doing that..

I would love to hear from ideas on what might be going on and what I
should be looking at to get this resolved.

Regards
~ Ashwin
