From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/5] hwrng/ARM: OMAP: convert to use runtime PM
Date: Mon, 27 Aug 2012 17:36:06 -0600
Message-ID: <20120827232922.15045.56522.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37111 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab2H0Xir (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Aug 2012 19:38:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel@lists.infradead.org, Matt Mackall <mpm@selenic.com>

This series converts the OMAP hardware random number generator driver
to use runtime PM.  Hardware integration data is added for OMAP2xxx
systems.  I'm pretty sure this device is available on other OMAP chips
too, but may require some experimentation with the integration details.

There are still a few rough edges with this series.  Something is
still not right with the reset behavior on OMAP2430, at least.  But it
would be good to get acks from the hwrng folks for the three patches that
touch files in that directory.  Will continue with the testing process
here.


- Paul

---

Paul Walmsley (5):
      ARM: OMAP2/3: hwmod: add RNG integration data
      hwrng: OMAP: store per-device data in per-device variables, not file statics
      hwrng: OMAP: convert to use runtime PM
      ARM: OMAP: split OMAP1, OMAP2+ RNG device registration
      hwrng: OMAP: remove SoC restrictions from driver registration


 arch/arm/mach-omap1/devices.c                      |   28 +++++
 arch/arm/mach-omap2/devices.c                      |   18 +++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    1 
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    1 
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |   17 +++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   37 ++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    5 -
 arch/arm/plat-omap/Makefile                        |    3 
 arch/arm/plat-omap/devices.c                       |   92 ---------------
 drivers/char/hw_random/omap-rng.c                  |  121 ++++++++++++--------
 10 files changed, 176 insertions(+), 147 deletions(-)
 delete mode 100644 arch/arm/plat-omap/devices.c

