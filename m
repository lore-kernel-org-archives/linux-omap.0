From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v4 07/12] ARM: OMAP: OCM RAM: use memset_io() when clearing
 SRAM
Date: Tue, 10 Apr 2012 18:35:48 -0600
Message-ID: <20120411003545.27059.70446.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43932 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759914Ab2DKAiW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 20:38:22 -0400
In-Reply-To: <20120411003454.27059.37500.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

We currently treat the OCM RAM memory as memory that hangs off an
I/O bus, so use memset_io() to clear it rather than memset().
This also takes care of this sparse warning:

arch/arm/plat-omap/sram.c:199:9: warning: cast removes address space of expression

There is still one SRAM-related sparse warning, but it appears that
fixing it correctly will take some time and thought.

N.B., at some point, the OCM RAM IP block interface code should probably
be reimplemented as an MTD device or something similar under drivers/.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/sram.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index eec98af..6beb79c 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -196,8 +196,8 @@ static void __init omap_map_sram(void)
 	 * Looks like we need to preserve some bootloader code at the
 	 * beginning of SRAM for jumping to flash for reboot to work...
 	 */
-	memset((void *)omap_sram_base + SRAM_BOOTLOADER_SZ, 0,
-	       omap_sram_size - SRAM_BOOTLOADER_SZ);
+	memset_io(omap_sram_base + SRAM_BOOTLOADER_SZ, 0,
+		  omap_sram_size - SRAM_BOOTLOADER_SZ);
 }
 
 /*


