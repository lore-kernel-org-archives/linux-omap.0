From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: [help] 2.6.30 can't booting
Date: Sun, 16 Aug 2009 12:48:52 -0400
Message-ID: <d9ca78710908160948y246fa71epd564903d7fbbddbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.211.173]:39676 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbZHPQxw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 12:53:52 -0400
Received: by ywh3 with SMTP id 3so3491469ywh.22
        for <linux-omap@vger.kernel.org>; Sun, 16 Aug 2009 09:53:53 -0700 (PDT)
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
