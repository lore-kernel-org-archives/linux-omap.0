From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP1: Fix OSK5912 wake-up key by removing useless CONFIG_PM defines
Date: Thu, 23 Apr 2015 17:11:23 -0700
Message-ID: <1429834283-29683-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tkt-001-i372.relay.mailchannels.net ([174.136.5.173]:40942 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754157AbbDXAOX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2015 20:14:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

The wake-up key does not depend on CONFIG_PM, that just keeps it
from getting compiled producing the following warning:

board-osk.c:513:7: warning: unused variable =E2=80=98ret=E2=80=99 [-Wun=
used-variable]

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-osk.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/boar=
d-osk.c
index 7436d4c..8d65309d 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -441,13 +441,11 @@ static struct spi_board_info __initdata mistral_b=
oardinfo[] =3D { {
 	.chip_select		=3D 0,
 } };
=20
-#ifdef	CONFIG_PM
 static irqreturn_t
 osk_mistral_wake_interrupt(int irq, void *ignored)
 {
 	return IRQ_HANDLED;
 }
-#endif
=20
 static void __init osk_mistral_init(void)
 {
@@ -515,7 +513,7 @@ static void __init osk_mistral_init(void)
=20
 		gpio_direction_input(OMAP_MPUIO(2));
 		irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
-#ifdef	CONFIG_PM
+
 		/* share the IRQ in case someone wants to use the
 		 * button for more than wakeup from system sleep.
 		 */
@@ -529,7 +527,6 @@ static void __init osk_mistral_init(void)
 				ret);
 		} else
 			enable_irq_wake(irq);
-#endif
 	} else
 		printk(KERN_ERR "OSK+Mistral: wakeup button is awol\n");
=20
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
