From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2xxx: move SRAM to fix boot hang
Date: Thu, 09 Oct 2008 17:22:22 -0600
Message-ID: <20081009232106.13509.80699.stgit@localhost.localdomain>
References: <20081009232100.13509.6688.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51396 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbYJIXX3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 19:23:29 -0400
In-Reply-To: <20081009232100.13509.6688.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, Tony Lindgren <tony@atomide.com>, =?utf-8?b?TcOlbnM=?= =?utf-8?b?UnVsbGfDpXJk?= <mans@mansr.com>

Commit 1c957036bbd912322793da676d05e169abf24782 breaks booting on
OMAP2; it causes the SRAM to be mapped on top of the L4 interconnect.
This causes the system to hang early in boot in omap_map_sram() during
the TLB flush. Fix by moving SRAM elsewhere in the memory map.

Reported by Jarkko Nikula <jarkko.nikula@nokia.com>.  This patch is a
collaboration with Tony Lindgren <tony@atomide.com> and
Kevin Hilman <khilman@deeprootsystems.com>.

Boot-tested on 2430SDP (by Paul) and N810 (by Jarkko).

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Tested-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com>
---
 arch/arm/plat-omap/sram.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 853048d..027b101 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -37,8 +37,8 @@
 #define OMAP1_SRAM_VA		VMALLOC_END
 #define OMAP2_SRAM_PA		0x40200000
 #define OMAP2_SRAM_PUB_PA	0x4020f800
-#define OMAP2_SRAM_VA		VMALLOC_END
-#define OMAP2_SRAM_PUB_VA	(VMALLOC_END + 0x800)
+#define OMAP2_SRAM_VA		0xe3000000
+#define OMAP2_SRAM_PUB_VA	(OMAP2_SRAM_VA + 0x800)
 #define OMAP3_SRAM_PA           0x40200000
 #define OMAP3_SRAM_VA           0xd7000000
 #define OMAP3_SRAM_PUB_PA       0x40208000


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
