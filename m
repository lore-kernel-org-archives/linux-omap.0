From: Francisco Alecrim <alecrim@gmail.com>
Subject: Re: problem with n810 boot up
Date: Wed, 06 Jan 2010 18:11:10 -0400
Message-ID: <4B450A7E.6040103@gmail.com>
References: <200912290152.16357.luke@dashjr.org> <201001051747.02221.luke@dashjr.org> <4B43F983.5050200@gmail.com> <201001052107.55283.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:42475 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820Ab0AFWLQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 17:11:16 -0500
Received: by ywh6 with SMTP id 6so17884980ywh.4
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 14:11:16 -0800 (PST)
In-Reply-To: <201001052107.55283.luke@dashjr.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Kalle Valo <kalle.valo@iki.fi>

Luke-Jr wrote:
> On Tuesday 05 January 2010 08:46:27 pm Francisco Alecrim wrote:
>> Luke-Jr wrote:
>>> On Tuesday 05 January 2010 05:24:56 pm Francisco Alecrim wrote:
>>>> What rootfs do you use? Did you change initfs?
>>> Gentoo. I modified my initfs to chainload its init if a new kernel is
>>> running.
>> I don't know how to do it. Could you send me yours?

Thanks! Now it goes to rootfs and continue the boot, but device
power-off after 10-20 seconds. There is no error message to help. :(

I did some small changes:
> 
> special=false
> if echo -n >/writetest; then
>         exec >/$(uname -r).log
>         exec 2>&1
>         /dmesg.static
>         ls -lh /dev
> #       ifconfig usb0 192.168.1.2
> #       mount -t proc proc proc
> #               ifconfig -a
> #       umount proc
> #       sync
> 
> if true; then
> 
> echo A
> mount -t proc proc proc
> mount /dev/mmcblk0p1 /mnt/new_root || exec /bin/sh
mount -t jffs2 /dev/mtdblock4 /mnt/new_root || exec /bin/sh
> echo B
> cd /mnt/new_root
> mkdir -p mnt/initfs
> echo C
> pivot_root . mnt/initfs
> echo D
> cd /
> mount
> sync
> echo E
> exec /usr/bin/chroot / /sbin/init
exec /usr/sbin/chroot / /sbin/init
> 
> fi
> 
>         special=true
> fi


Thanks,
Alecrim
