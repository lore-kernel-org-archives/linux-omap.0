From: public.avatar@gmail.com ([AvataR])
Subject: UbiFS regression(?)
Date: Sat, 07 Aug 2010 00:11:06 +0300
Message-ID: <87k4o3o39x.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49841 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964820Ab0HFVLK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 17:11:10 -0400
Received: by bwz3 with SMTP id 3so225729bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Aug 2010 14:11:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


UBI error: ubi_io_read: error -74 while reading 64 bytes from PEB 0:0, read 64 bytes
UBI error: ubi_io_read: error -74 while reading 64 bytes from PEB 0:1, read 64 bytes
.....

root=ubi0:rootfs rw rootwait ubi.mtd=4 rootfstype=ubifs

beagleboard

2.6.35-beagle-32op-08909-g8428498

last commit: 842849896627701e4c07441f2c7519aeec771058

CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_RESERVE=1
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
