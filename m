From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] OMAP2420 IO map: fix IVA map
Date: Thu, 03 Dec 2009 01:15:55 -0700
Message-ID: <20091203081337.1004.51309.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60921 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbZLCIQt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 03:16:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

2420 boots currently complain:

[    0.000000] BUG: mapping for 0x58000000 at 0xe0000000 overlaps vmalloc space
[    0.000000] BUG: mapping for 0x59000000 at 0xe1000000 overlaps vmalloc space
[    0.000000] BUG: mapping for 0x5a000000 at 0xe2000000 overlaps vmalloc space

This short series clarifies that the current IVA address macros are 2420-only,
and moves the mapping out of vmalloc space.

Boot-tested on N800.

- Paul

---

Paul Walmsley (2):
      OMAP2xxx IO mapping: mark DSP mappings as being 2420-only
      OMAP2420 IO mapping: move IVA mapping virtual address out of vmalloc space


 arch/arm/mach-omap2/io.c             |   18 +++++++++--------
 arch/arm/plat-omap/include/plat/io.h |   36 +++++++++++++++-------------------
 arch/arm/plat-omap/io.c              |   12 ++++++-----
 3 files changed, 31 insertions(+), 35 deletions(-)

