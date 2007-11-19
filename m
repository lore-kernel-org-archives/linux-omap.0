From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] flush I-cache after omap_sram_push()
Date: Mon, 19 Nov 2007 12:11:43 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711191208030.25712@utopia.booyaka.com>
References: <20071114083010.938764990@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429027B3E1E@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0711161223280.13378@utopia.booyaka.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274290282B603@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274290282B603@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Fri, 16 Nov 2007, Woodruff, Richard wrote:

> It probably needs to be there.  The reason for getting away is this is 
> init time stuff not so dynamic, and VIPT means there is only a chance of 
> a conflict.  On say an OMAP1 with a VIVT cache it would be a bigger 
> possible problem.
> 
> I think in our older images it was non-cached also.  In current GIT its 
> MT_MEMORY so it will be.
> 
> Its kind of low in things to do today but I might file it away to do.  
> Right now sram only has a push and no pop so its not so dynamic either.

Hi Richard,

Figured we should do this now so we don't forget about it :-)  Patch below 
is boot-tested on N800.  Want to give it a quick look and add a 
Signed-off-by?


- Paul

This patch implements a suggestion by Richard Woodruff
<r-woodruff2@ti.com>.  omap_sram_push() copies executable code into
SRAM memory.  Currently this happens before Linux executes anything
from the SRAM, so we don't have to worry about evicting any SRAM lines
from the I-cache.  But at some point in the future, the SRAM might be
used more dynamically, adding and removing code while the system is
running.  So we should ensure that the I-cache is clean or at
least up-to-date after the copy.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/plat-omap/sram.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-omap/arch/arm/plat-omap/sram.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/sram.c	2007-11-16 17:41:42.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/sram.c	2007-11-16 17:43:18.000000000 -0700
@@ -216,6 +216,7 @@
 	omap_sram_ceil -= size;
 	omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
 	memcpy((void *)omap_sram_ceil, start, size);
+	flush_icache_range((unsigned long)start, (unsigned long)(start + size));
 
 	return (void *)omap_sram_ceil;
 }
