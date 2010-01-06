From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: problem with n810 boot up
Date: Tue, 5 Jan 2010 21:07:48 -0600
Message-ID: <201001052107.55283.luke@dashjr.org>
References: <200912290152.16357.luke@dashjr.org> <201001051747.02221.luke@dashjr.org> <4B43F983.5050200@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from vps2.mechanicalrealm.com ([66.216.20.21]:44966 "EHLO
	zinan.dashjr.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab0AFDIK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 22:08:10 -0500
In-Reply-To: <4B43F983.5050200@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <alecrim@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Kalle Valo <kalle.valo@iki.fi>

On Tuesday 05 January 2010 08:46:27 pm Francisco Alecrim wrote:
> Luke-Jr wrote:
> > On Tuesday 05 January 2010 05:24:56 pm Francisco Alecrim wrote:
> >> Luke-Jr wrote:
> >>> Tested on Nokia N810 in Linux-OMAP tree. Mainline is not bootable yet.
> >>
> >> I'm with some problems to boot-up latest l-o(commit
> >> abb74381235a05f15a3b07e9e3831034942c67fb) with n810. The error message
> >> can be found below and full boot output in the end of email.
> >>
> >> dsme: No correct bootreason found, entering the malfunction state
> >
> > That's DSME, part of Maemo userland. You can possibly write a LD_PRELOAD
> > workaround if you want to run it anyway...
> 
> I tried but it doesn't work. I included a line to print the
> /proc/bootreason value and there is no bootreason. :P
> 
> cat: /proc/bootreason: No such file or directory
> 
> I guess that's the problem.

Yeah, that "file" isn't supposed to exist. It was a Nokia-specific hack.

> >> What rootfs do you use? Did you change initfs?
> >
> > Gentoo. I modified my initfs to chainload its init if a new kernel is
> > running.
> 
> I don't know how to do it. Could you send me yours?

special=false
if echo -n >/writetest; then
        exec >/$(uname -r).log
        exec 2>&1
        /dmesg.static
        ls -lh /dev
#       ifconfig usb0 192.168.1.2
#       mount -t proc proc proc
#               ifconfig -a
#       umount proc
#       sync

if true; then

echo A
mount -t proc proc proc
mount /dev/mmcblk0p1 /mnt/new_root || exec /bin/sh
echo B
cd /mnt/new_root
mkdir -p mnt/initfs
echo C
pivot_root . mnt/initfs
echo D
cd /
mount
sync
echo E
exec /usr/bin/chroot / /sbin/init

fi

        special=true
fi
