From: "Praveen BP" <praveenbp@mistralsolutions.com>
Subject: RE: JFFS2 Cleanmarker issue
Date: Wed, 18 Jun 2008 10:29:56 +0530
Message-ID: <200806180440.m5I4erAQ009432@mx04.mailboxcop.com>
References: <4851CBA7.3040108@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx04.mailboxcop.com ([206.125.223.74]:53139 "EHLO
	mx04.mailboxcop.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213AbYFRGdz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jun 2008 02:33:55 -0400
Received: from secure3.apollohosting.com (secure3.apollohosting.com [206.125.215.253])
	by mx04.mailboxcop.com (8.13.8/8.13.8) with ESMTP id m5I4erAQ009432
	for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2008 23:40:53 -0500
In-Reply-To: <4851CBA7.3040108@mistralsolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Suresh Rajashekara' <suresh@mistralsolutions.com>, linux-omap@vger.kernel.org

Hi Suresh,

Sorry for the delayed response. I was on leave for 3 days. 

Vinod had solved this problem when we were working in SMI. This has got
something to do with the way you generate the jffs2 image (some command line
parameter) and writing the image with nandwrite.

He will be able to help you.

Regards,
Praveen.

-----Original Message-----
From: Suresh Rajashekara [mailto:rajashekara.suresh@gmail.com] On Behalf Of
Suresh Rajashekara
Sent: Friday, June 13, 2008 6:52 AM
To: linux-omap@vger.kernel.org
Subject: JFFS2 Cleanmarker issue

Hi Everyone,

Few necessary details before I explain my issue.

Hardware I use: OMAP5912 based board
Linux: 2.6.16-rc3 (rc!!, yes)

Let me know if you guys need more details.

The issue:
I use the JFFS2 file system on the oneNAND flash. Every time I boot the 
board I see the following on the serial console (I have 
CONFIG_JFFS2_FS_DEBUG=2)

<SNIP>
jffs2_check_nand_cleanmarker(): Cleanmarker node not detected in block 
at 00000000
OOB at 00000000 was ff ff 00 19 03 03 ff ff ff ff ff 56 fe ff ff ff ff 
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
jffs_check_nand_cleanmarker returned 1
jffs2_check_oob_empty returned 1
JFFS2: Erase block at 0x00000000 is not formatted. It will be erased
jffs2_check_nand_cleanmarker(): Cleanmarker node not detected in block 
at 00020000
OOB at 00020000 was ff ff 00 19 03 03 ff ff ff ff ff 56 fe ff ff ff ff 
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
jffs_check_nand_cleanmarker returned 1
jffs2_check_oob_empty returned 1
blah..
.
blah...
.
.
</SNIP>

Getting this on the first boot, is I guess expected. But this messages 
repeats every time we reboot the board. I did some debugging and found 
that the JFFS2 driver is marking these blocks and writes the clean markers.

Since these prints were appearing on every boot, I read the oob area 
which the jffs2 driver wrote to mark the cleanmarkers. I found the data 
to be shifted. I tried Googling and also went through the GIT log 
messages to find if this was a known issue, but could not find any. Is 
this a known issue in 2.6.16-rc3.

The developers who did the initial design have chosen to format the 
partition using the nftl_format command. I read on the MTD howto that it 
should not be used. I tried replacing that with "flash_eraseall -j" and 
created the jffs2 file system using the command mkfs.jffs2 (I tried with 
the correct page size and other stuff by looking in to the datasheet) 
and wrote the jffs2 file system using the nand_write command, but none 
helped.

Could someone please point me in the right direction?

Thanks in advance,

Best Regards,
Suresh

