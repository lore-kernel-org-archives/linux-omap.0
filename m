From: Suresh Rajashekara <suresh.raj+linuxomap@gmail.com>
Subject: Re: Physical NAND corruption due to extended use
Date: Wed, 2 Jun 2010 13:38:12 -0700
Message-ID: <AANLkTilhRJtIrKAsIY0bfMZqvuWFDWINPAVFQOwHz6q9@mail.gmail.com>
References: <74DB6405-EF4E-43CE-8AF5-353D67C98D2F@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63177 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab0FBUie convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 16:38:34 -0400
Received: by iwn6 with SMTP id 6so1460734iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Jun 2010 13:38:34 -0700 (PDT)
In-Reply-To: <74DB6405-EF4E-43CE-8AF5-353D67C98D2F@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: linux-omap@vger.kernel.org

Not sure if its of any use to you, but we had a similar situation and
we are now looking at UBI
(http://www.linux-mtd.infradead.org/doc/ubi.html). We use JFFS2 and we
are considering using it over UBI.

We had problems of data corruption in the flash so we now mount only
partitions with writable data as RW. Rest of them remain RO and gets
remounted as RW only when we want to write to it. Once written, we
mount it RO again.

Suresh

On Wed, Jun 2, 2010 at 12:14 PM, Elvis Dowson <elvis.dowson@mac.com> wr=
ote:
>
> Hi,
> =A0 =A0 =A0 I've got android-2.6.29 kernel and android-1.5r3 SDK vers=
ion running on a gumstix Overo Earth (TI OMAP 3503), and I'm using the =
platform to implement a data logging application.
>
> The partition has been configured as read-write /dev/mtd4, with a mer=
ged rootfs and system folder. There are no separate /userdata and /cach=
e partitions, all the rootfs, system, userdata and cache folders are on=
 the /dev/mtd4 partition in rw mode.
>
> Now after 3 days of extended use and continuous writing, we suspect a=
 potential corruption of the NAND device (a micron 256MB FLASH, 256MB R=
AM POP module). Has anyone else found micron NAND devices to get corrup=
ted due to extended use?
>
> What options should I consider if I want to run my application from N=
AND and write data to the on-board NAND, and run the application reliab=
ly without corrupting the NAND device for at least 5 years? I am using =
the YAFFS2 filesystem.
>
> Best regards,
>
> Elvis Dowson
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
