From: Arno Steffen <arno.steffen@googlemail.com>
Subject: omap3 flash issue
Date: Mon, 12 Jul 2010 09:39:09 +0200
Message-ID: <AANLkTine_dbw7RW8VLIPX8E047FyYdW5jogqetGr9xjt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38836 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330Ab0GLHjL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jul 2010 03:39:11 -0400
Received: by bwz1 with SMTP id 1so2134084bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 12 Jul 2010 00:39:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

While doing powercycles with an OMAP3 board I got several strange
effects on my board.
So even when mounting the root-partiton as read only ( ... noinitrd
root=/dev/mtdblock6 ro rootfstype=jffs2 ... ) I 've got sometimes (1
in a 100  trials) a bunch of message while mounting:

jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00260000:
0xff30 instead
And later on
JFFS2 notice: (365) jffs2_get_inode_nodes: Node header CRC failed at
0x260090. {6144,773c,840fc11a,cc0c0e28}

Another time I get a
uncorrectable error :
Which is coming from nand_ecc.c (this is below the filesystem I guess).

The strange thing is, this errors/messages are disappeared in the next boot.

I suspected the RAM/Flash hardware but on the other hand it unpacks
the kernel a few 100 times, but never get a CRC error.
Looking into kernel sources I found special omap2.c with some nand
related code. I am using a standard 2.6.33 kernel.

Does someone have a good advice what the reason for that might be. Any
help is welcome.
