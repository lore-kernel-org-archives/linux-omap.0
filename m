From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: External SD card on nokia n810.
Date: Sun, 17 Oct 2010 11:17:11 +0300
Message-ID: <20101017111711.36e0e5d0.jhnikula@gmail.com>
References: <AANLkTinOWCOAjrYu5SOcjkh+okAXtBGwh4Vm2xVThuzJ@mail.gmail.com>
	<20101014150637.9b499298.jhnikula@gmail.com>
	<AANLkTin8Vp7VO7n-T1QAo+mZ-YHf4ws+VnKkJoY+_HT=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52657 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab0JQIQu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 17 Oct 2010 04:16:50 -0400
Received: by ewy20 with SMTP id 20so3787215ewy.19
        for <linux-omap@vger.kernel.org>; Sun, 17 Oct 2010 01:16:48 -0700 (PDT)
In-Reply-To: <AANLkTin8Vp7VO7n-T1QAo+mZ-YHf4ws+VnKkJoY+_HT=@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Maksim A. Boyko" <maksim.a.boyko@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi

On Thu, 14 Oct 2010 17:38:01 +0400
"Maksim A. Boyko" <maksim.a.boyko@gmail.com> wrote:

> > How recent? I was able to use uSD root on N810 about 1-2 weeks ago =
with
> > linux-omap head. The 2nd slot was broken between ~mid 2009 and Aug =
2010.
>=20
> =D0=90pproximately 2-3 weeks ago. Is uSD internal mmc (/dev/mmcblk1) =
?
> How hard to fix 2nd slot?
>=20
2nd slot was fixed by the commit 214044b. I just tried and both interna=
l
mmc and external microSD (=3DuSD) are working on current l-o head 8b4b0=
15.

I used omap2plus_defconfig as a base. For cutting down the kernel size
for Nolo I disabled OMAP3 and OMAP4 support and enabled
CONFIG_KERNEL_LZMA=3Dy.

Then I enabled all CONFIG_CBUS_RETU drivers and used ttyO2 as a
console instead of ttyS2 because serial port name got recently changed.

=46YI: here is some info how to get access to N810 serial port pins.
Makes debugging much easier :-)

http://bu3sch.de/joomla/index.php/nokia-n810-serial-console


--=20
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
