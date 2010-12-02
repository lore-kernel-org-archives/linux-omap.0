From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Mainline OMAP3 breakage (and other OMAP?)
Date: Thu, 2 Dec 2010 21:14:21 +0000
Message-ID: <20101202211421.GG10461@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52742 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095Ab0LBVOh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 16:14:37 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This has been around since October:

drivers/video/omap2/vram.c: In function =E2=96=A0omap_vram_reserve_sdra=
m_memblock=E2=96=A0:
drivers/video/omap2/vram.c:573: error: =E2=96=A0MEMBLOCK_REAL_LIMIT=E2=96=
=A0 undeclared (first use in this function)
drivers/video/omap2/vram.c:573: error: (Each undeclared identifier is r=
eported only once
drivers/video/omap2/vram.c:573: error: for each function it appears in.=
)

This requires a trivial one-liner compile fix:

diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index fed2a72..a8973f0 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -570,7 +570,7 @@ void __init omap_vram_reserve_sdram_memblock(void)
 			return;
 		}
 	} else {
-		paddr =3D memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT);
+		paddr =3D memblock_alloc(size, PAGE_SIZE);
 	}
=20
 	omap_vram_add_region(paddr, size);

which restores the old behaviour before the X86 memblock changes went
in.  Yes, there may be other changes due to the ioremap stuff, but
that's really no excuse for not fixing the compile error itself.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
