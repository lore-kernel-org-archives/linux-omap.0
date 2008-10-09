From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP2 not booting in 2.6.27-rc9?
Date: Thu, 9 Oct 2008 07:37:37 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810090736020.1405@utopia.booyaka.com>
References: <20081009103258.cbace620.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-138864406-1223559457=:1405"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51505 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759811AbYJINha (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 09:37:30 -0400
In-Reply-To: <20081009103258.cbace620.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-138864406-1223559457=:1405
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Jarkko,

On Thu, 9 Oct 2008, Jarkko Nikula wrote:

> At least N810 hangs somewhere executing local_flush_tlb_all() in
> omap_map_sram. Last printk is before that call.

does the following patch fix the problem for you?

- Paul

Author: Paul Walmsley <paul@pwsan.com>
Date:   Thu Oct 9 07:27:38 2008 -0600

    Commit 1c957036bbd912322793da676d05e169abf24782 breaks booting on
    OMAP2; the SRAM is mapped on top of the L4 interconnect.  This causes
    the system to hang early in boot in omap_map_sram() during a TLB flush.
    Fix by moving SRAM elsewhere in the memory map.
   =20
    Reported by Jarkko Nikula <jarkko.nikula@nokia.com>.  This patch is a
    collaboration with Tony Lindgren <tony@atomide.com> and
    Kevin Hilman <khilman@deeprootsystems.com>.
   =20
    Tested on 2430SDP.
   =20
    Signed-off-by: Paul Walmsley <paul@pwsan.com>
    Cc: Kevin Hilman <khilman@deeprootsystems.com>
    Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
    Cc: Tony Lindgren <tony@atomide.com>
    Cc: M=E5ns Rullg=E5rd <mans@mansr.com>

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 853048d..ca4c276 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -37,8 +37,8 @@
 #define OMAP1_SRAM_VA=09=09VMALLOC_END
 #define OMAP2_SRAM_PA=09=090x40200000
 #define OMAP2_SRAM_PUB_PA=090x4020f800
-#define OMAP2_SRAM_VA=09=09VMALLOC_END
-#define OMAP2_SRAM_PUB_VA=09(VMALLOC_END + 0x800)
+#define OMAP2_SRAM_VA=09=090xe1000000
+#define OMAP2_SRAM_PUB_VA=09(OMAP2_SRAM_VA + 0x800)
 #define OMAP3_SRAM_PA           0x40200000
 #define OMAP3_SRAM_VA           0xd7000000
 #define OMAP3_SRAM_PUB_PA       0x40208000
--155748971-138864406-1223559457=:1405--
