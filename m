From: "Wilde, Martin" <martin.wilde@apextoolgroup.com>
Subject: hang-ups, using SanDisk Extreme Pro microSD cards
Date: Thu, 15 May 2014 07:35:34 +0000
Message-ID: <93B72C021D0EAC478BEFF60E93B1934BD1D08F35@APSS051.ATG.root>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.apextoolgroup.com ([199.115.148.10]:23751 "EHLO
	mail1.apextoolgroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbaEOHfg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2014 03:35:36 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Dear All,

I am using a ISEE Igepv2 CPU board, booting from microSD card. I am using SanDisk Extreme Pro 8GByte cards.

I experience occasional hang-ups of the Linux system in different severity:

1.) System seems to hang for some seconds, but afterwards continues work with no kernel messages in this case

2.) kernel is putting out message:
[ 4211.686096] mmcblk0: error -110 sending read/write command, response 0x900, card status 0xe00
[ 4211.701538] mmcblk0: error -110 transferring data, sector 674693, nr 42, card status 0xc00

 Afterwards the Linux system is completely dead - no SSH, no ping, nothing.

The problem occurs quite often -> every 4rd to 5th reboot after a few minutes working time.

I have used the ISEE Igepv2 kernel 2.6.37-8 and Igep X-Loader 2.6.0-1 in this case with igep00x0-defconfig.

Linux system is compiled, using the Pengutronix PTXDist 2011-11-0 cross compile environment

I tried afterwards on same CPU board with  Transcend Premium 8GByte cards with no problems.

I tried with mainline kernel 3.15-rc4 and u-boot-2014-04 afterwards. Here I do not get the above messages, but still with some SanDisk cards I get a complete system hang-up. 

Same, with Transcend cards, or even some other SanDisk cards I do not have problems.

The Linux images are duplicated using a script with parted, mkfs and tar to copy the images.

Does anybody else already had such problems?

best regards,

Martin Wilde