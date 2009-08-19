From: "Pagare, Abhijit" <abhijitpagare@ti.com>
Subject: [PATCH 0/2] OMAP4 Power Domain Framework
Date: Wed, 19 Aug 2009 11:48:28 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B9DCCA10@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38019 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbZHSGSf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Aug 2009 02:18:35 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "paul@pwsan.com" <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul,

I am resending the patches with the suggested changes.

This series contains patches which add the power domain framework suppo=
rt for OMAP4.

This series applies on top of v2.6.31-rc5. It applies on top of the pat=
ches sent by Rajendra Nayak for the PRM/CM1/CM2 module register offsets=
 and masks initialization.

http://www.mail-archive.com/linux-omap@vger.kernel.org/

Abhijit Pagare (3):
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ARM: OMAP4: PM: Add power domain fram=
ework.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ARM: OMAP4: PM: Refine API's for Powe=
r domain Framework Support.


=A0arch/arm/mach-omap2/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0=A0 1 +
=A0arch/arm/mach-omap2/io.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0|=A0=A0=A0 2 +-
=A0arch/arm/mach-omap2/powerdomain.c=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0      |=A0=A0=A0 3 +
=A0arch/arm/mach-omap2/powerdomains.h=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0       |=A0=A0 53 +++---
=A0arch/arm/mach-omap2/powerdomains24xx.h=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 		 |=A0=A0 18 ++
=A0arch/arm/mach-omap2/powerdomains34xx.h=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 		 |=A0=A0 18 ++
=A0arch/arm/mach-omap2/powerdomains44xx.h=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 		 |  =A0258 +++++++++++++++++++++++++
=A0arch/arm/mach-omap2/prcm.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 |=A0=A0=A0 2 +
=A0arch/arm/mach-omap2/prm.h=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 |=A0=A0 24 ++-
=A0arch/arm/plat-omap/include/mach/cpu.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0    |=A0=A0=A0 4 +-
=A0arch/arm/plat-omap/include/mach/powerdomain.h=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0          |=A0=A0=A0 4 +-
++++++++++++++++++++++++++++
arch/arm/mach-omap2/powerdomain.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0      |=A0=A0 96 +++++++++=
++++++++++++++++++++++------



Best Regards,
Abhijit Pagare
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
