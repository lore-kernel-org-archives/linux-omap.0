From: Gregoire Gentil <gregoire@gentil.com>
Subject: Re: Super Fast Linux Boot on BeagleBoard: 300 ms from boot loader
 to shell
Date: Wed, 13 Apr 2011 08:52:06 -0700
Message-ID: <1302709926.14733.3.camel@gregoire-laptop>
References: <BANLkTim4eCSeGm6WN5NnrYWWoQu2148N7A@mail.gmail.com>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47090 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756795Ab1DMPwU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Apr 2011 11:52:20 -0400
Received: by qwk3 with SMTP id 3so392499qwk.19
        for <linux-omap@vger.kernel.org>; Wed, 13 Apr 2011 08:52:19 -0700 (PDT)
In-Reply-To: <BANLkTim4eCSeGm6WN5NnrYWWoQu2148N7A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Constantine Shulyupin <const@makelinux.com>
Cc: linux-omap@vger.kernel.org

=46irst, if the kernel is pretty empty, what's the point of booting in
300ms? What's the business case?

Secondly, there is no source on this page, no detailed paper about what
are the optimizations in x-load and kernel.

Bottom-line, I thought that the linux-omap mailing list was ad-free...

Gr=C3=A9goire


On Wed, 2011-04-13 at 17:42 +0300, Constantine Shulyupin wrote:
> Hi,
>=20
> Make Linux Software presents the fastest ever embedded Linux boot for
> 720 MHz ARM and NAND flash memory. Linux boot time is 300 millisecond=
s
> from boot loader to shell. The first goal of the project is to achiev=
e
> a minimal boot time of a minimal but functional Linux system on commo=
n
> hardware. The second goal is to provide a platform for developing mor=
e
> functional systems with shortest possible boot time.
>=20
> Video of boot process: http://www.youtube.com/watch?v=3D747XLVbTgA4
>=20
> Boot log with timestamps:
>=20
> 0.000 0.000: TI X-Loader 1.4.4ss Mar 26 2011 01:45:43
> 0.000 0.000: Optimised by www.MakeLinux.com
> 0.000 0.000: Loading
> 0.237 0.237: Running
> 0.237 0.000: CFG_LOADADDR=3D80008000
> 0.249 0.012: *(int*)CFG_LOADADDR=3De321f0d3
> 0.276 0.027: Linux version 2.6.32 (const@makelinux.com)
> 0.276 0.000: Starting application
> 0.296 0.020: BusyBox v1.16.2 hush - the humble shell
>=20
> To learn more, please visit http://www.makelinux.com/emb/fastboot/oma=
p
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
