From: epsi@gmx.de
Subject: Memory performance  / Cache problem
Date: Mon, 12 Oct 2009 09:54:09 +0200
Message-ID: <20091012075409.186580@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:41791 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753549AbZJLHy6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Oct 2009 03:54:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I found the memory performance of newer kernels are quit poor on an EVM=
-Omap3 board. It works with 2-6 times performance on the old 2.6.22 ker=
nel from TI's PSP.

Possible reasons:
- problem in config the kernel (did omap3_evm_defconfig)
- problem in kernel
- kernel expects some settings from uboot, which are not done there

I have tried the 2.6.29rc3 (from TI's PSP) and the 2.6.31 from git-tree=
=2E
Both behave quite simular:

Transport in MByte:
  memcpy =3D   204.073, loop4 =3D   183.212, loop1 =3D    81.693, rand =
=3D
4.534

while the 22 kernel:
 memcpy =3D   453.932, loop4 =3D   469.934, loop1 =3D   125.031, rand =3D
29.631

Can someone give me help or can at least confirm that?
Best regards
Steffen
--=20
GRATIS f=FCr alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
