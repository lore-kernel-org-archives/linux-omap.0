From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [help] 2.6.30 can't booting
Date: Sun, 16 Aug 2009 20:12:38 +0300
Message-ID: <20090816171236.GC9923@gandalf>
References: <d9ca78710908160948y246fa71epd564903d7fbbddbb@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42236 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642AbZHPRM5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 13:12:57 -0400
Content-Disposition: inline
In-Reply-To: <d9ca78710908160948y246fa71epd564903d7fbbddbb@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tar Gz <bsdraisefromhell@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi,

On Sun, Aug 16, 2009 at 12:48:52PM -0400, Tar Gz wrote:
> Hi all,,i'm sorry if my english too bad
> 
> i try to porting linux kernel 2.6.30 from kernel.org into omap 3430
> 
> i have the problem linux kernel can't booting
> 
> 
> i'm following step by step in the omapzoom.org
> $ setenv bootargs console=ttyS3,115200n8 root=/dev/mmcblk0p2 rw
> rootdelay=1 mem=256M init=/sbin/init
> $ saveenv
> $ bootd
> 
> 
> OMAP34XX LAB # print
> bootdelay=3
> baudrate=115200
> bootargs=console=ttyS3,115200n8 root=/dev/mmcblk0p2 rootdelay=1
> mem=256M init=/sbin/init
> bootcmd=mmcinit
> bootfile="uImage"
> 
> if i'm type bootd i'm still in the konsole like this,
> OMAP34XX LAB # bootd
> OMAP34XX LAB #
> 
> any idea?

you're not reading the kernel image to memory.

is your mmc formated with FAT32 or what ?

You need to read kernel from mmc to memory and boot from there.

-- 
balbi
