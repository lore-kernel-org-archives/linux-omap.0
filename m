From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP3 dual-mode timer: data aborts after fclk re-enable
Date: Mon, 3 Dec 2007 19:34:00 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0712031932200.25362@utopia.booyaka.com>
References: <8763zfutxw.fsf@vence.hilman.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <8763zfutxw.fsf@vence.hilman.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <kevin@hilman.org>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Kevin,

On Mon, 3 Dec 2007, Kevin Hilman wrote:

> While working with the -rt patch + HRT on OMAP3, I'm seeing are data
> aborts during the first access to any timer register after the fclk is
> (re)enabled by dm_timer_set_source().

if this looks familiar,

<1>Unhandled fault: external abort on non-linefetch (0x1028) at 0xd9032010

perhaps this temporary patch -- not for git, there is a better 
implementation in the works -- might help?


- Paul

---
 arch/arm/mach-omap2/clock.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-12-03 19:05:45.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-12-03 19:22:42.000000000 -0700
@@ -202,11 +202,11 @@
 	 * it and pull it into struct clk itself somehow.
 	 */
 	reg = clk->enable_reg;
-	if (reg == OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1) ||
-	    reg == OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2))
+	if ((((u32)reg & 0xff) >= CM_FCLKEN1) &&
+	    (((u32)reg & 0xff) <= OMAP24XX_CM_FCLKEN2))
 		other_reg = (void __iomem *)(((u32)reg & ~0xf0) | 0x10); /* CM_ICLKEN* */
-	else if (reg == OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1) ||
-		 reg == OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2))
+	else if ((((u32)reg & 0xff) >= CM_ICLKEN1) &&
+		 (((u32)reg & 0xff) <= OMAP24XX_CM_ICLKEN4))
 		other_reg = (void __iomem *)(((u32)reg & ~0xf0) | 0x00); /* CM_FCLKEN* */
 	else
 		return;
