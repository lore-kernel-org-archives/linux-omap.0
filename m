From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: 4430SDP boot failure
Date: Fri, 7 Jan 2011 14:09:17 +0530
Message-ID: <d540408e2df154cf13932e79d3a11ceb@mail.gmail.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk> <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106182023.GV7771@atomide.com> <20110106195225.GX7771@atomide.com>
 <20110106203431.GZ7771@atomide.com> <20110106205107.GI1198@n2100.arm.linux.org.uk>
 <20110106235203.GA14425@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:42343 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753832Ab1AGIjU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 03:39:20 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so16059186fxm.30
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 00:39:19 -0800 (PST)
In-Reply-To: <20110106235203.GA14425@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Friday, January 07, 2011 5:22 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; Tony Lindgren
> Subject: Re: 4430SDP boot failure

[..]
>
>
> OMAP44XX SDP # fatls mmc 0
>
>   1935000   uimage
>    149104   u-boot.bin
>     18984   mlo
>   1836636   uimage-test
>   1130288   uimage-ss
>     19040   mlo.old
> Invalid FAT entry
>
> 6 file(s), 0 dir(s)
>
> "Invalid FAT entry" ?  I don't think so.  The thing actually
> contains:
>
> -rwxr-xr-x. 1 rmk rmk 1935000 Feb  4  2010 uImage
> -rwxr-xr-x. 1 rmk rmk  149104 Feb  4  2010 u-boot.bin
> -rwxr-xr-x. 1 rmk rmk   18984 Jan  1  2000 mlo
> -rwxr-xr-x. 1 rmk rmk 1836636 Jan  6 21:35 uImage-test
> -rwxr-xr-x. 1 rmk rmk 1130288 Jan  1  2000 uImage-ss
> -rwxr-xr-x. 1 rmk rmk   19040 Feb  4  2010 mlo.old
> -rwxr-xr-x. 1 rmk rmk  154904 Jan  1  2000 u-boot.new
>

[..]

> So, uboot's FAT code can't deal with a directory larger than one
> sector
> that doesn't continue.  While we're here, lets confirm by hand that
> there's nothing wrong with the uImage-test file and it's yet again
> uboot
> being idiotic.
>

[..]

> Can we _please_ have a version of uboot for the SDP4430 platform
> which
> can be configured at runtime _and_ which is capable of DHCP/TFTP ?
> I really don't want to mess about anymore with buggy boot loaders.
Just read this thread. Looks like you are not able to boot the kernel
at all. 2.6.37 + Tony's queue booted for me without any issues.

I can give a try on 2.6.37.

TFTP is already supported on the latest bootloaders.
http://dev.omapzoom.org/?p=bootloader/u-boot.git;a=shortlog;h=refs/heads/o
map4_dev

Will send you binaries in another email.

Regards

Santosh
