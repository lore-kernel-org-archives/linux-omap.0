From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: Memory performance  / Cache problem
Date: Mon, 12 Oct 2009 13:39:20 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDD76BDF@dbde02.ent.ti.com>
References: <20091012075409.186580@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41706 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655AbZJLIKC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 04:10:02 -0400
In-Reply-To: <20091012075409.186580@gmx.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "epsi@gmx.de" <epsi@gmx.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Can you dump the first few lines of the kernel log_buf during the kerne=
l boot?

Something like this:

[    0.000000] Linux version 2.6.29-omap1-00005-gf9f407c-dirty (romit@m=
axwell) (gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203) ) #14 PREEMPT=
 Fri Oct 9 14:04:52 IST 2009
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D=
10c5387f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing instr=
uction cache
[    0.000000] Machine: OMAP ZOOM2 board
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] L2 CACHE is enabled in bootloader
[    0.000000] OMAP3430 ES3.1

It should tell you if L2 cache is enabled or not.

Thanks,
-Romit


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of epsi@gmx.de
>Sent: Monday, October 12, 2009 1:24 PM
>To: linux-omap@vger.kernel.org
>Subject: Memory performance / Cache problem
>
>I found the memory performance of newer kernels are quit poor on an EV=
M-
>Omap3 board. It works with 2-6 times performance on the old 2.6.22 ker=
nel from
>TI's PSP.
>
>Possible reasons:
>- problem in config the kernel (did omap3_evm_defconfig)
>- problem in kernel
>- kernel expects some settings from uboot, which are not done there
>
>I have tried the 2.6.29rc3 (from TI's PSP) and the 2.6.31 from git-tre=
e.
>Both behave quite simular:
>
>Transport in MByte:
>  memcpy =3D   204.073, loop4 =3D   183.212, loop1 =3D    81.693, rand=
 =3D
>4.534
>
>while the 22 kernel:
> memcpy =3D   453.932, loop4 =3D   469.934, loop1 =3D   125.031, rand =
=3D
>29.631
>
>Can someone give me help or can at least confirm that?
>Best regards
>Steffen
>--
>GRATIS f=FCr alle GMX-Mitglieder: Die maxdome Movie-FLAT!
>Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" =
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
