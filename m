From: "Pagare, Abhijit" <abhijitpagare@ti.com>
Subject: [PATCH 0/3] OMAP4 Power Domain Framework
Date: Fri, 14 Aug 2009 16:24:53 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B5F01584@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49362 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678AbZHNKzA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 06:55:00 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7EAst1w011540
	for <linux-omap@vger.kernel.org>; Fri, 14 Aug 2009 05:55:01 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n7EAssrR014510
	for <linux-omap@vger.kernel.org>; Fri, 14 Aug 2009 16:24:55 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

This series contains patches which add the power domain framework suppo=
rt for OMAP4.

This series applies on top of v2.6.31-rc5. It applies on top of the pat=
ches sent by Rajendra Nayak for the PRM/CM1/CM2 module register offsets=
 and masks initialization.

http://www.mail-archive.com/linux-omap@vger.kernel.org/

Abhijit Pagare (3):
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ARM: OMAP4: PM: Add power domain fram=
ework.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ARM: OMAP4: PM: Upgrade the Makefile =
for power domain initializations.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ARM: OMAP4: PM: Refine API's for Powe=
r domain Framework Support.


=A0arch/arm/mach-omap2/io.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0=A0=A0 2 +-
=A0arch/arm/mach-omap2/powerdomain.c=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 3 +
=A0arch/arm/mach-omap2/powerdomains.h=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 53 +++---
=A0arch/arm/mach-omap2/powerdomains24xx.h=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 18 ++
=A0arch/arm/mach-omap2/powerdomains34xx.h=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 18 ++
=A0arch/arm/mach-omap2/powerdomains44xx.h=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0 259 +++++++++++++++++++++++++
=A0arch/arm/mach-omap2/prcm.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 |=A0=A0=A0 2 +
=A0arch/arm/mach-omap2/prm.h=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 |=A0=A0 24 ++-
=A0arch/arm/plat-omap/include/mach/cpu.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 4 +-
=A0arch/arm/plat-omap/include/mach/powerdomain.h=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0=A0=A0 4 +-
++++++++++++++
=A0arch/arm/mach-omap2/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0=A0=A0 2 +-
++++++++++++++++++++++++++++
arch/arm/mach-omap2/powerdomain.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 96 ++++++++++++++=
+++++++++++++++++------


Best Regards,
Abhijit Pagare

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
