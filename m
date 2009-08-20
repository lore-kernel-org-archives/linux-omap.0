From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: Booting from busy box failed
Date: Wed, 19 Aug 2009 22:15:51 -0700
Message-ID: <d9ca78710908192215r2812d61u5cc627a1e6e22f15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.211.173]:55916 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbZHTFPt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 01:15:49 -0400
Received: by ywh3 with SMTP id 3so564797ywh.22
        for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2009 22:15:51 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

hi all,
i try to using linux 2.6.26-omap1 at omap3430

it's my env variable

OMAP34XX LAB # print
bootdelay=3
baudrate=115200
filesize=34a8
bootfile="uImage"
bootargs=console=ttyS2,115200n8 rw root=/dev/mmcblk0p2 rootdelay=2 mem=128M

#mmcinit
#fatload mmc 0 80300000
#bootm 80300000

******************************************
Starting System Init for OMAP3430LAB
Release: 0.1
******************************************
Saving kernel ring buffer : OK
Mounting devpts : OK
Starting syslogd : OK
Starting klogd : OK
Mounting filesystems : OK

Please press Enter to activate this console.


BusyBox v1.6.1 (2008-07-17 12:54:29 CDT) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

#

then i try to type :

# /etc/init.d/rcS
Mounting proc : mount: mounting /proc on /proc failed
Error in /proc filesystem - init aborted

hemmm any idea?

best regards,
Aldyth M
