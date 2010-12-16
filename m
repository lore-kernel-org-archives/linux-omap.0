From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: BeagleBoard stops at booting kernel with 2.6.37-rc5
Date: Thu, 16 Dec 2010 14:25:38 -0600
Message-ID: <AANLkTim1vzFpdOjBNDXT2cofUAS4=_G7+QtTKZdw0xDv@mail.gmail.com>
References: <D76728EE-7818-4236-83E9-B32045714912@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f171.google.com ([209.85.215.171]:39128 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218Ab0LPUZj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 15:25:39 -0500
Received: by eyg5 with SMTP id 5so2280227eyg.2
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 12:25:38 -0800 (PST)
In-Reply-To: <D76728EE-7818-4236-83E9-B32045714912@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Dec 16, 2010 at 2:19 PM, Elvis Dowson <elvis.dowson@mac.com> wr=
ote:
> Hi,
> =A0 =A0 =A0 =A0I'm working with linux mainline 2.6.37-rc5 and my cust=
om beagleboard based platform stops at booting the kernel. Is there a f=
ix for this?
>
> reading uImage
>
> 2432692 bytes read
> Booting from mmc ...
> ## Booting kernel from Legacy Image at 82000000 ...
> =A0 Image Name: =A0 Linux-2.6.37-rc5
> =A0 Image Type: =A0 ARM Linux Kernel Image (uncompressed)
> =A0 Data Size: =A0 =A02432628 Bytes =3D =A02.3 MB
> =A0 Load Address: 80008000
> =A0 Entry Point: =A080008000
> =A0 Verifying Checksum ... OK
> =A0 Loading Kernel Image ... OK
> OK
>
> Starting kernel ...
>
> Uncompressing Linux... done, booting the kernel.
>

If it stops there, double check your bootarg's as with 2.6.37+ you
might be using the omap-serial vs the old generic serial driver...
"ttyO2" (O in Omap) vs "ttyS2"..

Regards,

--=20
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
