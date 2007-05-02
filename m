From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] omap2_get_clksel(): fix suspicious assignment
Date: Wed, 2 May 2007 08:46:58 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0705020845350.19145@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


mach-omap2/clock.c contains a suspicious assignment that 
almost certainly should be a equality test, in omap2_get_clksel().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
  arch/arm/mach-omap2/clock.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap-2.6/arch/arm/mach-omap2/clock.c
@@ -651,7 +651,7 @@ static u32 omap2_get_clksel(u32 *div_sel
  		break;
  	case CM_SYSCLKOUT_SEL1:
  		div_addr = (u32)&PRCM_CLKOUT_CTRL;
-		if ((div_off == 3) || (div_off = 11))
+		if ((div_off == 3) || (div_off == 11))
  			mask= 0x3;
  		break;
  	case CM_CORE_SEL1:
