From: <harish.hanumanthappa@wipro.com>
Subject: Unable to mount android rootfs
Date: Thu, 16 Apr 2009 18:10:56 +0530
Message-ID: <8EFA81424BDADF4EB943E5A53420D7E308D6E86A@BLR-EC-MBX03.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wipro-blr-out01.wipro.com ([203.91.198.74]:12810 "EHLO
	wipro-blr-out01.wipro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbZDPNDd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Apr 2009 09:03:33 -0400
Received: from blr-ec-aa03.wipro.com (unknown [10.201.18.42])
	by wipro-blr-out01.wipro.com (Symantec Mail Security) with ESMTP id C11D1355C005
	for <linux-omap@vger.kernel.org>; Thu, 16 Apr 2009 18:10:57 +0530 (IST)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am trying to get android up on omapzoom I.I am using the latest source
synced from android site. From the console logs captured looks like
mounting of rootfs is not mounted completely due to mmc driver errors.
Any help on how to proceed further will be appreciated

Regards
Harish.H

VFS: Mounted root (ext2 filesystem).

VFS: Mounted root (ext2 filesystem).

<6>Freeing init memory: 160K

Freeing init memory: 160K

<4>Warning: unable to open an initial console.

Warning: unable to open an initial console.

<3>init: cannot open '/initlogo.rle'

init: cannot open '/initlogo.rle'

<7>omap24xxfb_get_flipbuffers::flipping buffers =3

<3>init: cannot find '/system/bin/playmp3', disabling 'bootsound'

init: cannot find '/system/bin/playmp3', disabling 'bootsound'

sh: can't access tty; job control turned off

# <6>warning: `rild' uses 32-bit capabilities (legacy support in use)

warning: `rild' uses 32-bit capabilities (legacy support in use)

<6>mmci-omap mmci-omap.0: MMC DATA CRC

mmci-omap mmci-omap.0: MMC DATA CRC

<3>mmcblk0: error -84 transferring data

mmcblk0: error -84 transferring data

<3>end_request: I/O error, dev mmcblk0, sector 4618153

end_request: I/O error, dev mmcblk0, sector 4618153

<3>end_request: I/O error, dev mmcblk0, sector 4618161

end_request: I/O error, dev mmcblk0, sector 4618161

<3>end_request: I/O error, dev mmcblk0, sector 4618169

end_request: I/O error, dev mmcblk0, sector 4618169

<3>end_request: I/O error, dev mmcblk0, sector 4618177

end_request: I/O error, dev mmcblk0, sector 4618177

<3>end_request: I/O error, dev mmcblk0, sector 4618185

end_request: I/O error, dev mmcblk0, sector 4618185

<3>end_request: I/O error, dev mmcblk0, sector 4618193

end_request: I/O error, dev mmcblk0, sector 4618193

<3>end_request: I/O error, dev mmcblk0, sector 4618201

end_request: I/O error, dev mmcblk0, sector 4618201

<3>end_request: I/O error, dev mmcblk0, sector 4618209

end_request: I/O error, dev mmcblk0, sector 4618209

<3>end_request: I/O error, dev mmcblk0, sector 4618217

end_request: I/O error, dev mmcblk0, sector 4618217

<3>end_request: I/O error, dev mmcblk0, sector 4618225

end_request: I/O error, dev mmcblk0, sector 4618225

<3>end_request: I/O error, dev mmcblk0, sector 4618233

end_request: I/O error, dev mmcblk0, sector 4618233

<3>end_request: I/O error, dev mmcblk0, sector 4618241

end_request: I/O error, dev mmcblk0, sector 4618241

<3>end_request: I/O error, dev mmcblk0, sector 4618249

end_request: I/O error, dev mmcblk0, sector 4618249

<3>end_request: I/O error, dev mmcblk0, sector 4618257

end_request: I/O error, dev mmcblk0, sector 4618257

<3>end_request: I/O error, dev mmcblk0, sector 4618265

end_request: I/O error, dev mmcblk0, sector 4618265

<3>end_request: I/O error, dev mmcblk0, sector 4618273

end_request: I/O error, dev mmcblk0, sector 4618273

 

#                                                           
