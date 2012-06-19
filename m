From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [RESEND][PATCH v2 0/4] OMAP:IOMMU:Add L1 and L2 cache flush
Date: Tue, 19 Jun 2012 17:12:29 +0530
Message-ID: <CADysL2apkpGLcSgrTwGqYLM5k8zKH5QYDq25HEz5C7pH6+8tsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:43024 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751930Ab2FSLmc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jun 2012 07:42:32 -0400
Received: by bkcik5 with SMTP id ik5so5664621bkc.29
        for <linux-omap@vger.kernel.org>; Tue, 19 Jun 2012 04:42:29 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, tony@atomide.com

=46rom 639d8228c118f884e0d04d33331338bf9561700e Mon Sep 17 00:00:00 200=
1
=46rom: Ramesh Gupta G <grgupta@ti.com>
Date: Fri, 15 Jun 2012 17:06:14 +0530
Subject: [PATCH v2 0/4] OMAP:IOMMU:Add L1 and L2 cache flush

This patch series is second version to
- add a new cache maintenance api to flush L1 cache.
- flush both L1 and L2 caches from iommu whenever the pagetable memory
  is updated.

Added the new api support for ARMv6 and ARMv7
based on the dma functions. The implementation of the
new api is based on the approach[1] discussed some time back.

[1]http://marc.info/?l=3Dlinux-kernel&m=3D131316512713815&w=3D2

These patches have been validated on Panda Board.

Signed-off-by: Ramesh Gupta G <grgupta@ti.com>

Ramesh Gupta G (4):
=A0 ARM: new cache maintenance api for iommu mem flush
=A0 ARM: add flush_mem api for ARMv6
=A0 ARM: add flush_mem api for ARMv7
=A0 OMAP:IOMMU: flush L1 and L2 caches

=A0arch/arm/include/asm/cacheflush.h | =A0 17 +++++++++++++++++
=A0arch/arm/include/asm/glue-cache.h | =A0 =A01 +
=A0arch/arm/mm/cache-v6.S =A0 =A0 =A0 =A0 =A0 =A0| =A0 28 +++++++++++++=
+++++++++++++++
=A0arch/arm/mm/cache-v7.S =A0 =A0 =A0 =A0 =A0 =A0| =A0 21 +++++++++++++=
++++++++
=A0arch/arm/mm/proc-macros.S =A0 =A0 =A0 =A0 | =A0 =A01 +
=A0drivers/iommu/omap-iommu.c =A0 =A0 =A0 =A0| =A0 26 +++++++++--------=
---------
=A06 files changed, 77 insertions(+), 17 deletions(-)


--
regards
Ramesh Gupta G
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
