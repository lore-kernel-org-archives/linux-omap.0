From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: [help] Kernel can't booting
Date: Sun, 16 Aug 2009 13:11:06 -0400
Message-ID: <d9ca78710908161011w6b63a91an2af8d0a488493ed4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:54688 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbZHPRLF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 13:11:05 -0400
Received: by yxe5 with SMTP id 5so3075243yxe.33
        for <linux-omap@vger.kernel.org>; Sun, 16 Aug 2009 10:11:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi all,,i'm sorry if my english too bad

i try to porting linux kernel 2.6.30 from kernel.org into omap 3430

i have the problem linux kernel can't booting


i'm following step by step in the omapzoom.org
$ setenv bootargs console=ttyS3,115200n8 root=/dev/mmcblk0p2 rw
rootdelay=1 mem=256M init=/sbin/init
$ saveenv
$ bootd


OMAP34XX LAB # print
bootdelay=3
baudrate=115200
bootargs=console=ttyS3,115200n8 root=/dev/mmcblk0p2 rootdelay=1
mem=256M init=/sbin/init
bootcmd=mmcinit
bootfile="uImage"

if i'm type bootd i'm still in the konsole like this,
OMAP34XX LAB # bootd
OMAP34XX LAB #

any idea?
